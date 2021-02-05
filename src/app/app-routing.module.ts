import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AuthGuardService } from './auth-guard.service';
import { SignInService } from './sign-in/sign-in.service';

const routes: Routes = [
  {
    path: '',
    pathMatch: 'full',
    loadChildren: () => import('./sign-in/sign-in.module').then((m) => m.SignInModule),
  },
  {
    path: '',
    pathMatch: 'prefix',
    canActivate: [AuthGuardService],
    children: [
      {
        path: 'customers',
        loadChildren: () => import('./customers/customers.module').then((m) => m.CustomersModule),
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
      },
      {
        path: 'sales-orders',
        loadChildren: () => import('./sales-orders/sales-orders.module').then((m) => m.SalesOrdersModule),
      },
      {
        path: 'suppliers',
        loadChildren: () => import('./supplier/supplier.module').then((m) => m.SupplierModule),
      },
      {
        path: 'purchase-orders',
        loadChildren: () => import('./purchase-orders/purchase-orders.module').then((m) => m.PurchaseOrdersModule),
      },
      {
        path: 'users',
        loadChildren: () => import('./users/users.module').then((m) => m.UsersModule),
      },
    ],
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes, { relativeLinkResolution: 'corrected' })],
  exports: [RouterModule],
  providers: [AuthGuardService, SignInService],
})
export class AppRoutingModule {}
