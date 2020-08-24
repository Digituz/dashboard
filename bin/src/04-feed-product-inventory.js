// 1. load product inventory from bling
// 2. create InventoryMovementDTO
// 3. post movement

const got = require("got");
const _ = require("lodash");

const getToken = require("./util/auth");
const { getProductsFromBling } = require("./util/products");

async function getDigituzProducts() {
  const token = await getToken();
  const response = await got(`http://localhost:3005/v1/products/all`, {
    method: "GET",
    responseType: "json",
    headers: {
      Authorization: "Bearer " + token,
    },
  });
  return response.body;
}

async function loadInventoryFromBling() {
  const allProductsIncludingVariations = await getProductsFromBling();

  const digituzProducts = await getDigituzProducts();
  const validSkus = digituzProducts.reduce((variations, product) => {
    variations.push(
      ...product.productVariations.map((variation) => variation.sku)
    );
    return variations;
  }, []);

  const movements = allProductsIncludingVariations.map((product) => {
    return {
      sku: product.codigo,
      amount: product.estoqueAtual,
      description: "Informação originária do Bling.",
    };
  });

  const token = await getToken();

  const insertMovementsJobs = movements.filter(movement => {
      return validSkus.includes(movement.sku);
  }).map((movement) => {
    return new Promise(async (res) => {
      try {
        await got("http://localhost:3005/v1/inventory/movement/", {
          method: "POST",
          responseType: "json",
          headers: {
            Authorization: "Bearer " + token,
          },
          json: movement,
        });
      } catch (err) {
        console.log("product not found (probably)");
      }
      res();
    });
  });

  await Promise.all(insertMovementsJobs);
}

(async () => {
  await loadInventoryFromBling();
})();
