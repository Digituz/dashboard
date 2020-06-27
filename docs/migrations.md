## Prerequisites

- `typeorm` installed globally
- `ts-node` installed globally
- PostgreSQL database up, running, and fed

## Steps

Example to create a new migration for `image-tags`

```bash
cd api

typeorm migration:create -n image-tags
```

The last command generates a file like `api/src/db-migrations/1593177822667-image-tags.ts`. Now, you can insert the code that will adjust the database. To do so, you can check the migrations directory for examples.

After you finish writing the migration, you will need to run it to update you database:

```bash
ts-node ./node_modules/typeorm/cli.js migration:run
```

Note that this will run all the migrations that haven't been run yet. Later, if you need to, you can revert one migration at a time by issuing this:

```bash
ts-node ./node_modules/typeorm/cli.js migration:revert
```

## Tips

- Apparently, `queryRunner.query` accepts only a single SQL command. If you need to run multiple, you will need multiple `queryRunner.query` calls.