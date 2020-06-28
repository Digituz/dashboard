import { MigrationInterface, QueryRunner } from 'typeorm';

export class imageDetails1593300501313 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `alter table image add column file_size integer not null;`,
    );
    await queryRunner.query(
      `alter table image add column width integer not null;`,
    );
    await queryRunner.query(
      `alter table image add column height integer not null;`,
    );
    await queryRunner.query(
      `alter table image add column aspect_ratio decimal(13, 2) not null;`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`alter table image drop column file_size;`);
    await queryRunner.query(`alter table image drop column width;`);
    await queryRunner.query(`alter table image drop column height;`);
    await queryRunner.query(`alter table image drop column aspect_ratio;`);
  }
}
