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
    const oneProduct = products.find(product => {
      return product.productVariations.length === 1 && product.isActive;
    });
    const mlProduct = await this.mapToMLProduct(oneProduct);
    this.mercadoLivre.post(`items`, mlProduct, (err, response) => {
      if (err) return console.error(err);
      console.log(response);
    });
  }

  private async getProductCategory(product: Product): Promise<string> {
    const mlCategory = this.mercadoLivreCategoryMapping[product.category];
    if (mlCategory) return mlCategory;

    return new Promise((res, rej) => {
      this.mercadoLivre.get(
        `sites/${ML_SITE_ID}/domain_discovery/search?limit=1&q=${encodeURI(
          product.title,
        )}`,
        (err, response) => {
          if (err) return rej(err);
          if (!response[0] || !response[0].category_id)
            rej('Category not found.');
          this.mercadoLivreCategoryMapping[product.category] =
            response[0].category_id;
          res(this.mercadoLivreCategoryMapping[product.category]);
        },
      );
    });
  }

  private async mapToMLProduct(product: Product) {
    const productImages = product.productImages.map(pi => ({
      source: pi.image.largeFileURL,
    }));
    const productCategory = await this.getProductCategory(product);

    return product.variationsSize > 1
      ? this.mapProductWithVariationsForCreation(
          product,
          productImages,
          productCategory,
        )
      : this.mapProductWithoutVariationsForCreation(
          product,
          productImages,
          productCategory,
        );
  }

  private mapProductWithoutVariationsForCreation(
    product: Product,
    productImages: { source: string }[],
    productCategory: string,
  ) {
    const singleVariation = product.productVariations[0];

    return {
      category_id: productCategory,
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
    productCategory: string,
  ) {
    return this.mapProductWithoutVariationsForCreation(
      product,
      productImages,
      productCategory,
    );
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
