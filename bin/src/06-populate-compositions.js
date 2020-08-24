const got = require("got");
const _ = require("lodash");

const getToken = require("./util/auth");
const { getProductsFromBling, getDigituzProducts } = require("./util/products");

(async () => {
  const allProducts = await getProductsFromBling();
  const blingPoductsWithComposition = allProducts.filter((p) => !!p.estrutura);
  const digituzProducts = await getDigituzProducts();

  const digituzProductsWithComposition = digituzProducts.filter((dp) => {
    return blingPoductsWithComposition.find((b) => b.codigo === dp.sku);
  });

  console.log(digituzProductsWithComposition);

  const token = await getToken();

  const insertCompositionsJobs = digituzProductsWithComposition.map(
    async (digituzProduct) => {
      const blingProduct = blingPoductsWithComposition.find(
        (bp) => bp.codigo === digituzProduct.sku
      );
      const parts = blingProduct.estrutura.map(
        (part) => part.componente.codigo
      );

      const productDTO = {
        sku: digituzProduct.sku,
        title: digituzProduct.title,
        ncm: digituzProduct.ncm,
        noVariation: true,
        description: digituzProduct.description,
        productDetails: digituzProduct.sku,
        sellingPrice: digituzProduct.sellingPrice,
        height: digituzProduct.height,
        width: digituzProduct.width,
        length: digituzProduct.length,
        weight: digituzProduct.weight,
        isActive: digituzProduct.isActive,
        productVariations: digituzProduct.productVariations.map(
          (variation) => ({
            sku: variation.sku,
            parentSku: digituzProduct.sku,
            description: variation.description,
            sellingPrice: variation.sellingPrice,
            noVariation: true,
          })
        ),
        productComposition: parts,
        productImages: digituzProduct.productImages
          .filter((productImage) => {
            return !!productImage.image;
          })
          .map((productImage) => ({
            imageId: productImage.image.id,
            order: productImage.order,
          })),
        category: "CONJUNTOS",
      };

      if (digituzProduct.productImages.length === 0) {
        delete productDTO.productImages;
      }

      await got.post("http://localhost:3005/v1/products", {
        json: productDTO,
        headers: {
          authorization: `Bearer ${token}`,
        },
        responseType: "json",
      });

      console.log(productDTO);
    }
  );
  await Promise.all(insertCompositionsJobs);
})();
