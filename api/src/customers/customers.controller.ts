import { Controller, Get, Query, Post, Body, Param } from '@nestjs/common';
import { Pagination } from 'nestjs-typeorm-paginate';
import { Customer } from './customer.entity';
import { parseBoolean } from '../util/parsers';
import { CustomersService } from './customers.service';

@Controller('customers')
export class CustomersController {
  constructor(private customersService: CustomersService) {}

  @Get()
  findAll(
    @Query('page') page: number = 1,
    @Query('limit') limit: number = 10,
    @Query('sortedBy') sortedBy: string,
    @Query('sortDirectionAscending') sortDirectionAscending: string,
    @Query('query') query: string,
  ): Promise<Pagination<Customer>> {
    return this.customersService.paginate({
      page,
      limit,
      sortedBy,
      sortDirectionAscending: parseBoolean(sortDirectionAscending),
      queryParams: [
        {
          key: 'query',
          value: query,
        },
      ],
    });
  }

  @Get(':id')
  findOne(@Param('cpf') cpf: string): Promise<Customer> {
    return this.customersService.findByCPF(cpf);
  }

  @Post('/')
  async save(@Body() customer: Customer): Promise<Customer> {
    return this.customersService.save(customer);
  }
}
