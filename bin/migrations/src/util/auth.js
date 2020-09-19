const got = require("got");

async function getToken() {
  const { body } = await got.post("http://localhost:3005/v1/sign-in", {
    json: {
      username: "bruno.krebs@fridakahlo.com.br",
      password: "lbX01as$",
    },
    responseType: "json",
  });
  return body.access_token;
}

module.exports = getToken;