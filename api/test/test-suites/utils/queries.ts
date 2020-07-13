import { Client } from 'pg';

export async function executeQuery(query: string) {
  const client = new Client();
  await client.connect();

  const queryResult = await client.query(query);

  await client.end();

  return queryResult.rows;
}

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
    'delete from sale_order_item;',
    'delete from sale_order;',
    'delete from customer;',
    'delete from tag;',
    'delete from inventory_movement;',
    'delete from inventory;',
    'delete from product_image;',
    'delete from product_variation;',
    'delete from product;',
    'delete from image;',
  );
}
