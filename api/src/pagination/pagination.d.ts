import { IPaginationOptions } from 'nestjs-typeorm-paginate';

export interface QueryParam {
  key: string;
  value: string | number | boolean;
}

export interface IPaginationOpts extends IPaginationOptions {
  sortedBy?: string;
  sortDirectionAscending?: boolean;
  queryParams?: QueryParam[];
}
