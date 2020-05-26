import React from "react";
import { BrowserRouter, Route } from "react-router-dom";

import DashboardLayout from "./components/DashboardLayout";
import ProductList from "./products/components/ProductList";

const App = () => (
  <BrowserRouter>
    <DashboardLayout>
      <Route path="/produtos" component={ProductList} />
    </DashboardLayout>
  </BrowserRouter>
);

export default App;
