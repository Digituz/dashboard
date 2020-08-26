import { MigrationInterface, QueryRunner } from 'typeorm';

export class util1598469624900 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
        create table key_value_pair (
            key varchar(30) primary key,
            value varchar(90) not null
        );
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`drop table key_value_pair;`);
  }
}
