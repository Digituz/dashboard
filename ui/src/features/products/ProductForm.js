import React from "react";
import { Button, Card, Col, Divider, Input, Row, Space, Switch } from "antd";
import { Link } from "react-router-dom";

import InputLabel from "../../components/InputLabel";

function ProductForm() {
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
              <Input id="sku" placeholder="SKU do produto" />
            </Col>
            <Col xs={24} sm={3}>
              <InputLabel htmlFor="isActive">Ativo:</InputLabel>
            </Col>
            <Col xs={24} sm={9}>
              <Switch id="isActive" />
            </Col>
          </Row>
        </Col>
        <Col xs={24}>
          <Row gutter={[16, 16]}>
            <Col xs={24} sm={3}>
              <InputLabel htmlFor="title">Título:</InputLabel>
            </Col>
            <Col xs={24} sm={9}>
              <Input id="title" placeholder="Título do produto" />
            </Col>
            <Col xs={24} sm={3}>
              <InputLabel htmlFor="sellingPrice">Preço de venda:</InputLabel>
            </Col>
            <Col xs={24} sm={9}>
              <Input
                id="sellingPrice"
                placeholder="Preço de venda do produto"
              />
            </Col>
          </Row>
        </Col>
        <Col xs={24} sm={3}>
          <InputLabel htmlFor="description">Descrição:</InputLabel>
        </Col>
        <Col xs={24} sm={21}>
          <Input id="description" placeholder="Descrição do produto" />
        </Col>
        <Col span={24}>
          <Space>
            <Button type="primary">Salvar</Button>
            <Link to={"/produtos"}><Button>Voltar</Button></Link>
          </Space>
        </Col>
      </Row>
    </Card>
  );
}

export default ProductForm;
