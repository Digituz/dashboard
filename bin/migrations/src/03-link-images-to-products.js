const got = require("got");

const getToken = require("./util/auth");

async function getProductsImages() {
  const response = await got(
    "http://localhost:3001/product-images-in-another-weird-endpoint-to-make-finding-difficult",
    {
      method: "GET",
      responseType: "json",
    }
  );
  return response.body;
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

async function getDigituzImages(sku) {
  const token = await getToken();
  const response = await got(
    `http://localhost:3005/v1/media-library/with-tag/${sku}`,
    {
      method: "GET",
      responseType: "json",
      headers: {
        Authorization: "Bearer " + token,
      },
    }
  );
  return response.body;
}

async function updateDigituzProduct(digituzProduct) {
  const token = await getToken();
  const response = await got("http://localhost:3005/v1/products/", {
    method: "POST",
    responseType: "json",
    headers: {
      Authorization: "Bearer " + token,
    },
    json: digituzProduct,
  });
  return response.body;
}

async function buildAndPersistProduct(product, images) {
  const variations = product.productVariations.map((variation) => ({
    sku: variation.sku,
    parentSku: product.sku,
    description: variation.description,
    sellingPrice: variation.sellingPrice,
    noVariation: variation.noVariation,
  }));

  const digituzImages = await getDigituzImages(product.sku);
  if (digituzImages.length === 0) return;

  const productImages = images
    .map((imageName, idx) => {
      const digituzImage = digituzImages.find(
        (image) => image.originalFilename === imageName
      );
      if (!digituzImage) return null;
      return {
        imageId: digituzImage.id,
        order: idx + 1,
      };
    })
    .filter((productImage) => productImage !== null);

  if (!productImages || productImages.length === 0) return;

  const digituzProduct = {
    sku: product.sku,
    title: product.title,
    ncm: product.ncm,
    description: product.description,
    productDetails: product.productDetails,
    sellingPrice: product.sellingPrice,
    height: product.height,
    width: product.width,
    length: product.length,
    weight: product.weight,
    isActive: product.isActive,
    productVariations: variations,
    productImages: productImages,
  };

  await updateDigituzProduct(digituzProduct);
}

(async () => {
  const productsImages = await getProductsImages();
  const digituzProducts = await getDigituzProducts();
  const jobs = digituzProducts.map((product) => {
    return new Promise(async (res) => {
      const productImages = productsImages.find(
        (image) => image.sku === product.sku
      );
      if (productImages) {
        await buildAndPersistProduct(product, productImages.images);
      } else {
        console.log(`No images on e-commerce for ${product.sku}.`);
      }
      res();
    });
  });
  Promise.all(jobs);
})();
