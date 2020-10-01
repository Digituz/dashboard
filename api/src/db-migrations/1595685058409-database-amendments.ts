import { MigrationInterface, QueryRunner } from 'typeorm';

export class databaseAmendments1595685058409 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      'alter table sale_order drop column shipping_price;',
    );
    await queryRunner.query(
      'alter table sale_order add column shipping_price decimal(15,2) not null;',
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      'alter table sale_order drop column shipping_price;',
    );
    await queryRunner.query(
      'alter table sale_order add column shipping_price varchar(60) not null;',
    );
  }
}
