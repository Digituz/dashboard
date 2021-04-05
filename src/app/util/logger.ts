import { datadogLogs } from '@datadog/browser-logs';
import { environment } from '@env/environment';

const service: string = environment.production ? 'digituz-dashboard' : 'dev-digituz-dashboard';
export function initDatadog() {
  datadogLogs.init({
    clientToken: 'pubdfc33f5c9e874bae86f64b987a10394e',
    site: 'datadoghq.com',
    service,
    forwardErrorsToLogs: true,
    sampleRate: 100,
  });
}

export function log(message: string, attributes?: Object) {
  datadogLogs.logger.log(message, { error: attributes });
}

export function logInfo(message: string, attributes?: Object) {
  datadogLogs.logger.info(message, { error: attributes });
}

export function logError(message: string, attributes?: Object) {
  datadogLogs.logger.error(message, { error: attributes });
}
export function logWarn(message: string, attributes?: Object) {
  datadogLogs.logger.warn(message, { error: attributes });
}
