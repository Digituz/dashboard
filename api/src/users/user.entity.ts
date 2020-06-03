import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class User {
  @PrimaryGeneratedColumn({
    name: 'id',
    type: 'number',
  })
  id: number;

  @Column({
    name: 'name',
    type: 'varchar',
    length: 75,
    nullable: false,
  })
  name: string;

  @Column({
    name: 'email',
    type: 'varchar',
    length: 150,
    nullable: false,
  })
  email: string;

  @Column({
    name: 'password',
    type: 'varchar',
    length: 150,
    nullable: false,
  })
  password?: string;
}
