import { MigrationInterface, QueryRunner } from 'typeorm';

export class productAdjustments1593743578245 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `update product set variations_size = 0 where variations_size is null;`,
    );
    await queryRunner.query(
      `alter table product alter column variations_size set not null;`,
    );
    await queryRunner.query(
      `alter table product alter column variations_size set default 0;`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `alter table product alter column variations_size drop not null;`,
    );
    await queryRunner.query(
      `alter table product alter column variations_size drop default;`,
    );
  }
}
