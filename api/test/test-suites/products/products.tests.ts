import axios from 'axios';
import { getCredentials } from '../utils/credentials';
import imageFixtures from './images.fixture.json';
import productFixtures from './valid-products.fixture.json';
import { ProductDTO } from '../../../src/products/dtos/product.dto';
import { Image } from '../../../src/media-library/image.entity';
import { executeQueries } from '../utils/queries';

const validImagesFixtures: Image[] = imageFixtures;
const validFixtures: ProductDTO[] = productFixtures;

describe.only('products', () => {
  let authorizedRequest: any;

  beforeAll(async () => {
    authorizedRequest = await getCredentials();

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

  validFixtures.forEach((validFixture: ProductDTO) => {
    it(`to be able to create valid products (${validFixture.sku})`, async done => {
      await axios.post(
        'http://localhost:3000/v1/products',
        validFixture,
        authorizedRequest,
      );

      const response = await axios.get(
        `http://localhost:3000/v1/products/${validFixture.sku}`,
        authorizedRequest,
      );

      expect(response.data.sku).toBe(validFixture.sku);

      if (validFixture.productVariations) {
        expect(response.data.productVariations?.length).toBe(
          validFixture.productVariations.length,
        );
      }

      if (validFixture.productImages) {
        expect(response.data.productImages?.length).toBe(
          validFixture.productImages.length,
        );
      }

      done();
    });
  });
});
