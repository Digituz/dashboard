import { MigrationInterface, QueryRunner } from 'typeorm';

export class images1591067635452 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
            create table image (
                id serial primary key,
                main_filename varchar(140) not null unique,
                original_filename varchar(140) not null,
                mimetype varchar(30) not null,
                original_file_url varchar(400) not null,
                extra_large_file_url varchar(400) not null,
                large_file_url varchar(400) not null,
                medium_file_url varchar(400) not null,
                small_file_url varchar(400) not null,
                thumbnail_file_url varchar(400) not null,
                created_at timestamp with time zone,
                updated_at timestamp with time zone,
                deleted_at timestamp with time zone,
                version integer
            );
        `);
    await queryRunner.query(
      `create unique index uidx_image_original_file_url on image(original_file_url);`,
    );
    await queryRunner.query(
      `create unique index uidx_image_extra_large_file_url on image(extra_large_file_url);`,
    );
    await queryRunner.query(
      `create unique index uidx_image_large_file_url on image(large_file_url);`,
    );
    await queryRunner.query(
      `create unique index uidx_image_medium_file_url on image(medium_file_url);`,
    );
    await queryRunner.query(
      `create unique index uidx_image_small_file_url on image(small_file_url);`,
    );
    await queryRunner.query(
      `create unique index uidx_image_thumbnail_file_url on image(thumbnail_file_url);`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`drop table image;`);
  }
}
