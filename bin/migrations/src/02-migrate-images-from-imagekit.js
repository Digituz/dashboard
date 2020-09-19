const axios = require("axios");
const fs = require("fs");
const got = require("got");
const os = require("os");
const stream = require("stream");
const FormData = require("form-data");
const { promisify } = require("util");

const pipeline = promisify(stream.pipeline);

const getToken = require("./util/auth");

async function getProducts(token) {
  const response = await got(
    "http://localhost:3005/v1/products?page=1&limit=300",
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

    // 1. get list of skus (tags) from digituz
    const products = await getProducts(token);
    const tags = products.map((product) => product.sku);

    // 2. get list of images (and their tags) from Frida Kahlo
    const taggedImages = await getTaggedImages();

    // 3. download images from imagekit and pass down info about path, image name, and tags
    const downloadJobs = taggedImages.map((taggedImage, idx) => {
      return new Promise((res) => {
        setTimeout(async () => {
          try {
            console.log(`downloading with ${idx * 200}ms delay`);
            const path = await downloadImage(taggedImage.imageId);
            res({
              imageId: taggedImage.imageId,
              path: path,
              tags: taggedImage.tags,
            });
          } catch (err) {
            console.error(`${taggedImage.imageId} not found!`);
            res({
              notFound: true,
            });
          }
        }, idx * 200);
      });
    });

    // 4. upload images to Digituz and link tags
    const results = await Promise.all(downloadJobs);
    const uploadJobs = results.filter((res) => !res.notFound).map((downloadedImage, idx) => {
      return new Promise((res, rej) => {
        setTimeout(async () => {
          console.log(`uploading ${downloadedImage.imageId}`);
          const file = fs.createReadStream(downloadedImage.path);

          const formData = new FormData();
          formData.append("file", file);
          const { data: persistedImage } = await axios.post(
            "http://localhost:3005/v1/media-library/upload",
            formData,
            {
              headers: {
                ...formData.getHeaders(),
                Authorization: "Bearer " + token,
              },
            }
          );
          console.log(`${downloadedImage.imageId} uploaded`);
          await axios.post(
            `http://localhost:3005/v1/media-library/${persistedImage.id}`,
            downloadedImage.tags,
            {
              headers: {
                Authorization: "Bearer " + token,
              },
            }
          );
          console.log(`${downloadedImage.imageId} tagged`);
          res();
        }, idx * 400);
      });
    });
    Promise.all(uploadJobs)
      .then(() => {
        console.log("files uploaded");
      })
      .catch(() => {
        console.log("something went wrong");
      });
  } catch (error) {
    console.log(
      "----------------------------------------------------- oh crap"
    );
    console.log(error);
    console.log(
      "----------------------------------------------------- oh crap"
    );
  }
})();
