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
                is_active boolean default true,
                constraint pk_product primary key(sku)
            );
        `);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`drop table product;`);
    }
}
