import { MigrationInterface, QueryRunner } from 'typeorm';

export class products1590442910556 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
            create table product (
                id serial primary key,
                sku varchar(24) not null unique,
                title varchar(60) not null,
                description text,
                product_details text,
                selling_price decimal(15,2),
                height decimal(15,3),
                width decimal(15,3),
                length decimal(15,3),
                weight decimal(15,3),
                is_active boolean default true,
                ncm varchar(10) not null,
                created_at timestamp with time zone,
                updated_at timestamp with time zone,
                deleted_at timestamp with time zone,
                version integer
            );
        `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`drop table product;`);
  }
}
