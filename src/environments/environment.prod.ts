// `.env.ts` is generated by the `npm run env` command
// `npm run env` exposes environment variables as JSON for any usage you might
// want, like displaying the version or getting extra config from your CI bot, etc.
// This is useful for granularity you might need beyond just the environment.
// Note that as usual, any environment variables you expose through it will end up in your
// bundle, and you should not use it for any sensitive information like passwords or keys.
import { env, Environment } from './.env';

export const environment: Environment = {
  production: true,
  hmr: false,
  version: env.npm_package_version,
  serverUrl: 'https://api.digituz.com.br/v1',
  defaultLanguage: 'en-US',
  supportedLanguages: ['en-US', 'fr-FR'],
  devUser: null,
};
