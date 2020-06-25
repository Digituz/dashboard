import {
  PrimaryGeneratedColumn,
  VersionColumn,
  CreateDateColumn,
  UpdateDateColumn,
  DeleteDateColumn,
} from 'typeorm';

export abstract class BaseEntity {
  @PrimaryGeneratedColumn()
  id?: number;

  @CreateDateColumn({ name: 'created_at', type: 'timestamp with time zone', nullable: false })
  createdAt?: Date;

  @UpdateDateColumn({ name: 'updated_at', type: 'timestamp with time zone', nullable: true })
  updatedAt?: Date;

  @DeleteDateColumn({ name: 'deleted_at', type: 'timestamp with time zone', nullable: true })
  deletedAt?: Date;

  @VersionColumn() version?: number;
}
