import { MigrationInterface, QueryRunner } from 'typeorm';

export class tags1593080022054 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
                create table tag (
                  id serial primary key,
                  label varchar(24) not null unique,
                  description varchar(60) not null,
                  created_at timestamp with time zone,
                  updated_at timestamp with time zone,
                  deleted_at timestamp with time zone,
                  version integer
                );
            `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`drop table tag;`);
  }
}
