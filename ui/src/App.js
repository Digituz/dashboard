import React from "react";
import { BrowserRouter, Route } from "react-router-dom";

import DashboardLayout from "./components/DashboardLayout";
import ProductList from "./products/components/ProductList";

const App = () => (
  <DashboardLayout>
    <BrowserRouter>
      <Route path="/produtos" component={ProductList} />
    </BrowserRouter>
  </DashboardLayout>
);

export default App;
