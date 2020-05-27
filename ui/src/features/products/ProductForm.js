import React, { useState, useEffect } from "react";
import {
  Button,
  Card,
  Col,
  Divider,
  Input,
  InputNumber,
  Row,
  Space,
  Switch,
} from "antd";
import { Link } from "react-router-dom";
import { useDispatch, useSelector } from "react-redux";

import InputLabel from "../../components/InputLabel";
import useInput from "../../hooks/useInput";
import { createNewProduct, loadProduct } from "./productsSlice";

function ProductForm(props) {
  const selectedProduct = useSelector(
    (state) => state.productsSlice.selectedProduct
  );
  const loading = useSelector((state) => state.productsSlice.loading);

  console.log("re-render");

  const dispatch = useDispatch();
  const { value: sku, bind: bindSku, setValue: setSku } = useInput("");
  const { value: title, bind: bindTitle, setValue: setTitle } = useInput("");
  const { value: description, bind: bindDescription, setValue: setDescription } = useInput("");
  const [sellingPrice, setSellingPrice] = useState(null);
  const [isActive, setIsActive] = useState(false);
  const [selectedProductUsed, setSelectedProductUsed] = useState(false);

  if (selectedProduct && !selectedProductUsed) {
    setSelectedProductUsed(true);
    setSku(selectedProduct.sku);
    setTitle(selectedProduct.title);
    setDescription(selectedProduct.description);
    setSellingPrice(selectedProduct.sellingPrice);
    setIsActive(selectedProduct.isActive);
  }

  useEffect(() => {
    const { productSku } = props.match.params;
    if (productSku) dispatch(loadProduct(productSku));
  }, [dispatch, props]);

  if (loading) return <h1>Loading</h1>;

  const saveProduct = async () => {
    try {
      await dispatch(
        createNewProduct({
          sku,
          title,
          description,
          sellingPrice,
          isActive,
        })
      );
      console.log("creating new product2;");
    } catch (err) {
      console.error(err);
    }
  };

  return (
    <Card title="Novo Produto">
      <p>Insira os dados do seu novo produto no formulário abaixo.</p>
      <Divider />
      <Row gutter={[16, 16]}>
        <Col xs={24}>
          <Row gutter={[16, 16]}>
            <Col xs={24} sm={3}>
              <InputLabel htmlFor="sku">SKU:</InputLabel>
            </Col>
            <Col xs={24} sm={9}>
              <Input id="sku" placeholder="SKU do produto" {...bindSku} />
            </Col>
            <Col xs={24} sm={3}>
              <InputLabel htmlFor="isActive">Ativo:</InputLabel>
            </Col>
            <Col xs={24} sm={9}>
              <Switch id="isActive" onChange={setIsActive} />
            </Col>
          </Row>
        </Col>
        <Col xs={24}>
          <Row gutter={[16, 16]}>
            <Col xs={24} sm={3}>
              <InputLabel htmlFor="title">Título:</InputLabel>
            </Col>
            <Col xs={24} sm={9}>
              <Input
                id="title"
                placeholder="Título do produto"
                {...bindTitle}
              />
            </Col>
            <Col xs={24} sm={3}>
              <InputLabel htmlFor="sellingPrice">Preço de venda:</InputLabel>
            </Col>
            <Col xs={24} sm={9}>
              <InputNumber
                id="sellingPrice"
                placeholder="Preço de venda do produto"
                decimalSeparator=","
                onChange={setSellingPrice}
              />
            </Col>
          </Row>
        </Col>
        <Col xs={24} sm={3}>
          <InputLabel htmlFor="description">Descrição:</InputLabel>
        </Col>
        <Col xs={24} sm={21}>
          <Input
            id="description"
            placeholder="Descrição do produto"
            {...bindDescription}
          />
        </Col>
        <Col span={24}>
          <Space>
            <Button type="primary" onClick={saveProduct}>
              Salvar
            </Button>
            <Link to={"/produtos"}>
              <Button>Voltar</Button>
            </Link>
          </Space>
        </Col>
      </Row>
    </Card>
  );
}

export default ProductForm;
