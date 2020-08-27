import axios from 'axios';
import { getCredentials } from '../../utils/credentials';
import { cleanUpDatabase } from '../../utils/queries';
import { ProductDTO } from '../../../../src/products/dtos/product.dto';
import { InventoryMovementDTO } from '../../../../src/inventory/inventory-movement.dto';
import { Product } from '../../../../src/products/entities/product.entity';

describe('managing composite products', () => {
  let authorizedRequest: any;
  const PRODUCT_ENDPOINT = 'http://localhost:3005/v1/products';
  const MOVEMENT_ENDPOINT = 'http://localhost:3005/v1/inventory/movement';

  beforeEach(async () => {
    authorizedRequest = await getCredentials();
    await cleanUpDatabase();
  });

  async function checkInventory(
    sku: string,
    expectedInventoryPosition: number,
  ) {
    const getProductResponse = await axios.get(
      `${PRODUCT_ENDPOINT}/${sku}`,
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
    productVariations: [
      {
        parentSku: 'P-1',
        sku: 'P-1',
        sellingPrice: 29.95,
        description: 'Tamanho Único',
      },
    ],
  };

  const productPart2: ProductDTO = {
    sku: 'P-2',
    title: 'Product Part 2',
    ncm: '1234.56.78',
    productVariations: [
      {
        parentSku: 'P-2',
        sku: 'P-2',
        sellingPrice: 29.95,
        description: 'Tamanho Único',
      },
    ],
  };

  const productPart3: ProductDTO = {
    sku: 'P-3',
    title: 'Product Part 3',
    ncm: '1234.56.78',
    productVariations: [
      {
        parentSku: 'P-3',
        sku: 'P-3',
        sellingPrice: 29.95,
        description: 'Tamanho Único',
      },
    ],
  };

  const productPart4: ProductDTO = {
    sku: 'P-4',
    title: 'Product Part 4',
    ncm: '1234.56.78',
    productVariations: [
      {
        parentSku: 'P-4',
        sku: 'P-4',
        sellingPrice: 29.95,
        description: 'Tamanho Único',
      },
    ],
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

  const inventoryPart3: InventoryMovementDTO = {
    sku: 'P-3',
    amount: 5,
    description: 'define part 3 initial inventory',
  };

  const inventoryPart4: InventoryMovementDTO = {
    sku: 'P-4',
    amount: 3,
    description: 'define part 4 initial inventory',
  };

  const compositeProduct: ProductDTO = {
    sku: 'CP-1',
    title: 'Composite Product 1',
    ncm: '1234.56.78',
    productComposition: ['P-1', 'P-2'],
    productVariations: [
      {
        parentSku: 'CP-1',
        sku: 'CP-1',
        sellingPrice: 29.95,
        description: 'Tamanho Único',
      },
    ],
  };

  async function createAndMoveBasicProducts() {
    // persist basic products
    await axios.post(PRODUCT_ENDPOINT, productPart1, authorizedRequest);
    await axios.post(PRODUCT_ENDPOINT, productPart2, authorizedRequest);
    await axios.post(PRODUCT_ENDPOINT, productPart3, authorizedRequest);
    await axios.post(PRODUCT_ENDPOINT, productPart4, authorizedRequest);

    // move their inventory
    await axios.post(MOVEMENT_ENDPOINT, inventoryPart1, authorizedRequest);
    await axios.post(MOVEMENT_ENDPOINT, inventoryPart2, authorizedRequest);
    await axios.post(MOVEMENT_ENDPOINT, inventoryPart3, authorizedRequest);
    await axios.post(MOVEMENT_ENDPOINT, inventoryPart4, authorizedRequest);
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
    await checkInventory(compositeProduct.sku, inventoryPart1.amount);
  });

  it('should not change composite inventory when min inventory is not changed', async () => {
    // as part 1 position is lower than part 2, even after the update,
    // composition's inventory must stay the same

    await prepareScenarioForTests();

    const movePart2: InventoryMovementDTO = {
      sku: productPart2.sku,
      amount: -1,
      description: 'moving stuff',
    };

    await axios.post(MOVEMENT_ENDPOINT, movePart2, authorizedRequest);

    await checkInventory(compositeProduct.sku, inventoryPart1.amount);
  });

  it('should change composite inventory when min inventory gets lower', async () => {
    // as part 1 position is now higher than part 2, after the update,
    // composition's inventory must be equal to whatver part 2 is

    await prepareScenarioForTests();

    const movePart1: InventoryMovementDTO = {
      sku: productPart1.sku,
      amount: -3,
      description: 'moving stuff',
    };

    await axios.post(MOVEMENT_ENDPOINT, movePart1, authorizedRequest);

    await checkInventory(
      compositeProduct.sku,
      inventoryPart1.amount + movePart1.amount,
    );
  });

  it('should keep composite inventory in sync with min inventory', async () => {
    // as part 1 position is now higher than part 2, after the update,
    // composition's inventory must be equal to whatver part 2 is

    await prepareScenarioForTests();

    const movePart1: InventoryMovementDTO = {
      sku: productPart1.sku,
      amount: 4,
      description: 'moving stuff',
    };

    await axios.post(MOVEMENT_ENDPOINT, movePart1, authorizedRequest);

    await checkInventory(compositeProduct.sku, inventoryPart2.amount);
  });

  it('should update parts when a composite product gets sold', async () => {
    await prepareScenarioForTests();

    const sellCompositeProduct: InventoryMovementDTO = {
      sku: compositeProduct.sku,
      amount: -2,
      description: 'selling composite products',
    };

    await axios.post(
      MOVEMENT_ENDPOINT,
      sellCompositeProduct,
      authorizedRequest,
    );

    await checkInventory(
      productPart1.sku,
      inventoryPart1.amount + sellCompositeProduct.amount,
    );
    await checkInventory(
      productPart2.sku,
      inventoryPart2.amount + sellCompositeProduct.amount,
    );
  });

  it("should fail when user try to add items to composite's inventory", async () => {
    await prepareScenarioForTests();

    const sellCompositeProduct: InventoryMovementDTO = {
      sku: compositeProduct.sku,
      amount: 2,
      description: 'adding more items to composite product',
    };

    try {
      await axios.post(
        MOVEMENT_ENDPOINT,
        sellCompositeProduct,
        authorizedRequest,
      );
      fail('error expected');
    } catch (error) {
      // good to go, it is expected
    }
  });

  it('should be able to make simple updates to composite products', async () => {
    await prepareScenarioForTests();

    const newVersion = {
      ...compositeProduct,
      title: 'new title to my composite product',
      weight: 0.9,
      height: 0.8,
    };

    const response = await axios.post(
      PRODUCT_ENDPOINT,
      newVersion,
      authorizedRequest,
    );

    expect(response).toBeDefined();
    expect(response.data).toBeDefined();
    expect(response.status).toBe(201);

    const persistedProduct: Product = response.data;
    expect(persistedProduct.title).toBe(newVersion.title);
    expect(persistedProduct.weight).toBe(newVersion.weight);
    expect(persistedProduct.height).toBe(newVersion.height);
  });

  it('should be able to add new parts to composite products', async () => {
    await prepareScenarioForTests();

    const newVersion = {
      ...compositeProduct,
      title: 'new title',
      productComposition: ['P-1', 'P-2', 'P-3'],
    };

    const response = await axios.post(
      PRODUCT_ENDPOINT,
      newVersion,
      authorizedRequest,
    );

    expect(response).toBeDefined();
    expect(response.data).toBeDefined();
    expect(response.status).toBe(201);

    const persistedProduct: Product = response.data;
    expect(persistedProduct.title).toBe(newVersion.title);
    expect(persistedProduct.productComposition.length).toBe(
      newVersion.productComposition.length,
    );

    await checkInventory(persistedProduct.sku, inventoryPart3.amount);
  });

  it('should be able to remove parts from composite products', async () => {
    await prepareScenarioForTests();

    const withThreeParts = {
      ...compositeProduct,
      title: 'composition with three parts',
      productComposition: ['P-1', 'P-2', 'P-3'],
    };

    const firstResponse = await axios.post(
      PRODUCT_ENDPOINT,
      withThreeParts,
      authorizedRequest,
    );
    await checkInventory(firstResponse.data.sku, inventoryPart3.amount);

    const backToTwoAgain = {
      ...withThreeParts,
      title: 'composition with two parts',
      productComposition: ['P-1', 'P-4'],
    };

    const secondResponse = await axios.post(
      PRODUCT_ENDPOINT,
      backToTwoAgain,
      authorizedRequest,
    );

    expect(secondResponse).toBeDefined();
    expect(secondResponse.data).toBeDefined();
    expect(secondResponse.status).toBe(201);

    const persistedProduct: Product = secondResponse.data;
    expect(persistedProduct.title).toBe(backToTwoAgain.title);
    expect(persistedProduct.productComposition.length).toBe(
      backToTwoAgain.productComposition.length,
    );

    await checkInventory(persistedProduct.sku, inventoryPart4.amount);
  });

  it('should be able to completely changes parts of composite products', async () => {
    await prepareScenarioForTests();

    const newVersion = {
      ...compositeProduct,
      title: 'new title',
      productComposition: ['P-3', 'P-4'],
    };

    const response = await axios.post(
      PRODUCT_ENDPOINT,
      newVersion,
      authorizedRequest,
    );

    expect(response).toBeDefined();
    expect(response.data).toBeDefined();
    expect(response.status).toBe(201);

    const persistedProduct: Product = response.data;
    expect(persistedProduct.title).toBe(newVersion.title);
    expect(persistedProduct.productComposition.length).toBe(
      newVersion.productComposition.length,
    );

    await checkInventory(persistedProduct.sku, inventoryPart4.amount);
  });
});
