import { MigrationInterface, QueryRunner } from 'typeorm';

export class customers1594294027020 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
        create table customer (
            id serial primary key,
            cpf varchar(11) not null unique,
            name varchar(60) not null,
            phone_number varchar(24),
            email varchar(60),
            birthday date,
            zip_address varchar(8),
            state varchar(2),
            city varchar(30),
            neighborhood varchar(30),
            street_address varchar(50),
            street_number varchar(10),
            street_number2 varchar(20),
            created_at timestamp with time zone,
            updated_at timestamp with time zone,
            deleted_at timestamp with time zone,
            version integer
        );
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`drop table customer;`);
  }
}
