import { MigrationInterface, QueryRunner } from 'typeorm';

export class users1591226382556 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
            create table app_user (
              id serial primary key,
              name varchar(75) not null,
              email varchar(150) not null,
              password varchar(150) not null,
              created_at timestamp with time zone,
              updated_at timestamp with time zone,
              deleted_at timestamp with time zone,
              version integer
            );
        `);
    await queryRunner.query(
      `insert into app_user (name, email, password) values ('Bruno Krebs', 'bruno.krebs@fridakahlo.com.br', 'lbX01as$');`,
    );
    await queryRunner.query(
      `insert into app_user (name, email, password) values ('Lena Vettoretti', 'lena@fridakahlo.com.br', 'lbX01as$');`,
    );
    await queryRunner.query(
      `insert into app_user (name, email, password) values ('Fabíola Pires', 'admin@fridakahlo.com.br', 'lbX01as$');`,
    );
    await queryRunner.query(
      `insert into app_user (name, email, password) values ('Agnes Romeu', 'agnessromeu@gmail.com', 'lbX01as$');`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`drop table app_user;`);
  }
}
