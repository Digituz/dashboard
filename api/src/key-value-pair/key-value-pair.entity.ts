import { PrimaryColumn, Column } from 'typeorm';

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
