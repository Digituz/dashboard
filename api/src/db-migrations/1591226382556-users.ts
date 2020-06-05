import { MigrationInterface, QueryRunner } from 'typeorm';

export class users1591226382556 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
            create table user (
                id int(11) auto_increment not null,
                name varchar(75) not null,
                email varchar(150) not null,
                password varchar(150) not null,
                constraint pk_users primary key(id)
            );
        `);
    await queryRunner.query(`insert into user (name, email, password) values ("Bruno Krebs", "bruno.krebs@fridakahlo.com.br", "lbX01as$");`);
    await queryRunner.query(`insert into user (name, email, password) values ("Lena Vettoretti", "lena@fridakahlo.com.br", "lbX01as$");`);
    await queryRunner.query(`insert into user (name, email, password) values ("Fabíola Pires", "admin@fridakahlo.com.br", "lbX01as$");`);
    await queryRunner.query(`insert into user (name, email, password) values ("Agnes Romeu", "agnessromeu@gmail.com", "lbX01as$");`);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`drop table user;`);
  }
}
