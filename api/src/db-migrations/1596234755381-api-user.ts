import { MigrationInterface, QueryRunner } from 'typeorm';

export class apiUser1596234755381 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `insert into app_user (name, email, password) values ('Integração Site Frida Kahlo', 'api-user@fridakahlo.com.br', 'jas41Hm_1lPO');`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `delete from app_user where email = 'api-user@fridakahlo.com.br';`,
    );
  }
}
