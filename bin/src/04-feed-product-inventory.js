// 1. load product inventory from bling
// 2. create InventoryMovementDTO
// 3. post movement

const got = require("got");
const _ = require("lodash");

const getToken = require("./util/auth");

const BLING_APIKEY =
  "50c467c88f5cb2b8021c7f8818a8d4b22df7a80dc29fbe1f533b0ce6c2e1cfaa7581fbc8";

let allProductsIncludingVariations = [];

async function getDigituzProducts() {
  const token = await getToken();
  const response = await got(`http://localhost:3000/v1/products/all`, {
    method: "GET",
    responseType: "json",
    headers: {
      Authorization: "Bearer " + token,
    },
  });
  return response.body;
}

async function getMoreProducts(page) {
  const response = await got(
    `https://bling.com.br/Api/v2/produtos/page=${page}/json/?imagem=S&estoque=S&apikey=${BLING_APIKEY}`
  );
  const responseObject = JSON.parse(response.body);
  return responseObject.retorno.produtos.map((produto) => produto.produto);
}

async function loadInventoryFromBling() {
  const pages = [0, 1, 2, 3, 4];
  const getProductsJob = pages.map((page) => getMoreProducts(page));
  const resultsFromJobs = await Promise.all(getProductsJob);
  resultsFromJobs.forEach((result) =>
    allProductsIncludingVariations.push(...result)
  );

  allProductsIncludingVariations = _.uniqBy(
    allProductsIncludingVariations,
    (p) => p.codigo
  );

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
        await got("http://localhost:3000/v1/inventory/movement/", {
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
