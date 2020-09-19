const got = require("got");
const _ = require("lodash");
const orders = require("./in-process-sales-orders.json");
const getToken = require("./util/auth");

// TODO
// TODO
// TODO - [ ] Sales orders with composite products are failiing because we try to increase their inventory
// TODO - [ ] We have to properly set 
// TODO
// TODO

const BLING_APIKEY =
  "50c467c88f5cb2b8021c7f8818a8d4b22df7a80dc29fbe1f533b0ce6c2e1cfaa7581fbc8";

async function getApprovedSales() {
  const url = `https://bling.com.br/Api/v2/pedidos/json/?apikey=${BLING_APIKEY}&imagem=S&filters=dataEmissao[01/03/2020 TO 31/03/2020];idSituacao[9]`;
  const response = await got(url);
  const blingResponse = JSON.parse(response.body);
  return blingResponse.retorno.pedidos;
}

(async () => {
  const token = await getToken();
  const approvedSalesOrders = await getApprovedSales();
  const test = false;

  let salesOrders = approvedSalesOrders
    .map((order) => order.pedido)
    .filter((order) => order.cliente.cnpj.length <= 14);

  const digituzCustomers = _.uniqBy(
    salesOrders
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
      if (test) return Promise.resolve();
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

  const movements = salesOrders
    .flatMap((pedido) => pedido.itens)
    .map((blingItem) => blingItem.item)
    .map((item) => ({
      sku: item.codigo,
      amount: parseInt(item.quantidade),
      description: "Sincronização (migração) de pedidos em digitação.",
    }));

  await Promise.all(
    movements.map((movement, idx) => {
      if (test) return Promise.resolve();
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

  const digituzSalesOrders = salesOrders
    .map((pedido) => {
      let shippingType;
      if (!pedido.transporte) {
        shippingType = "PAC";
      } else if (pedido.transporte.servico_correios) {
        shippingType = pedido.transporte.servico_correios.split(" ")[0];
      } else if (pedido.transporte.transportadora) {
        shippingType = pedido.transporte.transportadora.replace(
          "Correios - ",
          ""
        );
      }

      if (shippingType === "MOTOBOY") {
        shippingType = "SAME_DAY";
      }

      if (!shippingType) {
        throw new Error(`No shipping type found for ${pedido.transporte}`);
      }

      const enderecoEntrega =
        pedido.transporte?.enderecoEntrega || pedido.cliente;

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
        paymentStatus: "APPROVED",
        installments: 1,
        shippingType: shippingType,
        shippingPrice: parseFloat(pedido.valorfrete),
        customerName: enderecoEntrega.nome,
        shippingStreetAddress: enderecoEntrega.endereco,
        shippingStreetNumber: enderecoEntrega.numero,
        shippingStreetNumber2: enderecoEntrega.complemento,
        shippingNeighborhood: enderecoEntrega.bairro,
        shippingCity: enderecoEntrega.cidade,
        shippingState: enderecoEntrega.uf,
        shippingZipAddress: enderecoEntrega.cep,
        creationDate: `${pedido.data}T05:00:00.000Z`,
        approvalDate: `${pedido.data}T05:00:00.000Z`,
        blingStatus: "ATENDIDO",
      };
    });

  await Promise.all(
    digituzSalesOrders.map((salesOrder, idx) => {
      if (test) return Promise.resolve();
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
