const got = require("got");
const getToken = require("./util/auth");

async function getProducts(token) {
  const response = await got(
    "http://localhost:3000/v1/products?page=1&limit=300",
    {
      method: "GET",
      headers: {
        authorization: `Bearer ${token}`,
      },
      responseType: "json",
    }
  );
  return response.body.items;
}

async function getTaggedImages() {
  const response = await got(
    "http://localhost:3001/tagged-images-in-a-weird-endpoint-to-make-finding-difficult",
    {
      method: "GET",
      responseType: "json",
    }
  );
  return response.body;
}

(async () => {
  try {
    // 0. get access token
    const token = await getToken();

    // 1. get list with all the products from Digituz
    const products = await getProducts(token);

    // 2. get list of images (and their tags) from Frida Kahlo
    const taggedImages = await getTaggedImages();

    // 3. upload images to Digituz while linking with tags
    const uploadJobs = taggedImages.map((taggedImage) => {
      return new Promise((res, rej) => {
        res(`https://ik.imagekit.io/fridakahlo/${taggedImage.imageId}`);
      });
    });

    Promise.all(uploadJobs).then((images) => {
        console.log(images);
    });
  } catch (error) {
    console.log(error);
  }
})();
