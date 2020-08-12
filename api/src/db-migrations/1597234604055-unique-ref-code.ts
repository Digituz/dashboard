import { MigrationInterface, QueryRunner } from 'typeorm';

export class uniqueRefCode1597234604055 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `create unique index uidx_sale_order_reference_code on sale_order(reference_code);`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`drop index uidx_sale_order_reference_code;`);
  }
}
