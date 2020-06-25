// {
//     fieldname: 'file',
//     originalname: 'logo-320.jpg',
//     encoding: '7bit',
//     mimetype: 'image/jpeg',
//     destination: '/tmp/uploaded-files',
//     filename: '6a54f1865a75a1fe70b69696073a6d78',
//     path: '/tmp/uploaded-files/6a54f1865a75a1fe70b69696073a6d78',
//     size: 20343
// }

import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';
import { BaseEntity } from '../util/base-entity';

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
}
