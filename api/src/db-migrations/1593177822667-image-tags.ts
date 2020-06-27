import { MigrationInterface, QueryRunner } from 'typeorm';

export class imageTags1593177822667 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
        create table image_tag (
            image_id integer not null,
            tag_id integer not null,
            constraint fk_image_tag_image foreign key (image_id) references image(id),
            constraint fk_image_tag_tag foreign key (tag_id) references tag(id)
        );
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`drop table image_tag;`);
  }
}
