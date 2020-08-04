import { ValueTransformer } from 'typeorm';

export function isNullOrUndefined<T>(
  obj: T | null | undefined,
): obj is null | undefined {
  return typeof obj === 'undefined' || obj === null;
}

export class NumericTransformer implements ValueTransformer {
  to(data?: number | null): number | null {
    if (data || data === 0) return data;
    return null;
  }

  from(data?: string | null): number | null {
    if (!data || !data.trim()) return null;
    const number = parseFloat(data);
    if (isNaN(number)) return null;
    return number;
  }
}
