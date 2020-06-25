import { Entity, Column } from 'typeorm';
import { BaseEntity } from '../util/base-entity';

@Entity()
export class Tag extends BaseEntity {
  @Column({
    name: 'label',
    type: 'varchar',
    length: 24,
    unique: true,
    nullable: false,
  })
  label: string;

  @Column({
    name: 'description',
    type: 'varchar',
    length: 60,
    unique: true,
    nullable: false,
  })
  description: string;
}
