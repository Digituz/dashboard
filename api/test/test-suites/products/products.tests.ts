import axios from 'axios';
import { getCredentials } from '../utils/credentials';
import imageFixtures from './images.fixture.json';
import productFixtures from './valid-products.fixture.json';
import productVersions from './update-products.scenarios.json';
import { ProductDTO } from '../../../src/products/dtos/product.dto';
import { Image } from '../../../src/media-library/image.entity';
import { executeQueries, cleanUpDatabase } from '../utils/queries';
import { ProductImageDTO } from '../../../src/products/dtos/product-image.dto';
import { ProductImage } from '../../../src/products/entities/product-image.entity';

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

  it('should be able to update products', async (done) => {
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
