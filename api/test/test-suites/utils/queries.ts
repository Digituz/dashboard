import { Client } from 'pg';

export async function executeQueries(...queries: string[]) {
  const client = new Client();
  await client.connect();

  for (const query of queries) {
    await client.query(query);
  }

  await client.end();
}
