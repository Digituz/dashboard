import {
  Controller,
  Post,
  UseInterceptors,
  UploadedFile,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import execa from 'execa';

const defaultResults = [
  { label: 'thumbnail', width: 90, height: 90, quality: 80 },
  { label: 'small', width: 180, height: 180, quality: 80 },
  { label: 'medium', width: 360, height: 360, quality: 85 },
  { label: 'large', width: 720, height: 720, quality: 85 },
  { label: 'extra-large', width: 1080, height: 1080, quality: 85 },
];

@Controller('media-library')
export class MediaLibraryController {
  private resize(image, result) {
    const indexOfFileExtensionSeparator = image.originalname.lastIndexOf('.');
    const fileNameWithoutExtension = image.originalname.substr(
      0,
      indexOfFileExtensionSeparator,
    );
    const destination = `${process.env.UPLOAD_DESTINATION}/${fileNameWithoutExtension}-${Date.now()}-${result.label}.jpg`;
    return new Promise((res, rej) => {
      execa('convert', [
        image.path,
        '-resize',
        `${result.width}x${result.height}\>`,
        '-quality',
        result.quality,
        destination,
      ])
        .then(res)
        .catch(rej);
    });
  }

  @Post('upload')
  @UseInterceptors(FileInterceptor('file'))
  uploadFile(@UploadedFile() file) {
    const resizeJobs = defaultResults.map(result => {
      return this.resize(file, result);
    });

    // Jimp.read(file.path)
    //   .then(image => {
    //     console.log(image);
    //     const resizeJobs = defaultResults.map(defaultResult => {
    //       this.resizeAndWrite(image, defaultResult);
    //     });
    //     return Promise.all(resizeJobs);
    //   })
    Promise.all(resizeJobs)
      .then(() => {
        console.log('Resize done!');
      })
      .catch(console.error);
  }
}
