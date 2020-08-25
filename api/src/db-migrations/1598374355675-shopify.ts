import { MigrationInterface, QueryRunner } from 'typeorm';

export class shopify1598374355675 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      'alter table product add column shopify_id bigint;',
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query('alter table product drop column shopify_id;');
  }
}
