import { Injectable } from '@nestjs/common';
import Shopify, { IProductVariant } from 'shopify-api-node';
import { Product } from '../../products/entities/product.entity';
import { categoryDescription } from '../../products/entities/product-category.enum';
import { ProductsService } from '../../products/products.service';

@Injectable()
export class ShopifyService {
  private shopify: Shopify;

  constructor(private productsService: ProductsService) {
    this.shopify = new Shopify({
      shopName: 'frida-kahlo-loja-oficial',
      apiKey: '8a0409e54fa50f6e15a744fd24036971',
      password: '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',
    });
  }

  async syncProduct(product: Product) {
    // 1. map product to shopify structure
    const shopifyProduct = {
      sku: product.sku,
      metafields_global_title_tag: product.title,
      metafields_global_description_tag: product.description,
      title: product.title,
      body_html: product.productDetails,
      vendor: 'Frida Kahlo',
      product_type: categoryDescription(product.category),
      images: product.productImages.map(image => ({
        src: image.image.originalFileURL,
      })),
      published: product.isActive,
      variants: product.productVariations.map(variation => ({
        option1: variation.description,
        price: product.sellingPrice,
        sku: variation.sku,
        inventory_management: 'shopify',
      })),
    };

    // 2. persist on Shopify
    let response;
    if (product.shopifyId) {
      response = await this.shopify.product.update(
        product.shopifyId,
        shopifyProduct,
      );
    } else {
      response = await this.shopify.product.create(shopifyProduct);
      product.shopifyId = response.id;
      await this.productsService.updateProductProperties(product.id, {
        shopifyId: response.id,
      });
    }

    // 3. fill product variations with shopify ids
    response.variants.forEach((variant: IProductVariant) => {
      const productVariation = product.productVariations.find(
        pv => variant.sku === pv.sku,
      );
      productVariation.shopifyId = variant.id;
      productVariation.shopifyInventoryId = variant.inventory_item_id;
    });
  }

  async syncProducts() {
    const products = await this.productsService.findAll();
    console.log(`${products.length} produtos encontrados`);
    const syncJobs = products.map((product, idx) => {
      return new Promise(res => {
        setTimeout(async () => {
          await this.syncProduct(product);
          console.log(`${idx} - ${product.sku} sincronizado`);
          res();
        }, idx * 550);
      });
    });
    await Promise.all(syncJobs);

    console.log('finished updating product information');
    console.log('starting to update inventory');

    const allVariations = products.flatMap(product => {
      const { productVariations } = product;
      return [...productVariations];
    });

    allVariations.map((pv, idx) => {
      return new Promise(res => {
        setTimeout(async () => {
          // 4. save shopify ids
          await this.productsService.updateVariationProperty(pv.id, {
            shopifyId: pv.shopifyId,
            shopifyInventoryId: pv.shopifyInventoryId,
          });

          // 5. update inventory on Shopify
          await this.shopify.inventoryLevel.set({
            location_id: 53361180827,
            inventory_item_id: parseInt(pv.shopifyInventoryId.toString()),
            available: pv.currentPosition,
          });

          console.log(`${pv.sku} inventory updated on shopify`);

          res();
        }, 550 * idx);
      });
    });
    await Promise.all(allVariations);
  }
}
