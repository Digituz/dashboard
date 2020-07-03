import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

import { Image } from './media-library/image.entity';
import { ProductsModule } from './products/products.module';
import { Product } from './products/entities/product.entity';
import { ProductVariation } from './products/entities/product-variation.entity';
import { MediaLibraryModule } from './media-library/media-library.module';
import { AuthModule } from './auth/auth.module';
import { UsersModule } from './users/users.module';
import { User } from './users/user.entity';
import { TagsModule } from './tags/tags.module';
import { Tag } from './tags/tag.entity';
import { ProductImage } from './products/entities/product-image.entity';
import { InventoryModule } from './inventory/inventory.module';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: process.env.DATABASE_HOST,
      port: parseInt(process.env.DATABASE_PORT),
      username: process.env.DATABASE_USER,
      password: process.env.DATABASE_PASSWORD,
      database: process.env.DATABASE_NAME,
      entities: [Product, ProductVariation, ProductImage, Image, User, Tag],
      synchronize: false,
      migrationsTableName: 'database_migrations',
      migrations: ['src/db-migrations/*.js'],
      cli: {
        migrationsDir: 'src/db-migrations',
      },
      logging: !!process.env.LOG_SQL_QUERIES,
    }),
    ProductsModule,
    MediaLibraryModule,
    AuthModule,
    UsersModule,
    TagsModule,
    InventoryModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
