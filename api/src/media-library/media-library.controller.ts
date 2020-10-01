import S3 from 'aws-sdk/clients/s3';
import {
  Controller,
  Post,
  UseInterceptors,
  UploadedFile,
  UseGuards,
  Get,
  Body,
  Param,
  Delete,
  UseFilters,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import execa from 'execa';
import Kraken from 'kraken';

import { Image } from './image.entity';
import { ImagesService } from './images.service';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { TagsService } from '../tags/tags.service';
import { GlobalExceptionsFilter } from '../global-exceptions.filter';

const transformations = [
  { id: 'thumbnail', width: 90, height: 90, strategy: 'auto', enhance: true },
  { id: 'small', width: 180, height: 180, strategy: 'auto', enhance: true },
  { id: 'medium', width: 360, height: 360, strategy: 'auto' },
  { id: 'large', width: 720, height: 720, strategy: 'auto' },
  { id: 'extra-large', width: 1080, height: 1080, strategy: 'auto' },
  { id: 'original', strategy: 'none' },
];

interface ImageType {
  mimetype: string;
  extension: string;
}

const supportedImageTypes: ImageType[] = [
  { mimetype: 'image/jpeg', extension: '.jpg' },
  { mimetype: 'image/png', extension: '.png' },
];

const kraken = new Kraken({
  api_key: process.env.KRAKEN_API_KEY,
  api_secret: process.env.KRAKEN_API_SECRET,
});

@Controller('media-library')
@UseGuards(JwtAuthGuard)
@UseFilters(new GlobalExceptionsFilter())
export class MediaLibraryController {
  constructor(
    private imagesService: ImagesService,
    private tagsService: TagsService,
  ) {}

  private removeFileFromDisk(file: string) {
    return new Promise((res, rej) => {
      execa('rm', [file])
        .then(res)
        .catch(rej);
    });
  }

  private resize(imagePath: string, fileSuffix: string, imageType: ImageType) {
    return new Promise((res, rej) => {
      const resizeJobConfig = {
        file: imagePath,
        lossy: true,
        wait: true,
        resize: transformations.map(transformation => {
          return {
            ...transformation,
            storage_path: `${fileSuffix}-${transformation.id}${imageType.extension}`,
          };
        }),
        s3_store: {
          key: process.env.AWS_S3_KEY,
          secret: process.env.AWS_S3_SECRET,
          bucket: process.env.AWS_S3_BUCKET,
          region: 'sa-east-1',
        },
      };

      kraken.upload(resizeJobConfig, (err, data) => {
        if (err) return rej(err);
        if (!data.success) rej('error on upload to kraken');
        if (!data.results || !data.results.original)
          rej('unexpected error on upload to kraken');
        res(data.results);
      });
    });
  }

  @Post('upload')
  @UseInterceptors(FileInterceptor('file'))
  async processFile(@UploadedFile() file): Promise<Image> {
    // file type (mimetype)
    const imageType = supportedImageTypes.find(
      imageType => imageType.mimetype === file.mimetype,
    );

    // preparing the file name
    const now = Date.now();
    const indexOfFileExtensionSeparator = file.originalname.lastIndexOf('.');
    const fileNameWithoutExtension = file.originalname.substr(
      0,
      indexOfFileExtensionSeparator,
    );
    const fileSuffix = `${fileNameWithoutExtension}-${now}`;

    // resizing the image into different dimensions
    let resizedResult;
    try {
      resizedResult = await this.resize(file.path, fileSuffix, imageType);
    } catch (err) {
      // second attempt
      try {
        resizedResult = await this.resize(file.path, fileSuffix, imageType);
      } catch (err) {
        // third and last attempt
        resizedResult = await this.resize(file.path, fileSuffix, imageType);
      }
    }
    const originalImage = resizedResult['original'];

    // removing from disk, as they have been uploaded to the CDN
    await this.removeFileFromDisk(file.path);

    // recording everything into the database, for easier reference
    // ps. while uploading, the name of the file suffers a transformation similar to encodeURIComponent, so we use it
    const image: Image = {
      mainFilename: `${fileSuffix}-original-${imageType.extension}`,
      originalFilename: file.originalname,
      mimetype: 'image/jpeg',
      originalFileURL: resizedResult['original'].kraked_url,
      extraLargeFileURL: resizedResult['extra-large'].kraked_url,
      largeFileURL: resizedResult['large'].kraked_url,
      mediumFileURL: resizedResult['medium'].kraked_url,
      smallFileURL: resizedResult['small'].kraked_url,
      thumbnailFileURL: resizedResult['thumbnail'].kraked_url,
      fileSize: originalImage.kraked_size,
      aspectRatio: originalImage.original_width / originalImage.original_height,
      width: originalImage.original_width,
      height: originalImage.original_height,
    };
    return this.imagesService.save(image);
  }

  @Get()
  findAll(): Promise<Image[]> {
    return this.imagesService.findAll();
  }

  @Get('with-tag/:tagLabel')
  findAllWithTag(@Param('tagLabel') tagLabel: string): Promise<Image[]> {
    return this.imagesService.findAllWithTag(tagLabel);
  }

  @Get(':imageId')
  find(@Param('imageId') imageId: number): Promise<Image> {
    return this.imagesService.findById(imageId);
  }

  @Post(':imageId')
  async save(
    @Body() tags: string[],
    @Param('imageId') imageId: number,
  ): Promise<Image> {
    const image = await this.imagesService.findById(imageId);
    const newTags = await this.tagsService.findByLabels(tags);
    image.tags = newTags;
    image.numberOfTags = newTags.length;
    return this.imagesService.save(image);
  }

  @Delete(':imageId')
  async archiveImage(@Param('imageId') imageId: number): Promise<Image> {
    const image = await this.imagesService.findById(imageId);
    image.archived = true;
    return this.imagesService.save(image);
  }

  @Delete(':imageId/tag/:tagLabel')
  async removeTag(
    @Param('imageId') imageId: number,
    @Param('tagLabel') tagLabel: string,
  ): Promise<Image> {
    const image = await this.imagesService.findById(imageId);
    image.tags = image.tags.filter(tag => tag.label !== tagLabel);
    image.numberOfTags = image.tags.length;
    return this.imagesService.save(image);
  }
}
