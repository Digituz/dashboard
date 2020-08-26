import { MigrationInterface, QueryRunner } from 'typeorm';

export class shopifyInventory1598401220854 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      'alter table product_variation add column shopify_id bigint;',
    );
    await queryRunner.query(
      'alter table product_variation add column shopify_inventory_id bigint;',
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      'alter table product_variation drop column shopify_id;',
    );
    await queryRunner.query(
      'alter table inventory drop column shopify_inventory_id;',
    );
  }
}
