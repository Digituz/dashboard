import { config } from 'dotenv';

// making sure we load env vars before any custom code
config();

import { bootstrap } from './server';

bootstrap();
