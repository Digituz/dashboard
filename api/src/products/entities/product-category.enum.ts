export enum ProductCategory {
  ACESSORIOS = 'ACESSORIOS',
  ANEIS = 'ANEIS',
  BERLOQUES = 'BERLOQUES',
  BRINCOS = 'BRINCOS',
  CAMISETAS = 'CAMISETAS',
  COLARES = 'COLARES',
  CONJUNTOS = 'CONJUNTOS',
  DECORACAO = 'DECORACAO',
  PULSEIRAS = 'PULSEIRAS',
}

export function categoryDescription(category: ProductCategory) {
  switch (category) {
    case ProductCategory.ACESSORIOS:
      return 'Acessórios';
    case ProductCategory.ANEIS:
      return 'Anéis';
    case ProductCategory.BERLOQUES:
      return 'Berloques';
    case ProductCategory.BRINCOS:
      return 'Brincos';
    case ProductCategory.CAMISETAS:
      return 'Camisetas';
    case ProductCategory.COLARES:
      return 'Colares';
    case ProductCategory.CONJUNTOS:
      return 'Conjuntos';
    case ProductCategory.DECORACAO:
      return 'Decoração';
    case ProductCategory.PULSEIRAS:
      return 'Pulseiras';
  }
}
