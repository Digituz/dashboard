import axios from 'axios';
import { getCredentials } from '../utils/credentials';
import imageFixtures from './images.fixture.json';
import productFixtures from './valid-products.fixture.json';
import productVersions from './update-products.scenarios.json';
import { ProductDTO } from '../../../src/products/dtos/product.dto';
import { Image } from '../../../src/media-library/image.entity';
import {
  executeQueries,
  cleanUpDatabase,
  executeQuery,
} from '../utils/queries';
import { ProductImageDTO } from '../../../src/products/dtos/product-image.dto';
import { ProductImage } from '../../../src/products/entities/product-image.entity';
import { differenceWith, isEqual } from 'lodash';
import { Product } from '../../../src/products/entities/product.entity';

const validImagesFixtures: Image[] = imageFixtures;
const validFixtures: ProductDTO[] = productFixtures;

describe('persisting products', () => {
  let authorizedRequest: any;

  beforeEach(async () => {
    authorizedRequest = await getCredentials();

    await cleanUpDatabase();

    const insertImages: string[] = validImagesFixtures.map(image => {
      return `insert into image (id, main_filename, original_filename, mimetype, original_file_url,
        extra_large_file_url, large_file_url, medium_file_url, small_file_url, thumbnail_file_url,
        file_size, width, height, aspect_ratio)
        values (
          ${image.id}, '${image.mainFilename}', '${image.originalFilename}', '${image.mimetype}',
          '${image.originalFileURL}', '${image.extraLargeFileURL}', '${image.largeFileURL}',
          '${image.mediumFileURL}', '${image.smallFileURL}', '${image.thumbnailFileURL}',
          ${image.fileSize}, ${image.width}, ${image.height}, ${image.aspectRatio}
        );`;
    });
    await executeQueries(...insertImages);
  });

  function validateImages(
    currentImages: ProductImage[],
    expectedImages: ProductImageDTO[],
  ) {
    expect(currentImages?.length).toBe(expectedImages.length);
    expectedImages.forEach((expectedImage, idx) => {
      expect(currentImages[idx].image.id).toBe(expectedImage.imageId);
      expect(currentImages[idx].order).toBe(expectedImage.order);
    });
  }

  it("should not recreate inventory for variations that don't change", async () => {
    const product = productVersions.find(p => p.productVariations?.length > 1);

    product.productVariations = product.productVariations.sort((pv1, pv2) =>
      pv1.sku.localeCompare(pv2.sku),
    );

    // create product
    await persistProduct(product);
    const rowsOnCreate = await executeQuery(
      'select i.id, product_variation_id from inventory i left join product_variation pv on pv.id = product_variation_id order by pv.sku',
    );
    expect(rowsOnCreate.length).toBe(product.productVariations.length);

    // update product without changing variations
    await persistProduct(product);
    const rowsOnUpdateWithoutChanges = await executeQuery(
      'select i.id, product_variation_id from inventory i left join product_variation pv on pv.id = product_variation_id order by pv.sku',
    );
    expect(rowsOnUpdateWithoutChanges.length).toBe(
      product.productVariations.length,
    );

    // compare ids on creation and on change
    expect(
      differenceWith(rowsOnCreate, rowsOnUpdateWithoutChanges, isEqual).length,
    ).toBe(0);

    // reomve one variation and update product
    const newProductVersion = {
      ...product,
      productVariations: product.productVariations.slice(
        0,
        product.productVariations.length - 1,
      ),
    };
    await persistProduct(newProductVersion);
    const rowsOnUpdateWithChanges = await executeQuery(
      'select i.id, product_variation_id from inventory i left join product_variation pv on pv.id = product_variation_id order by pv.sku',
    );
    expect(rowsOnUpdateWithChanges.length).toBe(
      product.productVariations.length - 1,
    );

    // compare ids on creation and on last change
    const different =
      differenceWith(
        rowsOnCreate.slice(0, rowsOnCreate.length - 1),
        rowsOnUpdateWithChanges,
        isEqual,
      ).length > 0;
    expect(different).toBe(false);
  });

  it('should be able to update products', async done => {
    for (const productVersion of productVersions) {
      await persistProduct(productVersion);
    }
    done();
  });

  async function updateAndTestCategory(product, category) {
    product.category = category;
    await persistProduct(product);
    const response = await axios.get(
      `http://localhost:3005/v1/products/${product.sku}`,
      authorizedRequest,
    );
    const productCreated = response.data;
    expect(productCreated.category).toBe(category);
  }

  it('should be able to add and update categories', async () => {
    // persist product with some category (must be a valid category)
    const product: ProductDTO = productVersions[0];
    await updateAndTestCategory(product, 'BERLOQUES');
    await updateAndTestCategory(product, 'ANEIS');
    await updateAndTestCategory(product, null);
    await updateAndTestCategory(product, 'COLARES');
  });

  async function persistProduct(productDTO: ProductDTO) {
    await axios.post(
      'http://localhost:3005/v1/products',
      productDTO,
      authorizedRequest,
    );

    const response = await axios.get(
      `http://localhost:3005/v1/products/${productDTO.sku}`,
      authorizedRequest,
    );

    const productCreated: Product = response.data;

    expect(productCreated.sku).toBe(productDTO.sku);

    expect(productCreated.productVariations.length).toBe(
      productDTO.productVariations.length,
    );

    const sortedByMinimumPrice = productDTO.productVariations.sort(
      (p1, p2) => p1.sellingPrice - p2.sellingPrice,
    );
    const minimumPriceVariation = sortedByMinimumPrice[0];

    expect(productCreated.sellingPrice).toBe(
      minimumPriceVariation.sellingPrice,
    );

    for (const pv of productDTO.productVariations) {
      const persistedVariation = productCreated.productVariations.find(
        v => v.sku === pv.sku,
      );
      expect(persistedVariation.sellingPrice).toBe(pv.sellingPrice);
    }

    if (productDTO.productImages) {
      validateImages(productCreated.productImages, productDTO.productImages);
    } else {
      expect(productCreated.productImages).toBeOneOf([[], undefined]);
    }

    if (productDTO.productComposition) {
      const skusOnProductComposition = productCreated.productComposition.map(
        productComp => productComp.productVariation.sku,
      );
      productDTO.productComposition.forEach(sku => {
        expect(skusOnProductComposition.includes(sku)).toBeTrue();
      });
    }
  }

  validFixtures.forEach((validFixture: ProductDTO) => {
    it(`to be able to create valid products (${validFixture.sku})`, async () => {
      await persistProduct(validFixture);
    });
  });

  it('should properly handle products with no variations', async () => {
    const noVariation = {
      parentSku: 'FK-0001',
      sku: 'FK-0001',
      description: 'Tamanho Único',
      sellingPrice: 39.9,
    };
    const product: ProductDTO = {
      sku: 'FK-0001',
      title: 'FK-0001',
      ncm: '1234.56.78',
      productVariations: [noVariation],
    };
    await persistProduct(product);

    noVariation.sellingPrice = 49.9;

    await persistProduct(product);
  });
});
