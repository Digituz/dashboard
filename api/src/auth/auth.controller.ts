import { Controller, Request, Post, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';

@Controller()
export class AuthController {
    
  @UseGuards(AuthGuard('local'))
  @Post('sign-in')
  async login(@Request() req) {
    return req.user;
  }
}
