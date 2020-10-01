import { MigrationInterface, QueryRunner } from 'typeorm';

export class berloqueDimensions1598915690486 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `update product set height = 1, width = 1, length = 1 where category = 'BERLOQUES' and title ilike '%passador%';`,
    );
    await queryRunner.query(
      `update product set height = 0.1, width = 1, length = 1 where category = 'BERLOQUES' and title not ilike '%passador%';`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `update product set height = null, width = null, length = null where category = 'BERLOQUES';`,
    );
  }
}
