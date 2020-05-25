import {MigrationInterface, QueryRunner} from "typeorm";

export class products1590442910556 implements MigrationInterface {

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`
            create table product (
                id int(11) not null auto_increment,
                sku varchar(24) not null,
                title varchar(60) not null,
                description text,
                selling_price decimal(15,2),
                is_active boolean default true,
                constraint pk_product primary key(id)
            );
        `);
        await queryRunner.query(`create unique index idx_product_sku on product (sku);`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
    }

}
