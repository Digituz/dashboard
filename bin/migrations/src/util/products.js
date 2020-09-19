const got = require("got");
const _ = require("lodash");

const getToken = require("./auth");

const BLING_APIKEY =
  "50c467c88f5cb2b8021c7f8818a8d4b22df7a80dc29fbe1f533b0ce6c2e1cfaa7581fbc8";

async function getMoreProducts(page) {
  const url = `https://bling.com.br/Api/v2/produtos/page=${page.number}/json/?imagem=S&filters=situacao[${page.active ? 'A' : 'I'}]&estoque=S&apikey=${BLING_APIKEY}`;
  console.log(url);
  const response = await got(url);
  const responseObject = JSON.parse(response.body);
  return responseObject.retorno.produtos.map((produto) => produto.produto);
}

async function getProductsFromBling() {
  const allProductsIncludingVariations = [];
  const pages = [
    { number: 0, active: true },
    { number: 1, active: true },
    { number: 2, active: true },
    { number: 3, active: true },
    { number: 4, active: true },
    { number: 0, active: false },
    { number: 1, active: false },
  ];
  const getProductsJob = pages.map((page) => getMoreProducts(page));
  const resultsFromJobs = await Promise.all(getProductsJob);
  resultsFromJobs.forEach((result) =>
    allProductsIncludingVariations.push(...result)
  );

  return _.uniqBy(allProductsIncludingVariations, (p) => p.codigo);
}

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

module.exports = {
  getProductsFromBling,
  getDigituzProducts,
};
