import { MigrationInterface, QueryRunner } from 'typeorm';

export class productImages1593507529662 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
        create table product_image (
            image_id integer not null,
            product_id integer not null,
            image_order integer not null,
            constraint fk_product_image_image foreign key (image_id) references image(id),
            constraint fk_product_image_product foreign key (product_id) references product(id)
        );
    `);
    await queryRunner.query(
      `create unique index uidx_product_image on product_image(image_id, product_id);`,
    );
    await queryRunner.query(
      `alter table product add column images_size int not null default 0;`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`drop table product_image;`);
    await queryRunner.query(`alter table product drop column images_size`);
  }
}
