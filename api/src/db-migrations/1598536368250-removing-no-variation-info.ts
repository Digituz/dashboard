import { MigrationInterface, QueryRunner } from 'typeorm';

export class removingNoVariationInfo1598536368250
  implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `alter table product_variation drop column no_variation;`,
    );
    await queryRunner.query(
      `alter table product drop column without_variation;`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {}
}
