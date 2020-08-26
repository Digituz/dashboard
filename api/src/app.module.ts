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
import { Inventory } from './inventory/inventory.entity';
import { InventoryMovement } from './inventory/inventory-movement.entity';
import { CustomersModule } from './customers/customers.module';
import { Customer } from './customers/customer.entity';
import { SalesOrderModule } from './sales-order/sales-order.module';
import { SaleOrderItem } from './sales-order/entities/sale-order-item.entity';
import { SaleOrder } from './sales-order/entities/sale-order.entity';
import { BlingModule } from './bling/bling.module';
import { ProductComposition } from './products/entities/product-composition.entity';
import { MarketplacesModule } from './marketplaces/marketplaces.module';
import { KeyValuePair } from './key-value-pair/key-value-pair.entity';
import { KeyValuePairService } from './key-value-pair/key-value-pair.service';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: process.env.DATABASE_HOST,
      port: parseInt(process.env.DATABASE_PORT),
      username: process.env.DATABASE_USER,
      password: process.env.DATABASE_PASSWORD,
      database: process.env.DATABASE_NAME,
      entities: [
        Customer,
        Inventory,
        InventoryMovement,
        Product,
        ProductComposition,
        ProductVariation,
        ProductImage,
        Image,
        User,
        SaleOrder,
        SaleOrderItem,
        Tag,
        KeyValuePair,
      ],
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
    CustomersModule,
    SalesOrderModule,
    BlingModule,
    MarketplacesModule,
    TypeOrmModule.forFeature([KeyValuePair]),
  ],
  controllers: [],
  providers: [KeyValuePairService],
})
export class AppModule {}
