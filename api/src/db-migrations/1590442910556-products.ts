import {MigrationInterface, QueryRunner} from "typeorm";

export class products1590442910556 implements MigrationInterface {

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`
            create table product (
                sku varchar(24) not null,
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
                constraint pk_product primary key(sku)
            );
        `);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`drop table product;`);
    }
}
