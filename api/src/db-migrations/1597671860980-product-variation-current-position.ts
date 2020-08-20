import { MigrationInterface, QueryRunner } from 'typeorm';

export class productVariationCurrentPosition1597671860980
  implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      'alter table product_variation add column current_position integer;',
    );

    await queryRunner.query(`
        update product_variation pv set current_position = (
            select current_position from inventory
            where inventory.product_variation_id = pv.id
        );`);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      'alter table product_variation drop column current_position;',
    );
  }
}
