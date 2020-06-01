import { Module } from '@nestjs/common';
import { MediaLibraryController } from './media-library.controller';
import { MulterModule } from '@nestjs/platform-express';

@Module({
  controllers: [MediaLibraryController],
  imports: [MulterModule.register({
    dest: './uploaded-files',
  })],
})
export class MediaLibraryModule {}
