import { MigrationInterface, QueryRunner } from 'typeorm';

export class mlbCategories1598822283045 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `update product set mercado_livre_category_id = 'MLB1438' where category = 'ANEIS';`,
    );
    await queryRunner.query(
      `update product set mercado_livre_category_id = 'MLB7017' where category = 'BERLOQUES';`,
    );
    await queryRunner.query(
      `update product set mercado_livre_category_id = 'MLB1432' where category = 'BRINCOS';`,
    );
    await queryRunner.query(
      `update product set mercado_livre_category_id = 'MLB1435' where category = 'COLARES';`,
    );
    await queryRunner.query(
      `update product set mercado_livre_category_id = 'MLB1434' where category = 'PULSEIRAS';`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {}
}
