import { MigrationInterface, QueryRunner } from 'typeorm';

export class noVariation1594890063844 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `alter table product add column without_variation boolean not null default true;`,
    );
    await queryRunner.query(
      `alter table product_variation add column no_variation boolean not null default false;`,
    );
    await queryRunner.query(
      `update product set without_variation = true where variations_size = 0;`,
    );
    await queryRunner.query(
      `update product set without_variation = false where variations_size > 0;`,
    );
    await queryRunner.query(`
        insert into product_variation (sku, no_variation, product_id, description, selling_price, version, created_at, updated_at)
            select sku, true, id, 'Tamanho Único', selling_price, 1, now(), now() from product where variations_size = 0;`);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`alter table product drop column no_variation;`);
    await queryRunner.query(`delete from product where no_variation = true;`);
  }
}
