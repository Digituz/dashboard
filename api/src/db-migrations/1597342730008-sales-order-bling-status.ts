import { MigrationInterface, QueryRunner } from 'typeorm';

export class salesOrderBlingStatus1597342730008 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      'alter table sale_order add column bling_status varchar(30);',
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query('alter table sale_order drop column bling_status;');
  }
}
