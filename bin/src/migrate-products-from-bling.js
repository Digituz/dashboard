const got = require("got");

const BLING_APIKEY =
  "b147523f150783ffd260159239a1a6271ab233749c4c016c0a9320ad85ff60426824fe07";

const allProductsIncludingVariations = [];
const allProductsExcludingVariations = [];
const allProductsWithTheirVariations = [];

async function getMoreProducts(page) {
  const response = await got(
    `https://bling.com.br/Api/v2/produtos/page=${page}/json/?imagem=S&estoque=S&apikey=${BLING_APIKEY}`
  );
  const responseObject = JSON.parse(response.body);
  return responseObject.retorno.produtos.map((produto) => produto.produto);
}

(async () => {
  try {
    const pages = [0, 1, 2, 3, 4];
    const getProductsJob = pages.map((page) => getMoreProducts(page));
    const resultsFromJobs = await Promise.all(getProductsJob);
    resultsFromJobs.forEach((result) => allProductsWithVariations.push(...result));
    console.log(allProductsWithVariations.length);
    allProductsWithVariations.forEach((product) => {
      if (product.descricao.indexOf("Anel") >= 0) {
        console.log(product);
      }
    });
  } catch (error) {
    console.log(error.response.body);
  }
})();
