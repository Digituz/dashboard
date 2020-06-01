import { Module } from '@nestjs/common';
import { MediaLibraryController } from './media-library.controller';

@Module({
  controllers: [MediaLibraryController]
})
export class MediaLibraryModule {}
