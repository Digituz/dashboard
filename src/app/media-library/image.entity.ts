import Tag from '@app/tags/tag.entity';

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

  tags: Tag[];
  numberOfTags: number = 0;
  archived: boolean = false;

  fileSize?: number;
  width?: number;
  height?: number;
  aspectRatio?: number;

  // transient
  selected?: boolean;
}
