import { Client } from 'pg';

export async function executeQueries(...queries: string[]) {
  const client = new Client();
  await client.connect();

  for (const query of queries) {
    await client.query(query);
  }

  await client.end();
}

export async function cleanUpDatabase() {
  await executeQueries(
    'delete from tag;',
    'delete from product_image;',
    'delete from product_variation;',
    'delete from product;',
    'delete from image;',
  );
}