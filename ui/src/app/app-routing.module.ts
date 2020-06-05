import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

const routes: Routes = [
  {
    path: '',
    loadChildren: () => import('./sign-in/sign-in.module').then((m) => m.SignInModule),
  },
  {
    path: 'home',
    loadChildren: () => import('./home/home.module').then((m) => m.HomeModule),
  },
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
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
  providers: [],
})
export class AppRoutingModule {}
