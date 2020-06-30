import { Module } from '@nestjs/common';
import { MulterModule } from '@nestjs/platform-express';

import { Image } from './image.entity';
import { ImagesService } from './images.service';
import { MediaLibraryController } from './media-library.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { TagsModule } from '../tags/tags.module';

@Module({
  imports: [
    MulterModule.register({
      dest: process.env.UPLOAD_DESTINATION,
    }),
    TypeOrmModule.forFeature([Image]),
    TagsModule,
  ],
  controllers: [MediaLibraryController],
  providers: [ImagesService],
  exports: [ImagesService],
})
export class MediaLibraryModule {}
