import React from "react";
import { Table } from "antd";
import { useDispatch, useSelector } from "react-redux";
import { Link, Route, useRouteMatch } from "react-router-dom";
import ProductForm from "./ProductForm";
import { loadProducts } from "./productsSlice";

const columns = [
  {
    title: "SKU",
    dataIndex: "sku",
    key: "sku",
  },
  {
    title: "Título",
    dataIndex: "title",
    key: "title",
  },
  {
    title: "Preço",
    dataIndex: "sellingPrice",
    key: "sellingPrice",
  },
];

function ProductList() {
  let { path } = useRouteMatch();
  const products = useSelector((state) => state.productsSlice.products);
  const dispatch = useDispatch();

  const loadProductsFromAPI = async () => {
    try {
      await dispatch(loadProducts());
      console.log(`Fetched!`);
    } catch (err) {
      console.log(`Fetch failed!`);
    }
  }

  return (
    <>
      <Route exact path={path}>
        <h1>Lista de Produtos</h1>
        <Table dataSource={products} columns={columns} />
        <Link to="/produtos/novo">Novo Produto</Link>
        <button onClick={loadProductsFromAPI}>load prods</button>
      </Route>
      <Route path={`${path}/:novo`}>
        <ProductForm />
      </Route>
    </>
  );
}

export default ProductList;
