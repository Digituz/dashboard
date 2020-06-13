import { IPaginationOptions } from "nestjs-typeorm-paginate";

export interface IPaginationOpts extends IPaginationOptions {
    sortedBy?: string;
    sortDirectionAscending?: boolean;
  }