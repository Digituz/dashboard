import { MigrationInterface, QueryRunner } from 'typeorm';

export class fixingAddressColumns1598304842907 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `alter table sale_order alter column shipping_street_number_2 type varchar(30);`,
    );
    await queryRunner.query(
      `alter table customer alter column street_number2 type varchar(30);`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `alter table sale_order alter column shipping_street_number_2 type varchar(20);`,
    );
    await queryRunner.query(
      `alter table customer alter column street_number2 type varchar(20);`,
    );
  }
}
