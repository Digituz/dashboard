const fs = require("fs");
const got = require("got");
const _ = require("lodash");
const showdown = require("showdown");
const TurndownService = require("turndown");

const converter = new showdown.Converter();
const turndownService = new TurndownService();

const BLING_APIKEY =
  "b147523f150783ffd260159239a1a6271ab233749c4c016c0a9320ad85ff60426824fe07";

const allProductsExcludingVariations = [];

const digituzProducts = [];

async function getMoreProducts(page) {
  const response = await got(
    `https://bling.com.br/Api/v2/produtos/page=${page}/json/?imagem=S&estoque=S&apikey=${BLING_APIKEY}`
  );
  const responseObject = JSON.parse(response.body);
  return responseObject.retorno.produtos.map((produto) => produto.produto);
}

async function getToken() {
  const { body } = await got.post("http://localhost:3000/v1/sign-in", {
    json: {
      username: "bruno.krebs@fridakahlo.com.br",
      password: "lbX01as$",
    },
    responseType: "json",
  });
  return body.access_token;
}

async function insertProductVariation(variation) {}

async function insertProduct(token, product, delay) {
  return new Promise((res, rej) => {
    setTimeout(async () => {
      try {
        console.log(`inserting ${product.sku} with ${delay}ms delay`);
        await got.post("http://localhost:3000/v1/products", {
          json: product,
          headers: {
            authorization: `Bearer ${token}`,
          },
          responseType: "json",
        });
        res();
      } catch (e) {
        console.log(`had problems on ${product.sku} with ${delay}ms delay`);
        rej();
      }
    }, delay);
  });
}

(async () => {
  try {
    let allProductsIncludingVariations = [];
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

    allProductsExcludingVariations.push(
      ...allProductsIncludingVariations.filter((p) => !p.codigoPai)
    );

    const productSkuMap = {};
    allProductsExcludingVariations.forEach((product) => {
      productSkuMap[product.codigo] = product;
    });

    allProductsIncludingVariations.forEach((product) => {
      if (!product.codigoPai) return;
      const parentProduct = productSkuMap[product.codigoPai];
      if (!parentProduct) {
        return;
      }
      parentProduct.variations = parentProduct.variations || [];
      parentProduct.variations.push(product);
    });

    allProductsExcludingVariations.forEach((parentProduct) => {
      const digituzProduct = {
        sku: parentProduct.codigo,
        title: parentProduct.descricao,
        description: null,
        productDetails: parentProduct.descricaoCurta
          ? converter.makeHtml(
              turndownService.turndown(parentProduct.descricaoCurta)
            )
          : "",
        sellingPrice: parentProduct.preco
          ? parseFloat(parentProduct.preco)
          : null,
        height: parentProduct.alturaProduto
          ? parseFloat(parentProduct.alturaProduto) / 100
          : null,
        width: parentProduct.larguraProduto
          ? parseFloat(parentProduct.larguraProduto) / 100
          : null,
        length: parentProduct.profundidadeProduto
          ? parseFloat(parentProduct.profundidadeProduto) / 100
          : null,
        weight: parentProduct.pesoLiq
          ? parseFloat(parentProduct.pesoLiq) / 1000
          : null,
        isActive: true,
        ncm: parentProduct.class_fiscal,
      };

      if (parentProduct.variacoes) {
        parentProduct.variations = _.uniqBy(
          parentProduct.variations,
          (p) => p.codigo
        );
        if (
          !parentProduct.variations ||
          parentProduct.variations.length !== parentProduct.variacoes.length
        ) {
          console.log(
            parentProduct.codigo,
            parentProduct.variacoes.length,
            parentProduct.variations?.length
          );
        }
      }

      if (parentProduct.variations) {
        digituzProduct.variations = [];
        parentProduct.variations.forEach((variation) => {
          const blingVariationDetails = parentProduct.variacoes.find(
            ({ variacao }) => variacao.codigoPai === variation.sku
          );
          digituzProduct.variations.push({
            sku: variation.codigo,
            description: blingVariationDetails.nome,
            sellingPrice: parseFloat(variation.preco),
          });
        });
      }

      digituzProducts.push(digituzProduct);
    });

    // fs.writeFileSync(
    //   `${__dirname}/../bkp/${Date.now()}-digituz-products-problem.json`,
    //   JSON.stringify(digituzProducts.filter((p) => !!!p.sku.trim()))
    // );
    // fs.writeFileSync(
    //   `${__dirname}/../bkp/${Date.now()}-digituz-products-good.json`,
    //   JSON.stringify(digituzProducts.filter((p) => !!p.sku.trim()))
    // );
    const productsToBeIgnored = digituzProducts.filter((p) => !!!p.sku.trim());
    const productsToBeSaved = digituzProducts.filter((p) => !!p.sku.trim());
    
    console.log(`to be ignored - ${productsToBeIgnored.length}`);
    console.log(`to be saved - ${productsToBeSaved.length}`);

    const token = await getToken();

    const insertProductJobs = productsToBeSaved.map((product, index) => {
      return insertProduct(token, product, index * 10);
    });
    await Promise.all(insertProductJobs);
    console.log("done");
  } catch (error) {
    console.log(error);
  }
})();
