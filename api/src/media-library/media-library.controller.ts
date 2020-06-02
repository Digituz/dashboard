import {
  Controller,
  Post,
  UseInterceptors,
  UploadedFile,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import execa from 'execa';
import { Image } from './image.entity';
import { ImagesService } from './images.service';

const defaultResults = [
  { label: 'thumbnail', width: 90, height: 90, quality: 80 },
  { label: 'small', width: 180, height: 180, quality: 80 },
  { label: 'medium', width: 360, height: 360, quality: 85 },
  { label: 'large', width: 720, height: 720, quality: 85 },
  { label: 'extra-large', width: 1080, height: 1080, quality: 85 },
  { label: 'original', width: 4096, height: 4096, quality: 100 },
];

@Controller('media-library')
export class MediaLibraryController {
  constructor(private imagesService: ImagesService) {}

  private resize(image, fileSuffix: string, result) {
    const destination = `${process.env.UPLOAD_DESTINATION}/${fileSuffix}-${result.label}.jpg`;
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
          res(destination);
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

  @Post('upload')
  @UseInterceptors(FileInterceptor('file'))
  async uploadFile(@UploadedFile() file): Promise<void> {
    const now = Date.now();
    const indexOfFileExtensionSeparator = file.originalname.lastIndexOf('.');
    const fileNameWithoutExtension = file.originalname.substr(
      0,
      indexOfFileExtensionSeparator,
    );
    const fileSuffix = `${fileNameWithoutExtension}-${now}`;
    const resizeJobs = defaultResults.map(result => {
      return this.resize(file, fileSuffix, result);
    });

    const filesOnDisk = await Promise.all(resizeJobs);
    const removeJobs = [file.path, ...filesOnDisk].map(this.removeFileFromDisk);
    await Promise.all(removeJobs);

    const image: Image = {
      mainFilename: `${fileSuffix}-original.jpg`,
      originalFilename: file.originalname,
      mimetype: 'image/jpeg',
      originalFileURL: `${process.env.CDN_URL}/${fileSuffix}-original.jpg`,
      extraLargeFileURL: `${process.env.CDN_URL}/${fileSuffix}-extra-large.jpg`,
      largeFileURL: `${process.env.CDN_URL}/${fileSuffix}-large.jpg`,
      mediumFileURL: `${process.env.CDN_URL}/${fileSuffix}-medium.jpg`,
      smallFileURL: `${process.env.CDN_URL}/${fileSuffix}-small.jpg`,
      thumbnailFileURL: `${process.env.CDN_URL}/${fileSuffix}-thumbnail.jpg`,
    };
    await this.imagesService.save(image);
    console.log('resized then removed;');
  }
}
