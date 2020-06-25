import { MigrationInterface, QueryRunner } from 'typeorm';

export class variationsSize1592126793246 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `alter table product add column variations_size int;`,
    );
    await queryRunner.query(`
        update product set variations_size = (
            select count(1) from product_variation
            where product_variation.product_id = product.id
            group by product_id
        );`);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`alter table product drop column variations_size`);
  }
}
