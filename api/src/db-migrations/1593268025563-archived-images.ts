import { MigrationInterface, QueryRunner } from 'typeorm';

export class archivedImages1593268025563 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `alter table image add column archived boolean not null default false;`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`alter table image drop column number_of_tags`);
  }
}
