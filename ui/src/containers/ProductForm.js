import React from "react";
import { Button, Card, Col, Divider, Input, Row, Switch } from "antd";

import InputLabel from "../components/InputLabel";

function ProductForm() {
  return (
    <Card title="Novo Produto">
      <p>Insira os dados do seu novo produto no formulário abaixo.</p>
      <Divider />
      <Row gutter={[16, 16]}>
        <Col xs={24}>
          <Row gutter={[16, 16]}>
            <Col xs={24} sm={3}>
              <InputLabel for="sku">SKU:</InputLabel>
            </Col>
            <Col xs={24} sm={9}>
              <Input id="sku" placeholder="SKU do produto" />
            </Col>
            <Col xs={24} sm={3}>
              <InputLabel for="isActive">Ativo:</InputLabel>
            </Col>
            <Col xs={24} sm={9}>
              <Switch id="isActive" />
            </Col>
          </Row>
        </Col>
        <Col xs={24}>
          <Row gutter={[16, 16]}>
            <Col xs={24} sm={3}>
              <InputLabel for="title">Título:</InputLabel>
            </Col>
            <Col xs={24} sm={9}>
              <Input id="title" placeholder="Título do produto" />
            </Col>
            <Col xs={24} sm={3}>
              <InputLabel for="sellingPrice">Preço de venda:</InputLabel>
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
          <InputLabel for="description">Descrição:</InputLabel>
        </Col>
        <Col xs={24} sm={21}>
          <Input id="description" placeholder="Descrição do produto" />
        </Col>
        <Col span={24}>
          <Button>Salvar</Button>
        </Col>
      </Row>
    </Card>
  );
}

export default ProductForm;
