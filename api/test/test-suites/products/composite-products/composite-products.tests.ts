import axios from 'axios';
import { getCredentials } from '../../utils/credentials';
import { cleanUpDatabase } from '../../utils/queries';
import { ProductDTO } from '../../../../src/products/dtos/product.dto';
import { InventoryMovementDTO } from '../../../../src/inventory/inventory-movement.dto';
import { Product } from '../../../../src/products/entities/product.entity';

describe('persisting products', () => {
  let authorizedRequest: any;
  const PRODUCT_ENDPOINT = 'http://localhost:3000/v1/products';
  const MOVEMENT_ENDPOINT = 'http://localhost:3000/v1/inventory/movement';

  beforeEach(async () => {
    authorizedRequest = await getCredentials();
    await cleanUpDatabase();
  });

  it('should be able to insert composite products', async () => {
    // step 1: we define a couple of parts for the composite product
    const productPart1: ProductDTO = {
      sku: 'P-1',
      title: 'Product Part 1',
      ncm: '1234.56.78',
    };

    const productPart2: ProductDTO = {
      sku: 'P-2',
      title: 'Product Part 2',
      ncm: '1234.56.78',
    };

    await axios.post(PRODUCT_ENDPOINT, productPart1, authorizedRequest);
    await axios.post(PRODUCT_ENDPOINT, productPart2, authorizedRequest);

    // step 2: we add some items to these parts
    const movePart1: InventoryMovementDTO = {
      sku: 'P-1',
      amount: 7,
      description: 'updating part 1',
    };

    const movePart2: InventoryMovementDTO = {
      sku: 'P-2',
      amount: 9,
      description: 'updating part 2',
    };

    await axios.post(MOVEMENT_ENDPOINT, movePart1, authorizedRequest);
    await axios.post(MOVEMENT_ENDPOINT, movePart2, authorizedRequest);

    // step 3: we create a composite product
    const compositeProduct: ProductDTO = {
      sku: 'CP-1',
      title: 'Composite Product 1',
      ncm: '1234.56.78',
      productComposition: ['P-1', 'P-2'],
    };

    const response = await axios.post(
      PRODUCT_ENDPOINT,
      compositeProduct,
      authorizedRequest,
    );

    expect(response).toBeDefined();
    expect(response.data).toBeDefined();
    expect(response.status).toBe(201);

    // step 4: check inventory
    const getProductResponse = await axios.get(
      `${PRODUCT_ENDPOINT}/${compositeProduct.sku}`,
      authorizedRequest,
    );
    const persistedProduct: Product = getProductResponse.data;
    expect(persistedProduct.productVariations).toBeDefined();
    expect(persistedProduct.productVariations.length).toBe(1);
    const singleVariation = persistedProduct.productVariations[0];
    expect(singleVariation.currentPosition).toBeDefined();
    expect(singleVariation.currentPosition).toBe(
      Math.min(movePart1.amount, movePart2.amount),
    );
  });
});
