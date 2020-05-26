import {MigrationInterface, QueryRunner} from "typeorm";

export class productsVariations1590450018996 implements MigrationInterface {

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`
            create table product_variation (
                id int(11) not null auto_increment,
                product_id int(11) not null,
                sku varchar(24) not null,
                description text,
                selling_price decimal(15,2),
                constraint pk_product_variation primary key(id),
                constraint fk_product_product_variation foreign key (product_id) references product(id)
            );
        `);
        await queryRunner.query(`create unique index idx_product_variation_sku on product_variation (sku);`);
        await queryRunner.query(`create index idx_product_product_variation on product_variation (product_id);`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`drop table product_variation;`);
    }
}
