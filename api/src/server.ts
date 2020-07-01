import { ValidationPipe, LogLevel } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { config } from 'dotenv';

// making sure we load env vars before any custom code
config();

import { AppModule } from './app.module';

export async function bootstrap(silentMode = false) {
  const logger: LogLevel[] = ['error', 'warn'];
  if (!silentMode) {
    logger.push('log');
    process.env.LOG_SQL_QUERIES = 'true';
  }

  const app = await NestFactory.create(AppModule, { logger });
  app.useGlobalPipes(new ValidationPipe({ transform: true }));
  app.setGlobalPrefix('v1');
  await app.listen(3000);
  return app;
}
