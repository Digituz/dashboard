import { Test, TestingModule } from '@nestjs/testing';
import { MediaLibraryController } from './media-library.controller';

describe('MediaLibrary Controller', () => {
  let controller: MediaLibraryController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [MediaLibraryController],
    }).compile();

    controller = module.get<MediaLibraryController>(MediaLibraryController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
