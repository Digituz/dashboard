const Shopify = require("shopify-api-node");

(async () => {
  const shopify = new Shopify({
    shopName: "frida-kahlo-loja-oficial",
    apiKey: "8a0409e54fa50f6e15a744fd24036971",
    password: "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",
  });

  //   const productResponse = await shopify.product.get(5536198394011);
  //   console.log(productResponse);

  //   const productVariantJobs = productResponse.variants.map((variant, idx) => {
  //     return new Promise((res) => {
  //       setTimeout(async () => {
  //         try {
  //           const updateVariant = {
  //             option1: variant.option1,
  //             price: variant.price,
  //             sku: variant.sku,
  //             inventory_management: "shopify",
  //           };
  //           await shopify.productVariant.update(variant.id, updateVariant);
  //           console.log('done');
  //           res();
  //         } catch (e) {
  //           console.log(e);
  //         }
  //       }, idx * 510);
  //     });
  //   });

  //   await Promise.all(productVariantJobs);

  //   const inventoryResponse = await shopify.inventoryLevel.list({
  //     inventory_item_ids: "37722824409243",
  //   });
  //   console.log(inventoryResponse);

  const adjustInventoryResponse = await shopify.inventoryLevel.adjust({
    inventory_item_id: 37722824409243,
    location_id: 53361180827,
    available_adjustment: 4,
  });
  console.log(adjustInventoryResponse);

  //   await shopify.fulfillmentService.create({
  //     name: "Digituz",
  //     callback_url: "https://digituz.com.br/api/v1/shopify",
  //     inventory_management: true,
  //     tracking_support: true,
  //     requires_shipping_method: true,
  //     format: "json",
  //   });
})();
