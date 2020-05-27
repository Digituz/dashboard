import React, { useEffect } from "react";
import { Table, Button } from "antd";
import { useDispatch, useSelector } from "react-redux";
import { Link, Route, useRouteMatch } from "react-router-dom";
import ProductForm from "./ProductForm";
import { loadProducts } from "./productsSlice";
import ActionCell from "../../components/ActionCell";

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
  {
    title: "",
    key: "action",
    render: (text, record) => (
      <ActionCell>
        <Link to={`/produtos/editar/${record.sku}`}>
          <Button type="secondary">Editar</Button>
        </Link>
      </ActionCell>
    ),
  },
];

function ProductList() {
  let { path } = useRouteMatch();
  const products = useSelector((state) => state.productsSlice.products);
  const dispatch = useDispatch();

  useEffect(() => {
    dispatch(loadProducts())
      .then(() => {
        console.log("Lista de produtos carregada com sucesso.");
      })
      .catch((err) => {
        console.error(err);
      });
  }, [dispatch]);

  return (
    <>
      <Route exact path={path}>
        <h1>Lista de Produtos</h1>
        <Table rowKey="sku" dataSource={products} columns={columns} />
        <Link to="/produtos/novo">Novo Produto</Link>
      </Route>
      <Route path={`${path}/editar/:productSku`} component={ProductForm} />
      <Route path={`${path}/novo`} component={ProductForm} />
    </>
  );
}

export default ProductList;
