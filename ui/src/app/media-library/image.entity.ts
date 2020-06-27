export class Image {
  id?: number;

  mainFilename: string;
  originalFilename: string;
  mimetype: string;
  originalFileURL: string;
  extraLargeFileURL: string;
  largeFileURL: string;
  mediumFileURL: string;
  smallFileURL: string;
  thumbnailFileURL: string;

  // transient
  selected?: boolean;
}
