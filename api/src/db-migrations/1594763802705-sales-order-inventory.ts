import { MigrationInterface, QueryRunner } from 'typeorm';

export class salesOrderInventory1594763802705 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `alter table inventory_movement add column sale_order_id integer;`,
    );
    await queryRunner.query(
      `alter table inventory_movement add constraint inventory_movement_sale_order_fk foreign key (sale_order_id) references sale_order(id);`,
    );
    await queryRunner.query(
      `alter table product_image add column id serial primary key;`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`alter table product_image drop column id;`);
    await queryRunner.query(
      `alter table inventory_movement drop constraint inventory_movement_sale_order_fk;`,
    );
    await queryRunner.query(
      `alter table inventory_movement drop column sale_order_id;`,
    );
  }
}
