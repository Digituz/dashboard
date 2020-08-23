import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Customer } from './customer.entity';
import { Repository, Brackets } from 'typeorm';
import { IPaginationOpts } from '../pagination/pagination';
import { Pagination, paginate } from 'nestjs-typeorm-paginate';

@Injectable()
export class CustomersService {
  constructor(
    @InjectRepository(Customer)
    private customerRepository: Repository<Customer>,
  ) {}

  async paginate(options: IPaginationOpts): Promise<Pagination<Customer>> {
    const queryBuilder = this.customerRepository.createQueryBuilder('c');

    options.queryParams
      .filter(queryParam => {
        return (
          queryParam !== null &&
          queryParam.value !== null &&
          queryParam.value !== undefined
        );
      })
      .forEach(queryParam => {
        switch (queryParam.key) {
          case 'query':
            queryBuilder.andWhere(
              new Brackets(qb => {
                qb.where(`lower(c.name) like lower(:query)`, {
                  query: `%${queryParam.value.toString()}%`,
                }).orWhere(`lower(c.cpf) like lower(:query)`, {
                  query: `%${queryParam.value.toString()}%`,
                });
              }),
            );
            break;
        }
      });

    let sortDirection;
    let sortNulls;
    switch (options.sortDirectionAscending) {
      case undefined:
      case null:
      case true:
        sortDirection = 'ASC';
        sortNulls = 'NULLS FIRST';
        break;
      default:
        sortDirection = 'DESC';
        sortNulls = 'NULLS LAST';
    }

    const orderColumn = 'name';
    queryBuilder.orderBy(orderColumn, sortDirection, sortNulls);

    return paginate<Customer>(queryBuilder, options);
  }

  findById(id: number): Promise<Customer> {
    return this.customerRepository.findOne(id);
  }

  findByCPF(cpf: string): Promise<Customer> {
    return this.customerRepository.findOne({
      cpf,
    });
  }

  async findOrCreate(customer: Customer): Promise<Customer> {
    const existingCustomer = await this.findByCPF(
      customer.cpf.replace(/\D/g, ''),
    );
    if (existingCustomer) return Promise.resolve(existingCustomer);
    return this.save(customer);
  }

  save(customer: Customer): Promise<Customer> {
    customer.cpf = customer.cpf?.replace(/\D/g, '');
    customer.phoneNumber = customer.phoneNumber?.replace(/\D/g, '');
    customer.zipAddress = customer.zipAddress?.replace(/\D/g, '');
    return this.customerRepository.save(customer);
  }

  update(id: number, customer: Customer): Promise<Customer> {
    customer.id = id;
    return this.save(customer);
  }
}
