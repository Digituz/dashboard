const got = require("got");
const _ = require("lodash");
const orders = require("./in-process-sales-orders.json");
const getToken = require("./util/auth");

(async () => {
  const token = await getToken();

  const digituzCustomers = _.uniqBy(
    orders
      .map((order) => order.pedido)
      .map((order) => {
        return {
          cpf: order.cliente.cnpj,
          name: order.cliente.nome,
          phoneNumber: order.cliente.fone,
          email: order.cliente.email,
          zipAddress: order.cliente.cep,
          state: order.cliente.uf,
          city: order.cliente.cidade,
          neighborhood: order.cliente.bairro,
          streetAddress: order.cliente.endereco,
          streetNumber: order.cliente.numero,
          streetNumber2: order.cliente.complemento || null,
        };
      }),
    "cpf"
  );

  await Promise.all(
    digituzCustomers.map((customer, idx) => {
      return new Promise((res) => {
        setTimeout(async () => {
          await got.post("http://localhost:3005/v1/customers", {
            json: customer,
            headers: {
              authorization: `Bearer ${token}`,
            },
            responseType: "json",
          });
          res();
        }, idx * 300);
      });
    })
  );

  console.log("Customers persisted successfully");

  const movements = orders
    .map((order) => order.pedido)
    .flatMap((pedido) => pedido.itens)
    .map((blingItem) => blingItem.item)
    .map((item) => ({
      sku: item.codigo,
      amount: parseInt(item.quantidade),
      description: "Sincronização (migração) de pedidos em digitação.",
    }));

  await Promise.all(
    movements.map((movement, idx) => {
      return new Promise((res) => {
        setTimeout(async () => {
          await got.post("http://localhost:3005/v1/inventory/movement", {
            json: movement,
            headers: {
              authorization: `Bearer ${token}`,
            },
            responseType: "json",
          });
          res();
        }, idx * 300);
      });
    })
  );

  console.log("Movements persisted successfully");

  const digituzSalesOrders = orders
    .map((order) => order.pedido)
    .map((pedido) => {
      return {
        referenceCode: pedido.numero,
        customer: digituzCustomers.find((dc) => dc.cpf === pedido.cliente.cnpj),
        items: pedido.itens.map((blingItem) => ({
          sku: blingItem.item.codigo,
          price: parseFloat(blingItem.item.valorunidade),
          discount: 0,
          amount: parseInt(blingItem.item.quantidade),
        })),
        discount: 0,
        paymentType: "BANK_SLIP",
        paymentStatus: "IN_PROCESS",
        installments: 1,
        shippingType: pedido.transporte.transportadora.replace(
          "Correios - ",
          ""
        ),
        shippingPrice: parseFloat(pedido.valorfrete),
        customerName: pedido.transporte.enderecoEntrega.nome,
        shippingStreetAddress: pedido.transporte.enderecoEntrega.endereco,
        shippingStreetNumber: pedido.transporte.enderecoEntrega.numero,
        shippingStreetNumber2: pedido.transporte.enderecoEntrega.complemento,
        shippingNeighborhood: pedido.transporte.enderecoEntrega.bairro,
        shippingCity: pedido.transporte.enderecoEntrega.cidade,
        shippingState: pedido.transporte.enderecoEntrega.uf,
        shippingZipAddress: pedido.transporte.enderecoEntrega.cep,
        creationDate: "2020-08-24T03:30:50.846Z",
        blingStatus: "EM_DIGITACAO",
      };
    });

  await Promise.all(
    digituzSalesOrders.map((salesOrder, idx) => {
      return new Promise((res) => {
        setTimeout(async () => {
          await got.post("http://localhost:3005/v1/sales-order", {
            json: salesOrder,
            headers: {
              authorization: `Bearer ${token}`,
            },
            responseType: "json",
          });
          res();
        }, idx * 300);
      });
    })
  );

  console.log("Sales orders persisted successfully");
})();
