import axios from 'axios';
import { getCredentials } from '../../utils/credentials';
import { cleanUpDatabase } from '../../utils/queries';
import { ProductDTO } from '../../../../src/products/dtos/product.dto';
import { InventoryMovementDTO } from '../../../../src/inventory/inventory-movement.dto';
import { Product } from '../../../../src/products/entities/product.entity';
import { ProductComposition } from 'src/products/entities/product-composition.entity';

describe('persisting products', () => {
  let authorizedRequest: any;
  const PRODUCT_ENDPOINT = 'http://localhost:3000/v1/products';
  const MOVEMENT_ENDPOINT = 'http://localhost:3000/v1/inventory/movement';

  beforeEach(async () => {
    authorizedRequest = await getCredentials();
    await cleanUpDatabase();
  });

  async function checkProductComposition(compositeProduct: ProductDTO, expectedInventoryPosition: number) {
    const getProductResponse = await axios.get(
      `${PRODUCT_ENDPOINT}/${compositeProduct.sku}`,
      authorizedRequest,
    );
    const persistedProduct: Product = getProductResponse.data;
    expect(persistedProduct.productVariations).toBeDefined();
    expect(persistedProduct.productVariations.length).toBe(1);
    const singleVariation = persistedProduct.productVariations[0];
    expect(singleVariation.currentPosition).toBeDefined();
    expect(singleVariation.currentPosition).toBe(expectedInventoryPosition);
  }

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
    const inventoryPart1: InventoryMovementDTO = {
      sku: 'P-1',
      amount: 7,
      description: 'define part 1 initial inventory',
    };

    const inventoryPart2: InventoryMovementDTO = {
      sku: 'P-2',
      amount: 9,
      description: 'define part 2 initial inventory',
    };

    await axios.post(MOVEMENT_ENDPOINT, inventoryPart1, authorizedRequest);
    await axios.post(MOVEMENT_ENDPOINT, inventoryPart2, authorizedRequest);

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
    await checkProductComposition(compositeProduct, inventoryPart1.amount);

    // step 5. move down part2, and check that product composition inventory stays untouched
    // (reason: part 1 position is lower than part 2, even after the update,
    //  so the composition is unaffected)
    const movePart2: InventoryMovementDTO = {
      sku: 'P-2',
      amount: -1,
      description: 'updating part 2',
    };

    await axios.post(MOVEMENT_ENDPOINT, movePart2, authorizedRequest);

    await checkProductComposition(compositeProduct, inventoryPart1.amount);

    // step 6. move up part 1 and check composition inventory moves to 8
    const movePart1: InventoryMovementDTO = {
      sku: 'P-1',
      amount: 3,
      description: 'updating part 1',
    };

    await axios.post(MOVEMENT_ENDPOINT, movePart1, authorizedRequest);

    await checkProductComposition(compositeProduct, inventoryPart2.amount + movePart2.amount);
  });
});
