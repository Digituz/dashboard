import { Injectable } from '@nestjs/common';
import meli from 'mercadolibre';
import { KeyValuePairService } from '../../key-value-pair/key-value-pair.service';
import { Product } from '../../products/entities/product.entity';
import { ProductsService } from '../../products/products.service';

const ML_REDIRECT_URL = 'https://digituz.com.br/api/v1/mercado-livre';
const ML_CLIENT_ID = '6962689565848218';
const ML_CLIENT_SECRET = '0j9pICVyBzxaQ8zGI4UdGlj5HkjWXn6Q';
const ML_REFRESH_TOKEN_KEY = 'ML_REFRESH_TOKEN';
const ML_ACCESS_TOKEN_KEY = 'ML_ACCESS_TOKEN';
const ML_SITE_ID = 'MLB';
const REFRESH_RATE = 3 * 60 * 60 * 1000; // every three hours

@Injectable()
export class MercadoLivreService {
  private mercadoLivre;
  private mercadoLivreCategoryMapping: any = {};

  constructor(
    private keyValuePairService: KeyValuePairService,
    private productsService: ProductsService,
  ) {}

  async onModuleInit(): Promise<void> {
    const rt = await this.keyValuePairService.get(ML_REFRESH_TOKEN_KEY);
    const at = await this.keyValuePairService.get(ML_ACCESS_TOKEN_KEY);
    this.mercadoLivre = new meli.Meli(
      ML_CLIENT_ID,
      ML_CLIENT_SECRET,
      at?.value,
      rt?.value,
    );

    if (rt && at) {
      this.startRefreshingTokens();
    }
  }

  private refreshTokens() {
    this.mercadoLivre.refreshAccessToken((err, res) => {
      if (err) return console.error(err);
      console.log(res);
      console.log('mercado livre access token refreshed successfully');
    });
  }

  private startRefreshingTokens() {
    this.refreshTokens();
    setInterval(() => {
      this.refreshTokens();
    }, REFRESH_RATE);
  }

  getAuthURL(): string {
    return this.mercadoLivre.getAuthURL(ML_REDIRECT_URL);
  }

  fetchTokens(code: string) {
    this.mercadoLivre.authorize(code, ML_REDIRECT_URL, (err, res) => {
      if (err) throw new Error(err);

      const refreshToken = res.refresh_token;
      const accessToken = res.access_token;

      this.keyValuePairService.set({
        key: ML_REFRESH_TOKEN_KEY,
        value: refreshToken,
      });

      this.keyValuePairService.set({
        key: ML_ACCESS_TOKEN_KEY,
        value: accessToken,
      });

      this.startRefreshingTokens();
    });
  }

  async createProducts() {
    const products = await this.productsService.findAll();
    const activeNoVariationProducts = products.filter(product => {
      return (
        product.productVariations.length === 1 &&
        product.isActive &&
        !product.mercadoLivreId &&
        product.mercadoLivreCategoryId &&
        product.productImages?.length > 0
      );
    });
    const createJobs = activeNoVariationProducts.map((product, idx) => {
      return new Promise((res, rej) => {
        setTimeout(async () => {
          const mlProduct = await this.mapToMLProduct(product);
          this.mercadoLivre.post('items', mlProduct, async (err, response) => {
            if (err) return rej(err);
            if (!response.id) return rej(`Unable to create ${product.sku} on Mercado Livre.`);
            product.mercadoLivreId = response.id;
            await this.productsService.updateProductProperties(product.id, {
              mercadoLivreId: response.id,
            });
            console.log(`${product.sku} created successfully`);
            res();
          });
        }, idx * 250);
      });
    });
    await Promise.all(createJobs);
  }

  private async mapToMLProduct(product: Product) {
    const productImages = product.productImages.map(pi => ({
      source: pi.image.largeFileURL,
    }));

    return product.variationsSize > 1
      ? this.mapProductWithVariationsForCreation(product, productImages)
      : this.mapProductWithoutVariationsForCreation(product, productImages);
  }

  private mapProductWithoutVariationsForCreation(
    product: Product,
    productImages: { source: string }[],
  ) {
    const singleVariation = product.productVariations[0];

    return {
      category_id: product.mercadoLivreCategoryId,
      description: {
        plain_text: product.description,
      },
      condition: 'new',
      buying_mode: 'buy_it_now',
      available_quantity: singleVariation.currentPosition,
      pictures: productImages,
      price: singleVariation.sellingPrice,
      currency_id: 'BRL',
      tags: ['immediate_payment'],
      // subtitle: null, // TODO ml-integration check is valuable?
      sale_terms: [], // TODO ml-integration check is valuable?
      title: 'Item de Teste - Por favor, NÃO OFERTAR!', // TODO ml-integration fix
      listing_type_id: 'silver', // TODO ml-integration fix (gold_special, gold_pro, silver)
      shipping: null, // TODO ml-integration fix
      // payment_method: null, // TODO ml-integration fix (needed?)
      attributes: [
        {
          id: 'BRAND',
          value_name: 'Frida Kahlo',
        },
        {
          id: 'SELLER_SKU',
          value_name: singleVariation.sku,
        },
      ],
    };
  }

  private mapProductWithVariationsForCreation(
    product: Product,
    productImages: { source: string }[],
  ) {
    return this.mapProductWithoutVariationsForCreation(product, productImages);
    // return {
    //   sku: null, // TODO
    //   category_id: productCategory,
    //   description: product.description,
    //   condition: 'new',
    //   buying_mode: 'buy_it_now',
    //   available_quantity: singleVariation.currentPosition,
    //   pictures: productImages,
    //   price: singleVariation.sellingPrice,
    //   currency_id: 'BRL',
    //   tags: ['immediate_payment'],
    //   subtitle: null, // TODO ml-integration fix
    //   sale_terms: [], // TODO ml-integration fix
    //   warranty: '90 dias de garantia', // TODO ml-integration fix
    //   title: 'Item de Teste - Por favor, NÃO OFERTAR!', // TODO ml-integration fix
    //   listing_type_id: 'gold_special', // TODO ml-integration fix (gold_special, gold_pro)
    //   shipping: null, // TODO ml-integration fix
    //   payment_method: null, // TODO ml-integration fix (needed?)
    //   attributes: [
    //     {
    //       id: 'BRAND',
    //       value_name: 'Frida Kahlo',
    //     },
    //   ],
    //   variations: [
    //     {
    //       price: singleVariation.sellingPrice,
    //       available_quantity: singleVariation.currentPosition,
    //       pictures: null,
    //       attribute_combinations: null,
    //       attributes: [
    //         // { // TODO
    //         //   id: 'PACKAGE_HEIGHT',
    //         //   value_name: '25 cm',
    //         // },
    //         // {
    //         //   id: 'PACKAGE_WIDTH',
    //         //   value_name: '17 cm',
    //         // },
    //         {
    //           id: 'SELLER_SKU',
    //           value_name: singleVariation.sku,
    //         },
    //       ],
    //     },
    //   ],
    // };
  }
}
