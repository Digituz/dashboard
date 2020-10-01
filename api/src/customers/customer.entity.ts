import { BaseEntity } from '../util/base-entity';
import { Entity, Column } from 'typeorm';

@Entity()
export class Customer extends BaseEntity {
  @Column({
    name: 'cpf',
    type: 'varchar',
    length: 11,
    unique: true,
    nullable: false,
  })
  cpf: string;

  @Column({
    name: 'name',
    type: 'varchar',
    length: 60,
    unique: false,
    nullable: false,
  })
  name: string;

  @Column({
    name: 'phone_number',
    type: 'varchar',
    length: 24,
    unique: false,
    nullable: true,
  })
  phoneNumber?: string;

  @Column({
    name: 'email',
    type: 'varchar',
    length: 60,
    unique: false,
    nullable: true,
  })
  email?: string;

  @Column({
    name: 'birthday',
    type: 'date',
    unique: false,
    nullable: true,
  })
  birthday?: Date | string;

  @Column({
    name: 'zip_address',
    type: 'varchar',
    length: 8,
    unique: false,
    nullable: true,
  })
  zipAddress?: string;

  @Column({
    name: 'state',
    type: 'varchar',
    length: 2,
    unique: false,
    nullable: true,
  })
  state?: string;

  @Column({
    name: 'city',
    type: 'varchar',
    length: 30,
    unique: false,
    nullable: true,
  })
  city?: string;

  @Column({
    name: 'neighborhood',
    type: 'varchar',
    length: 30,
    unique: false,
    nullable: true,
  })
  neighborhood?: string;

  @Column({
    name: 'street_address',
    type: 'varchar',
    length: 50,
    unique: false,
    nullable: true,
  })
  streetAddress?: string;

  @Column({
    name: 'street_number',
    type: 'varchar',
    length: 10,
    unique: false,
    nullable: true,
  })
  streetNumber?: string;

  @Column({
    name: 'street_number2',
    type: 'varchar',
    length: 20,
    unique: false,
    nullable: true,
  })
  streetNumber2?: string;
}
