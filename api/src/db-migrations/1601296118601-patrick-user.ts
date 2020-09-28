import { MigrationInterface, QueryRunner } from 'typeorm';

export class patrickUser1601296118601 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `insert into app_user (name, email, password) values ('Patrick Niceiz', 'patrickk0806@gmail.com', '0806@Bleach');`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `delete from app_user where email = 'patrickk0806@gmail.com';`,
    );
  }
}
