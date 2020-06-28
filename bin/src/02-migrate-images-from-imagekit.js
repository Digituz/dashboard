const fs = require("fs");
const got = require("got");
const os = require("os");
const stream = require("stream");
const { promisify } = require("util");

const pipeline = promisify(stream.pipeline);

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

async function downloadImage(imageId) {
  const path = `${os.tmpdir()}/${imageId}`;
  await pipeline(
    got.stream(`https://ik.imagekit.io/fridakahlo/${imageId}`),
    fs.createWriteStream(path)
  );
  return path;
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
    const uploadJobs = taggedImages.slice(0, 4).map((taggedImage, idx) => {
      return new Promise((res, rej) => {
        setTimeout(async () => {
          console.log(`downloadind with ${idx * 400}ms delay`);
          const path = await downloadImage(taggedImage.imageId);
          res(path);
        }, idx * 400);
      });
    });

    Promise.all(uploadJobs).then((images) => {
      console.log(images);
    });
  } catch (error) {
    console.log(error);
  }
})();
