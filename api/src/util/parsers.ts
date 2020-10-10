export function parseBoolean(value: string): boolean {
  if (value === undefined) return undefined;
  if (value === 'true') return true;
  return false;
}

export function parseWeekDay(value: number): string {
  switch (value) {
    case 1:
      return 'Segunda';
    case 2:
      return 'Terça';
    case 3:
      return 'Quarta';
    case 4:
      return 'Quinta';
    case 5:
      return 'Sexta';
    case 6:
      return 'Sábado';
    case 0:
      return 'Domingo';
    default:
      return 'N/A';
  }
}
