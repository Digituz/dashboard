import { MigrationInterface, QueryRunner } from 'typeorm';

export class removeAutoTimestamps1594992375542 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`alter table app_user drop column created_at;`);
    await queryRunner.query(`alter table app_user drop column updated_at;`);
    await queryRunner.query(`alter table app_user drop column deleted_at;`);

    await queryRunner.query(`alter table customer drop column created_at;`);
    await queryRunner.query(`alter table customer drop column updated_at;`);
    await queryRunner.query(`alter table customer drop column deleted_at;`);

    await queryRunner.query(`alter table image drop column created_at;`);
    await queryRunner.query(`alter table image drop column updated_at;`);
    await queryRunner.query(`alter table image drop column deleted_at;`);

    await queryRunner.query(`alter table inventory drop column created_at;`);
    await queryRunner.query(`alter table inventory drop column updated_at;`);
    await queryRunner.query(`alter table inventory drop column deleted_at;`);

    await queryRunner.query(
      `alter table inventory_movement drop column created_at;`,
    );
    await queryRunner.query(
      `alter table inventory_movement drop column updated_at;`,
    );
    await queryRunner.query(
      `alter table inventory_movement drop column deleted_at;`,
    );

    await queryRunner.query(`alter table product drop column created_at;`);
    await queryRunner.query(`alter table product drop column updated_at;`);
    await queryRunner.query(`alter table product drop column deleted_at;`);

    await queryRunner.query(
      `alter table product_variation drop column created_at;`,
    );
    await queryRunner.query(
      `alter table product_variation drop column updated_at;`,
    );
    await queryRunner.query(
      `alter table product_variation drop column deleted_at;`,
    );

    await queryRunner.query(`alter table sale_order drop column created_at;`);
    await queryRunner.query(`alter table sale_order drop column updated_at;`);
    await queryRunner.query(`alter table sale_order drop column deleted_at;`);

    await queryRunner.query(
      `alter table sale_order_item drop column created_at;`,
    );
    await queryRunner.query(
      `alter table sale_order_item drop column updated_at;`,
    );
    await queryRunner.query(
      `alter table sale_order_item drop column deleted_at;`,
    );

    await queryRunner.query(`alter table tag drop column created_at;`);
    await queryRunner.query(`alter table tag drop column updated_at;`);
    await queryRunner.query(`alter table tag drop column deleted_at;`);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `alter table app_user add column created_at timestamp with time zone;`,
    );
    await queryRunner.query(
      `alter table app_user add column updated_at timestamp with time zone;`,
    );
    await queryRunner.query(
      `alter table app_user add column deleted_at timestamp with time zone;`,
    );

    await queryRunner.query(
      `alter table customer add column created_at timestamp with time zone;`,
    );
    await queryRunner.query(
      `alter table customer add column updated_at timestamp with time zone;`,
    );
    await queryRunner.query(
      `alter table customer add column deleted_at timestamp with time zone;`,
    );

    await queryRunner.query(
      `alter table image add column created_at timestamp with time zone;`,
    );
    await queryRunner.query(
      `alter table image add column updated_at timestamp with time zone;`,
    );
    await queryRunner.query(
      `alter table image add column deleted_at timestamp with time zone;`,
    );

    await queryRunner.query(
      `alter table inventory add column created_at timestamp with time zone;`,
    );
    await queryRunner.query(
      `alter table inventory add column updated_at timestamp with time zone;`,
    );
    await queryRunner.query(
      `alter table inventory add column deleted_at timestamp with time zone;`,
    );

    await queryRunner.query(
      `alter table inventory_movement add column created_at timestamp with time zone;`,
    );
    await queryRunner.query(
      `alter table inventory_movement add column updated_at timestamp with time zone;`,
    );
    await queryRunner.query(
      `alter table inventory_movement add column deleted_at timestamp with time zone;`,
    );

    await queryRunner.query(
      `alter table product add column created_at timestamp with time zone;`,
    );
    await queryRunner.query(
      `alter table product add column updated_at timestamp with time zone;`,
    );
    await queryRunner.query(
      `alter table product add column deleted_at timestamp with time zone;`,
    );

    await queryRunner.query(
      `alter table product_variation add column created_at timestamp with time zone;`,
    );
    await queryRunner.query(
      `alter table product_variation add column updated_at timestamp with time zone;`,
    );
    await queryRunner.query(
      `alter table product_variation add column deleted_at timestamp with time zone;`,
    );

    await queryRunner.query(
      `alter table sale_order add column created_at timestamp with time zone;`,
    );
    await queryRunner.query(
      `alter table sale_order add column updated_at timestamp with time zone;`,
    );
    await queryRunner.query(
      `alter table sale_order add column deleted_at timestamp with time zone;`,
    );

    await queryRunner.query(
      `alter table sale_order_item add column created_at timestamp with time zone;`,
    );
    await queryRunner.query(
      `alter table sale_order_item add column updated_at timestamp with time zone;`,
    );
    await queryRunner.query(
      `alter table sale_order_item add column deleted_at timestamp with time zone;`,
    );

    await queryRunner.query(
      `alter table tag add column created_at timestamp with time zone;`,
    );
    await queryRunner.query(
      `alter table tag add column updated_at timestamp with time zone;`,
    );
    await queryRunner.query(
      `alter table tag add column deleted_at timestamp with time zone;`,
    );
  }
}
