import { MigrationInterface, QueryRunner } from 'typeorm';

export class numberOfTags1593254766379 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `alter table image add column number_of_tags int not null default 0;`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`alter table image drop column number_of_tags`);
  }
}
