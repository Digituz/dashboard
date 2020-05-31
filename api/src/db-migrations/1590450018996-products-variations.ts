import {MigrationInterface, QueryRunner} from "typeorm";

export class productsVariations1590450018996 implements MigrationInterface {

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`
            create table product_variation (
                sku varchar(24) not null,
                product_sku varchar(24) not null,
                description text,
                selling_price decimal(15,2),
                constraint pk_product_variation primary key(sku),
                constraint fk_product_product_variation foreign key (product_sku) references product(sku)
            );
        `);
        await queryRunner.query(`create index idx_product_product_variation on product_variation (product_sku);`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`drop table product_variation;`);
    }
}
