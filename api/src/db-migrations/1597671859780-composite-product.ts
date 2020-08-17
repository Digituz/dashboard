import { MigrationInterface, QueryRunner } from 'typeorm';

export class compositeProduct1597671859780 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
            create table product_composition (
                id serial primary key,
                product_id integer not null,
                product_variation_id integer not null,
                version integer,
                constraint fk_product_composition_product foreign key (product_id) references product(id),
                constraint fk_product_composition_product_variation foreign key (product_id) references product(id)
            );
        `);
    await queryRunner.query(
      `create index idx_product_composition_product on product_composition (product_id);`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`drop table product_composition;`);
  }
}
