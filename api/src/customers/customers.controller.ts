import {
  Controller,
  Get,
  Query,
  Post,
  Body,
  Param,
  Put,
  UseGuards,
} from '@nestjs/common';
import { Pagination } from 'nestjs-typeorm-paginate';
import { Customer } from './customer.entity';
import { parseBoolean } from '../util/parsers';
import { CustomersService } from './customers.service';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';

@Controller('customers')
@UseGuards(JwtAuthGuard)
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
  findOne(@Param('id') id: number): Promise<Customer> {
    return this.customersService.findById(id);
  }

  @Post('/')
  async save(@Body() customer: Customer): Promise<Customer> {
    return this.customersService.findOrCreate(customer);
  }

  @Put(':id')
  update(
    @Param('id') id: number,
    @Body() customer: Customer,
  ): Promise<Customer> {
    return this.customersService.update(id, customer);
  }
}
