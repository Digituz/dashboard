import React from "react";
import { BrowserRouter, Route } from "react-router-dom";
import { Provider } from "react-redux";

import store from "./store";
import DashboardLayout from "./components/DashboardLayout";
import ProductList from "./features/products/ProductList";

const App = () => (
  <BrowserRouter>
    <Provider store={store}>
      <DashboardLayout>
        <Route path="/produtos" component={ProductList} />
      </DashboardLayout>
    </Provider>
  </BrowserRouter>
);

export default App;
