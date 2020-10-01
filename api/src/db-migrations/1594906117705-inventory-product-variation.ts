import { MigrationInterface, QueryRunner } from 'typeorm';

export class inventoryProductVariation1594906117705
  implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    // sale order
    await queryRunner.query(`delete from sale_order_item;`);
    await queryRunner.query(
      `alter table sale_order_item drop column product_id;`,
    );
    await queryRunner.query(
      `alter table sale_order_item add column product_variation_id integer;`,
    );
    await queryRunner.query(
      `alter table sale_order_item add constraint sale_order_item_product_variation_fk foreign key (product_variation_id) references product_variation(id);`,
    );

    // inventory
    await queryRunner.query(`delete from inventory_movement;`);
    await queryRunner.query(`delete from inventory;`);
    await queryRunner.query(`alter table inventory drop column product_id;`);
    await queryRunner.query(
      `alter table inventory add column product_variation_id integer;`,
    );
    await queryRunner.query(
      `alter table inventory add constraint inventory_product_variation_fk foreign key (product_variation_id) references product_variation(id);`,
    );
    await queryRunner.query(`
        insert into inventory (product_variation_id, current_position, created_at, updated_at, version)
            select id, 0, now(), now(), 1 from product_variation;
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    // sale order
    await queryRunner.query(`delete from sale_order_item;`);
    await queryRunner.query(
      `alter table sale_order_item drop column product_variation_id;`,
    );
    await queryRunner.query(
      `alter table sale_order_item add column product_id integer;`,
    );
    await queryRunner.query(
      `alter table sale_order_item add constraint sale_order_item_product_fk foreign key (product_id) references product(id);`,
    );

    // inventory
    await queryRunner.query(`delete from inventory_movement;`);
    await queryRunner.query(`delete from inventory;`);
    await queryRunner.query(
      `alter table inventory drop column product_variation_id;`,
    );
    await queryRunner.query(
      `alter table inventory add column product_id integer;`,
    );
    await queryRunner.query(
      `alter table inventory add constraint inventory_product_fk foreign key (product_id) references product(id);`,
    );
    await queryRunner.query(`
        insert into inventory (product_id, current_position, created_at, updated_at, version)
            select id, 0, now(), now(), 1 from product;
    `);
  }
}
