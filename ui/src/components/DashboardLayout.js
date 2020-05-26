import React from "react";
import { Layout, Menu, Breadcrumb } from "antd";
import {
  AppstoreAddOutlined,
  GiftOutlined,
  PictureOutlined,
} from "@ant-design/icons";
import styled from "styled-components";

const { Header, Sider } = Layout;

const Logo = styled.div`
  width: 100px;
  float: left;
  color: #fff;
  font-weight: 700;
  opacity: 0.8;
  font-size: 20px;
`;

const ContentLayout = styled(Layout)`
  padding: 0 24px 24px;
`;

const VerticalMenu = styled(Menu)`
  height: 100%;
`;

function DashboardLayout(props) {
  return (
    <Layout>
      <Header className="header">
        <Logo>Digituz</Logo>
        <Menu theme="dark" mode="horizontal">
          <Menu.Item key="1">Sair</Menu.Item>
        </Menu>
      </Header>
      <Layout>
        <Sider width={200} className="site-layout-background">
          <VerticalMenu mode="inline">
            <Menu.Item key="produtos" icon={<GiftOutlined />}>
              Produtos
            </Menu.Item>
            <Menu.Item key="estoque" icon={<AppstoreAddOutlined />}>
              Estoque
            </Menu.Item>
            <Menu.Item key="imagens" icon={<PictureOutlined />}>
              Imagens
            </Menu.Item>
          </VerticalMenu>
        </Sider>
        <ContentLayout>
          <Breadcrumb style={{ margin: "16px 0" }}>
            <Breadcrumb.Item>Início</Breadcrumb.Item>
            <Breadcrumb.Item>Produtos</Breadcrumb.Item>
            <Breadcrumb.Item>Novo</Breadcrumb.Item>
          </Breadcrumb>
          {props.children}
        </ContentLayout>
      </Layout>
    </Layout>
  );
}

export default DashboardLayout;
