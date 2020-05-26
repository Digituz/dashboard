import React from "react";
import { Table } from "antd";
import { Link, Route, useRouteMatch } from "react-router-dom";
import ProductForm from "./ProductForm";

const dataSource = [
  {
    key: "1",
    name: "Mike",
    age: 32,
    address: "10 Downing Street",
  },
  {
    key: "2",
    name: "John",
    age: 42,
    address: "10 Downing Street",
  },
];

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
  return (
    <>
      <Route exact path={path}>
        <h1>Lista de Produtos</h1>
        <Table dataSource={dataSource} columns={columns} />
        <Link to="/produtos/novo">Novo Produto</Link>
      </Route>
      <Route path={`${path}/:novo`}>
        <ProductForm />
      </Route>
    </>
  );
}

export default ProductList;
