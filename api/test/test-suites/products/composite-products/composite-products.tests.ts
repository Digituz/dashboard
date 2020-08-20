import axios from 'axios';
import { getCredentials } from '../../utils/credentials';
import { cleanUpDatabase } from '../../utils/queries';
import { ProductDTO } from '../../../../src/products/dtos/product.dto';
import { InventoryMovementDTO } from '../../../../src/inventory/inventory-movement.dto';
import { Product } from '../../../../src/products/entities/product.entity';
import { ProductComposition } from 'src/products/entities/product-composition.entity';

describe('managing composite products', () => {
  let authorizedRequest: any;
  const PRODUCT_ENDPOINT = 'http://localhost:3000/v1/products';
  const MOVEMENT_ENDPOINT = 'http://localhost:3000/v1/inventory/movement';

  beforeEach(async () => {
    authorizedRequest = await getCredentials();
    await cleanUpDatabase();
  });

  async function checkProductComposition(
    compositeProduct: ProductDTO,
    expectedInventoryPosition: number,
  ) {
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

  const compositeProduct: ProductDTO = {
    sku: 'CP-1',
    title: 'Composite Product 1',
    ncm: '1234.56.78',
    productComposition: ['P-1', 'P-2'],
  };

  async function createAndMoveBasicProducts() {
    // persist basic products
    await axios.post(PRODUCT_ENDPOINT, productPart1, authorizedRequest);
    await axios.post(PRODUCT_ENDPOINT, productPart2, authorizedRequest);

    // move their inventory
    await axios.post(MOVEMENT_ENDPOINT, inventoryPart1, authorizedRequest);
    await axios.post(MOVEMENT_ENDPOINT, inventoryPart2, authorizedRequest);
  }

  async function createCompositeProductAndCheckInventory() {
    // we create a composite product
    const response = await axios.post(
      PRODUCT_ENDPOINT,
      compositeProduct,
      authorizedRequest,
    );

    expect(response).toBeDefined();
    expect(response.data).toBeDefined();
    expect(response.status).toBe(201);
  }

  async function prepareScenarioForTests() {
    await createAndMoveBasicProducts();
    await createCompositeProductAndCheckInventory();
  }

  it('should be able to insert composite products', async () => {
    await prepareScenarioForTests();
    await checkProductComposition(compositeProduct, inventoryPart1.amount);
  });

  it('should not change composite inventory when min inventory is not changed', async () => {
    await prepareScenarioForTests();

    // as part 1 position is lower than part 2, even after the update,
    // composition's inventory must stay the same
    const movePart2: InventoryMovementDTO = {
      sku: 'P-2',
      amount: -1,
      description: 'updating part 2',
    };

    await axios.post(MOVEMENT_ENDPOINT, movePart2, authorizedRequest);

    await checkProductComposition(compositeProduct, inventoryPart1.amount);
  });

  it('should change composite inventory when min inventory gets lower', async () => {
    await prepareScenarioForTests();

    // as part 1 position is now higher than part 2, after the update,
    // composition's inventory must be equal to whatver part 2 is
    const movePart1: InventoryMovementDTO = {
      sku: 'P-1',
      amount: -3,
      description: 'updating part 1',
    };

    await axios.post(MOVEMENT_ENDPOINT, movePart1, authorizedRequest);

    await checkProductComposition(compositeProduct, inventoryPart1.amount + movePart1.amount);
  });

  it('should keep composite inventory in sync with min inventory', async () => {
    await prepareScenarioForTests();

    // as part 1 position is now higher than part 2, after the update,
    // composition's inventory must be equal to whatver part 2 is
    const movePart1: InventoryMovementDTO = {
      sku: 'P-1',
      amount: 4,
      description: 'updating part 1',
    };

    await axios.post(MOVEMENT_ENDPOINT, movePart1, authorizedRequest);

    await checkProductComposition(compositeProduct, inventoryPart2.amount);
  });

  it('should update parts when a composite product gets sold', async () => {
    // fail('not implemented yet');
  });

  it("should fail when user try to add items to composite's inventory", async () => {
    // fail('not implemented yet');
  });
});
