const got = require("got");
const _ = require("lodash");

const getToken = require("./util/auth");
const { getProductsFromBling, getDigituzProducts } = require("./util/products");

function replaceAccents(str) {
  // verifies if the String has accents and replace them
  if (str.search(/[\xC0-\xFF]/g) > -1) {
    str = str
      .replace(/[\xC0-\xC5]/g, "A")
      .replace(/[\xC6]/g, "AE")
      .replace(/[\xC7]/g, "C")
      .replace(/[\xC8-\xCB]/g, "E")
      .replace(/[\xCC-\xCF]/g, "I")
      .replace(/[\xD0]/g, "D")
      .replace(/[\xD1]/g, "N")
      .replace(/[\xD2-\xD6\xD8]/g, "O")
      .replace(/[\xD9-\xDC]/g, "U")
      .replace(/[\xDD]/g, "Y")
      .replace(/[\xDE]/g, "P")
      .replace(/[\xE0-\xE5]/g, "a")
      .replace(/[\xE6]/g, "ae")
      .replace(/[\xE7]/g, "c")
      .replace(/[\xE8-\xEB]/g, "e")
      .replace(/[\xEC-\xEF]/g, "i")
      .replace(/[\xF1]/g, "n")
      .replace(/[\xF2-\xF6\xF8]/g, "o")
      .replace(/[\xF9-\xFC]/g, "u")
      .replace(/[\xFE]/g, "p")
      .replace(/[\xFD\xFF]/g, "y");
  }

  return str;
}

function removeNonWord(str) {
  return str.replace(/[^0-9a-zA-Z\xC0-\xFF \-]/g, "");
}

function enumify(str, delimeter) {
  if (delimeter == null) {
    delimeter = "-";
  }

  str = replaceAccents(str);
  str = removeNonWord(str);
  str = str
    .trim()
    .replace(/ +/g, delimeter) //replace spaces with delimeter
    .toUpperCase();

  return str;
}

(async () => {
  const allProductsIncludingVariations = await getProductsFromBling();
  const digituzProducts = await getDigituzProducts();

  for (const digituzProduct of digituzProducts) {
    const blingProduct = allProductsIncludingVariations.find(
      (blingProduct) => blingProduct.codigo === digituzProduct.sku
    );
    if (blingProduct && blingProduct.grupoProduto) {
      digituzProduct.category = enumify(blingProduct.grupoProduto);
    }
  }

  const token = await getToken();

  const updateCategoryJobs = digituzProducts
    .filter((p) => !!p.category)
    .map((p) => {
      return {
        ...p,
        productImages: p.productImages.map((pI) => {
          return {
            imageId: pI.image.id,
            order: pI.order,
          };
        }),
      };
    })
    .map(async (product) => {
      await got("http://localhost:3005/v1/products/", {
        method: "POST",
        responseType: "json",
        headers: {
          Authorization: "Bearer " + token,
        },
        json: product,
      });
    });

  await Promise.all(updateCategoryJobs);
})();
