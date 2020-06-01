import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

const routes: Routes = [
  {
    path: 'products',
    loadChildren: () => import('./products/products.module').then((m) => m.ProductsModule),
  },
  {
    path: 'media-library',
    loadChildren: () => import('./media-library/media-library.module').then((m) => m.MediaLibraryModule),
  },
  {
    path: 'inventory',
    loadChildren: () => import('./inventory/inventory.module').then((m) => m.InventoryModule),
  },
  // Fallback when no prior route is matched
  {
    path: '**',
    redirectTo: '',
    pathMatch: 'full',
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
  providers: [],
})
export class AppRoutingModule {}
