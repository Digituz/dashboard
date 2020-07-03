export function parseBoolean(value: string): boolean {
  if (value === undefined) return undefined;
  if (value === 'true') return true;
  return false;
}
