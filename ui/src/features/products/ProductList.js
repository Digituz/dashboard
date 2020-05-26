import React from "react";
import { Table } from "antd";
import { useSelector } from "react-redux";
import { Link, Route, useRouteMatch } from "react-router-dom";
import ProductForm from "./ProductForm";

const columns = [
  {
    title: "Name",
    dataIndex: "name",
    key: "name",
  },
  {
    title: "Age",
    dataIndex: "age",
    key: "age",
  },
  {
    title: "Address",
    dataIndex: "address",
    key: "address",
  },
];

function ProductList() {
  let { path } = useRouteMatch();
  const products = useSelector((state) => state.productsSlice.products);
  return (
    <>
      <Route exact path={path}>
        <h1>Lista de Produtos</h1>
        <Table dataSource={products} columns={columns} />
        <Link to="/produtos/novo">Novo Produto</Link>
      </Route>
      <Route path={`${path}/:novo`}>
        <ProductForm />
      </Route>
    </>
  );
}

export default ProductList;
