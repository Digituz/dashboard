export function isNullOrUndefined<T>(obj: T | null | undefined): obj is null | undefined {
  return typeof obj === 'undefined' || obj === null;
}

export function createAndDownloadBlobFile(body: any, options: any, filename: any) {
  const blob = new Blob([body], options);

  const link = document.createElement('a');

  const url = URL.createObjectURL(blob);
  link.setAttribute('href', url);
  link.setAttribute('download', filename);
  link.style.visibility = 'hidden';
  document.body.appendChild(link);
  link.click();
  document.body.removeChild(link);
}
