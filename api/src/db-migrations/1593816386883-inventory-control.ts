import { MigrationInterface, QueryRunner } from 'typeorm';

export class inventoryControl1593816386883 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
        create table inventory (
            id serial primary key,
            product_id integer not null,
            current_position integer not null default 0,
            created_at timestamp with time zone,
            updated_at timestamp with time zone,
            deleted_at timestamp with time zone,
            version integer,
            constraint fk_inventory_product foreign key (product_id) references product(id)
        );
    `);
    await queryRunner.query(`
        create table inventory_movement (
            id serial primary key,
            inventory_id integer not null,
            amount integer not null,
            description varchar(60) not null,
            created_at timestamp with time zone,
            updated_at timestamp with time zone,
            deleted_at timestamp with time zone,
            version integer,
            constraint fk_inventory_movement_inventory foreign key (inventory_id) references inventory(id)
        );
    `);
    await queryRunner.query(`
        insert into inventory (product_id, current_position, created_at, updated_at, version)
            select id, 0, now(), now(), 1 from product;
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`drop table inventory;`);
    await queryRunner.query(`drop table inventory_movement;`);
  }
}
