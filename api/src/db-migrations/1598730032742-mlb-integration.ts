import { MigrationInterface, QueryRunner } from 'typeorm';

export class mlbIntegration1598730032742 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      'alter table product add column mercado_livre_id varchar(30);',
    );
    await queryRunner.query(
      'alter table product add column mercado_livre_category_id varchar(60);',
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      'alter table product drop column mercado_livre_id;',
    );
    await queryRunner.query(
      'alter table product drop column mercado_livre_category_id;',
    );
  }
}
