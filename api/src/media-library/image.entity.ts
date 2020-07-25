import { Entity, Column, ManyToMany, JoinTable } from 'typeorm';
import { BaseEntity } from '../util/base-entity';
import { Tag } from '../tags/tag.entity';
import { NumericTransformer } from '../util/numeric-transformer';

@Entity()
export class Image extends BaseEntity {
  @Column({
    name: 'main_filename',
    type: 'varchar',
    length: 140,
    unique: true,
    nullable: false,
  })
  mainFilename: string;

  @Column({
    name: 'original_filename',
    type: 'varchar',
    length: 140,
    nullable: false,
  })
  originalFilename: string;

  @Column({
    name: 'mimetype',
    type: 'varchar',
    length: 30,
    nullable: false,
  })
  mimetype: string;

  @Column({
    name: 'original_file_url',
    type: 'varchar',
    length: 400,
    unique: true,
    nullable: false,
  })
  originalFileURL: string;

  @Column({
    name: 'extra_large_file_url',
    type: 'varchar',
    length: 400,
    unique: true,
    nullable: false,
  })
  extraLargeFileURL: string;

  @Column({
    name: 'large_file_url',
    type: 'varchar',
    length: 400,
    unique: true,
    nullable: false,
  })
  largeFileURL: string;

  @Column({
    name: 'medium_file_url',
    type: 'varchar',
    length: 400,
    unique: true,
    nullable: false,
  })
  mediumFileURL: string;

  @Column({
    name: 'small_file_url',
    type: 'varchar',
    length: 400,
    unique: true,
    nullable: false,
  })
  smallFileURL: string;

  @Column({
    name: 'thumbnail_file_url',
    type: 'varchar',
    length: 400,
    unique: true,
    nullable: false,
  })
  thumbnailFileURL: string;

  @ManyToMany(type => Tag)
  @JoinTable({
    name: 'image_tag',
    joinColumn: { name: 'image_id' },
    inverseJoinColumn: { name: 'tag_id' },
  })
  tags?: Tag[];

  @Column({
    name: 'number_of_tags',
    type: 'int',
    unique: false,
    nullable: false,
  })
  numberOfTags?: number = 0;

  @Column({
    name: 'archived',
    type: 'boolean',
    unique: false,
    nullable: false,
  })
  archived?: boolean = false;

  @Column({
    name: 'file_size',
    type: 'integer',
    unique: false,
    nullable: false,
  })
  fileSize: number = 0;

  @Column({
    name: 'width',
    type: 'integer',
    unique: false,
    nullable: false,
  })
  width: number = 0;

  @Column({
    name: 'height',
    type: 'integer',
    unique: false,
    nullable: false,
  })
  height: number = 0;

  @Column({
    name: 'aspect_ratio',
    type: 'integer',
    unique: false,
    nullable: false,
    transformer: new NumericTransformer(),
  })
  aspectRatio: number = 0;
}
