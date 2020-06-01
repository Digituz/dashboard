// {
//     fieldname: 'file',
//     originalname: 'logo-320.jpg',
//     encoding: '7bit',
//     mimetype: 'image/jpeg',
//     destination: '/tmp/uploaded-files',
//     filename: '6a54f1865a75a1fe70b69696073a6d78',
//     path: '/tmp/uploaded-files/6a54f1865a75a1fe70b69696073a6d78',
//     size: 20343
// }

import { Entity } from 'typeorm';

@Entity()
export class Product {
  fileName: string;
  originalName: string;
  mimetype: string;
  pathOnDisk: string;
  pathOnCloud: string;
  size: number;
  thumbnailCreated: boolean;
  smallCreated: boolean;
  mediumCreated: boolean;
  largeCreated: boolean;
}
