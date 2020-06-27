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
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import execa from 'execa';
import { readFile } from 'fs';

import { Image } from './image.entity';
import { ImagesService } from './images.service';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { TagsService } from '../tags/tags.service';

const defaultResults = [
  { label: 'thumbnail', width: 90, height: 90, quality: 80 },
  { label: 'small', width: 180, height: 180, quality: 80 },
  { label: 'medium', width: 360, height: 360, quality: 85 },
  { label: 'large', width: 720, height: 720, quality: 85 },
  { label: 'extra-large', width: 1080, height: 1080, quality: 85 },
  { label: 'original', width: 4096, height: 4096, quality: 100 },
];

const s3 = new S3({
  accessKeyId: process.env.DO_SPACES_ID,
  secretAccessKey: process.env.DO_SPACES_SECRET,
  endpoint: process.env.DO_ENDPOINT,
});

@Controller('media-library')
@UseGuards(JwtAuthGuard)
export class MediaLibraryController {
  constructor(private imagesService: ImagesService, private tagsService: TagsService) {}

  private resize(
    image,
    fileSuffix: string,
    result,
  ): Promise<{ destination: string; filename: string }> {
    const filename = `${fileSuffix}-${result.label}.jpg`;
    const destination = `${process.env.UPLOAD_DESTINATION}/${filename}`;
    return new Promise((res, rej) => {
      execa('convert', [
        image.path,
        '-resize',
        `${result.width}x${result.height}\>`,
        '-quality',
        result.quality,
        destination,
      ])
        .then(() => {
          res({
            destination,
            filename,
          });
        })
        .catch(rej);
    });
  }

  private removeFileFromDisk(file: string) {
    return new Promise((res, rej) => {
      execa('rm', [file])
        .then(res)
        .catch(rej);
    });
  }

  private uploadFileToCDN(filename: string, path: string) {
    return new Promise((res, rej) => {
      readFile(path, (err, data) => {
        if (err) rej(err);
        const params = {
          Bucket: process.env.DO_BUCKET,
          Key: filename,
          Body: data,
          ContentType: 'image/jpeg',
          ACL: 'public-read',
        };

        s3.upload(params, function(err) {
          if (err) return rej(err);
          res();
        });
      });
    });
  }

  @Post('upload')
  @UseInterceptors(FileInterceptor('file'))
  async processFile(@UploadedFile() file): Promise<void> {
    // preparing the file name
    const now = Date.now();
    const indexOfFileExtensionSeparator = file.originalname.lastIndexOf('.');
    const fileNameWithoutExtension = file.originalname.substr(
      0,
      indexOfFileExtensionSeparator,
    );
    const fileSuffix = `${fileNameWithoutExtension}-${now}`;

    // resizing the image into different dimensions
    const resizeJobs = defaultResults.map(result => {
      return this.resize(file, fileSuffix, result);
    });
    const files = await Promise.all(resizeJobs);

    // upload the different versions of this image to the CDN
    const uploadJobs = files.map(file =>
      this.uploadFileToCDN(file.filename, file.destination),
    );
    await Promise.all(uploadJobs);

    // removing from disk, as they have been uploaded to the CDN
    const removeJobs = [file.path, ...files.map(file => file.destination)].map(
      this.removeFileFromDisk,
    );
    await Promise.all(removeJobs);

    // recording everything into the database, for easier reference
    // ps. while uploading, the name of the file suffers a transformation similar to encodeURIComponent, so we use it
    const image: Image = {
      mainFilename: `${encodeURIComponent(fileSuffix)}-original.jpg`,
      originalFilename: file.originalname,
      mimetype: 'image/jpeg',
      originalFileURL: `https://${process.env.DO_BUCKET}/${encodeURIComponent(fileSuffix)}-original.jpg`,
      extraLargeFileURL: `https://${process.env.DO_BUCKET}/${encodeURIComponent(fileSuffix)}-extra-large.jpg`,
      largeFileURL: `https://${process.env.DO_BUCKET}/${encodeURIComponent(fileSuffix)}-large.jpg`,
      mediumFileURL: `https://${process.env.DO_BUCKET}/${encodeURIComponent(fileSuffix)}-medium.jpg`,
      smallFileURL: `https://${process.env.DO_BUCKET}/${encodeURIComponent(fileSuffix)}-small.jpg`,
      thumbnailFileURL: `https://${process.env.DO_BUCKET}/${encodeURIComponent(fileSuffix)}-thumbnail.jpg`,
    };
    await this.imagesService.save(image);
  }

  @Get()
  findAll(): Promise<Image[]> {
    return this.imagesService.findAll();
  }

  @Post(':imageId')
  async save(@Body() tags: string[], @Param('imageId') imageId: number): Promise<Image> {
    const image = await this.imagesService.findById(imageId);
    const newTags = await this.tagsService.findByLabels(tags);
    image.tags = newTags;
    image.numberOfTags = newTags.length;
    return this.imagesService.save(image);
  }
}
