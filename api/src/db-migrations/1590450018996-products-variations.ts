import { MigrationInterface, QueryRunner } from 'typeorm';

export class productsVariations1590450018996 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
            create table product_variation (
                id serial primary key,
                sku varchar(24) not null unique,
                product_id integer not null,
                description text,
                selling_price decimal(15,2),
                created_at timestamp with time zone,
                updated_at timestamp with time zone,
                deleted_at timestamp with time zone,
                version integer,
                constraint fk_product_product_variation foreign key (product_id) references product(id)
            );
        `);
    await queryRunner.query(
      `create index idx_product_product_variation on product_variation (product_id);`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`drop table product_variation;`);
  }
}
