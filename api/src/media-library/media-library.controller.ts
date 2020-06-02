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

    // Jimp.read(file.path)
    //   .then(image => {
    //     console.log(image);
    //     const resizeJobs = defaultResults.map(defaultResult => {
    //       this.resizeAndWrite(image, defaultResult);
    //     });
    //     return Promise.all(resizeJobs);
    //   })
    const filesOnDisk = await Promise.all(resizeJobs);
    const removeJobs = [file.path, ...filesOnDisk].map(this.removeFileFromDisk);
    await Promise.all(removeJobs);
    console.log("resized then removed;");
  }
}
