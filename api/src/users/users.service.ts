
import { Injectable } from '@nestjs/common';
import { User } from './user.entity';

@Injectable()
export class UsersService {
  private readonly users: User[];

  constructor() {
    this.users = [
      {
        id: 1,
        email: 'bruno.krebs@fridakahlo.com.br',
        name: 'Bruno Krebs',
        password: '0607Frida',
      },
      {
        id: 2,
        email: 'lena@fridakahlo.com.br',
        name: 'Lena Vettoretti',
        password: '0607Frida',
      },
      {
        id: 3,
        email: 'admin@fridakahlo.com.br',
        name: 'Fabíola Pires',
        password: '0607Frida',
      },
      {
        id: 4,
        email: 'agnes@fridakahlo.com.br',
        name: 'Agnes Romeu',
        password: '0607Frida',
      },
    ];
  }

  async findOne(email: string): Promise<User | undefined> {
    return this.users.find(user => user.email === email);
  }
}
