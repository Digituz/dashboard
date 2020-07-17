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

    product.productVariations = product.productVariations.sort((pv1, pv2) => (pv1.sku.localeCompare(pv2.sku)));

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
    const different = differenceWith(rowsOnCreate.slice(0, rowsOnCreate.length - 1), rowsOnUpdateWithChanges, isEqual).length > 0;
    expect(different).toBe(false);
  });

  it('should be able to update products', async done => {
    for (const productVersion of productVersions) {
      await persistProduct(productVersion);
    }
    done();
  });

  async function persistProduct(productDTO: ProductDTO) {
    await axios.post(
      'http://localhost:3000/v1/products',
      productDTO,
      authorizedRequest,
    );

    const response = await axios.get(
      `http://localhost:3000/v1/products/${productDTO.sku}`,
      authorizedRequest,
    );

    const productCreated = response.data;

    expect(productCreated.sku).toBe(productDTO.sku);

    if (productDTO.productVariations?.length > 0) {
      expect(productCreated.productVariations?.length).toBe(
        productDTO.productVariations.length,
      );
      expect(productCreated.withoutVariation).toBe(false);
    } else {
      expect(productCreated.productVariations?.length).toBe(1);
      const noVariation = productCreated.productVariations[0];
      expect(noVariation.sku).toBe(productDTO.sku);
      expect(noVariation.noVariation).toBe(true);
    }

    if (productDTO.productImages) {
      validateImages(productCreated.productImages, productDTO.productImages);
    } else {
      expect(productCreated.productImages).toBeOneOf([[], undefined]);
    }
  }

  validFixtures.forEach((validFixture: ProductDTO) => {
    it(`to be able to create valid products (${validFixture.sku})`, async () => {
      await persistProduct(validFixture);
    });
  });
});
