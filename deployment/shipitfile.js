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
    await shipit.local("cd ../ && git secret reveal")

    await shipit.copyToRemote('../api/production.env', `${shipit.releasePath}/api`);

    const commands = [
      `cd ${shipit.releasePath}`,
      `cd ${shipit.releasePath}/api`,
      "mv production.env .env",
      "npm install --prooduction",
      "npm run build",
      "npx ts-node ./node_modules/typeorm/cli.js migration:run",
      "pm2 delete dashboard-api",
      "pm2 start npm --name dashboard-api -- run start:prod",
      "pm2 save",
    ];
    await shipit.remote(commands.join(" && "));
  });

  shipit.on("published", function () {
    shipit.start("digituz:build-api");
  });
};
