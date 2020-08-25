import { Injectable } from '@nestjs/common';
import Shopify from 'shopify-api-node';
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
    const shopifyProduct = {
      sku: product.sku,
      metafields_global_title_tag: product.title,
      metafields_global_description_tag: product.description,
      title: product.title,
      body_html: product.productDetails,
      vendor: 'Frida Kahlo',
      product_type: categoryDescription(product.category),
      images: product.productImages.map(image => ({ src: image.image.originalFileURL })),
      published: product.isActive,
      variants: product.productVariations.map(variation => ({
        option1: variation.description,
        price: product.sellingPrice,
        sku: variation.sku,
      })),
    };

    if (product.shopifyId) {
      await this.shopify.product.update(product.shopifyId, shopifyProduct); 
    } else {
      const response = await this.shopify.product.create(shopifyProduct);
      await this.productsService.updateProductProperties(product.id, {
        shopifyId: response.id,
      });
    }
  }

  async syncProducts() {
    const products = await this.productsService.findAll();
    const syncJobs = products.map((product, idx) => {
      return new Promise(res => {
        setTimeout(async () => {
          await this.syncProduct(product);
          console.log(`${product.sku} sincronizado`);
          res();
        }, idx * 800);
      });
    });
    await Promise.all(syncJobs);
  }
}
