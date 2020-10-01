import { MigrationInterface, QueryRunner } from 'typeorm';

export class saleOrderDate1596497372893 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      'alter table sale_order add column creation_date timestamp;',
    );
    await queryRunner.query(
      'alter table sale_order add column approval_date timestamp;',
    );
    await queryRunner.query(
      'alter table sale_order add column cancellation_date timestamp;',
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      'alter table sale_order drop column creation_date;',
    );
    await queryRunner.query(
      'alter table sale_order drop column approval_date;',
    );
    await queryRunner.query(
      'alter table sale_order drop column cancellation_date;',
    );
  }
}
