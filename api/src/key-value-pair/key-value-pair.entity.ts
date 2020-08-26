import { PrimaryColumn, Column, Entity } from 'typeorm';

@Entity()
export class KeyValuePair {
  @PrimaryColumn()
  key?: string;

  @Column({
    type: 'varchar',
    length: 90,
    nullable: false,
  })
  value: string;
}
