import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

import { Image } from './media-library/image.entity';
import { ProductsModule } from './products/products.module';
import { Product } from './products/entities/product.entity';
import { ProductVariation } from './products/entities/product-variation.entity';
import { MediaLibraryModule } from './media-library/media-library.module';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'mysql',
      host: process.env.DATABASE_HOST,
      port: parseInt(process.env.DATABASE_PORT),
      username: process.env.DATABASE_USER,
      password: process.env.DATABASE_PASSWORD,
      database: process.env.DATABASE_NAME,
      entities: [Product, ProductVariation, Image],
      synchronize: false,
      migrationsTableName: 'database_migrations',
      migrations: ['src/db-migrations/*.js'],
      cli: {
        migrationsDir: 'src/db-migrations',
      },
    }),
    ProductsModule,
    MediaLibraryModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
