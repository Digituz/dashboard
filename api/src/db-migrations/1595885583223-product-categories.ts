import { MigrationInterface, QueryRunner } from 'typeorm';

export class productCategories1595885583223 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      'alter table product add column category varchar(60);',
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query('alter table product drop column category;');
  }
}
