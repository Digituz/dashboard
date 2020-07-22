const deploy = require("shipit-deploy");

module.exports = (shipit) => {
  deploy(shipit);

  shipit.initConfig({
    default: {
      workspace: "/tmp/dashboard",
      deployTo: "/home/brunokrebs/dashboard",
      repositoryUrl: "git@github.com:Digituz/dashboard.git",
      ignores: [".git", "node_modules"],
      keepReleases: 2,
      keepWorkspace: false,
      deleteOnRollback: false,
      shallowClone: true,
      deploy: {
        remoteCopy: {
          copyAsDir: false, // Should we copy as the dir (true) or the content of the dir (false)
        },
      },
    },
    production: {
      servers: "brunokrebs@digituz.com.br",
    },
  });

  shipit.blTask("digituz:build-api", async () => {
    const commands = [
      `cd ${shipit.releasePath}/api`,
      "mv ormconfig.env .env",
      "npm install --prooduction",
      "npm run build",
      "npx ts-node ./node_modules/typeorm/cli.js migration:run",
      "npm run start:prod",
    ];
    await shipit.remote(commands.join(" && "));
  });

  shipit.on("published", function () {
    shipit.start("digituz:build-api");
  });
};
