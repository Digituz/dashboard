import { Injectable } from '@nestjs/common';
import { PaymentType } from '../sales-order/entities/payment-type.enum';
import { SalesOrderService } from '../sales-order/sales-order.service';
import moment from 'moment';
import { parserWeekDay } from 'src/util/parsers';
@Injectable()
export class ChartService {
  constructor(private salesOrderService: SalesOrderService) {}

  async graphicalData() {
    const sales = await this.salesOrderService.getSaleForWeek();
    const saleBankSplit = sales
      .filter(
        (sale) => sale.paymentDetails.paymentType === PaymentType.BANK_SLIP,
      )
      .map((sale) => {
        return {
          dateApproval: moment(sale.approvalDate).format('DD/MM/YYYY'),
          paymentType: sale.paymentDetails.paymentType,
        };
      });
    const saleCreditCard = sales
      .filter(
        (sale) => sale.paymentDetails.paymentType === PaymentType.CREDIT_CARD,
      )
      .map((sale) => {
        return {
          dateApproval: moment(sale.approvalDate).format('DD/MM/YYYY'),
          paymentType: sale.paymentDetails.paymentType,
        };
      });

    const daySaleSplit: number[] = [];
    let dayqnt: number = 0;
    let contador = 0;

    saleBankSplit.map((sale) => {
      let saleDay = moment().subtract(contador, 'd').format('DD/MM/YYYY');
      if (saleDay === sale.dateApproval) {
        dayqnt++;
      } else {
        daySaleSplit.push(dayqnt);
        contador++;
        saleDay = moment().subtract(contador, 'd').format('DD/MM/YYYY');
        dayqnt = 0;
        if (saleDay === sale.dateApproval) {
          dayqnt++;
        }
        daySaleSplit.push(dayqnt);
      }
    });

    console.log(saleCreditCard, saleBankSplit, daySaleSplit); //daySaleCreditCard);

    const dateWeek = new Date();
    let day = dateWeek.getDay();
    const semana: number[] = [];
    for (let i = 0; i < 7; i++) {
      if (day > 7) {
        day = 1;
      }
      semana.push(day);
      day += 1;
    }

    /* const daySaleCreditCard: number[] = [];
    dayqnt = 0;
    contador = 0;
    oneValue = 0;
    saleCreditCard.map(sale => {
      let saleDay = moment()
        .subtract(contador, 'd')
        .format('DD/MM/YYYY');
      if (saleDay === sale.dateApproval) {
        dayqnt++;
        daySaleCreditCard.push(dayqnt);
        console.log(daySaleCreditCard,);
      } else {
        daySaleCreditCard.push(dayqnt);
        contador++;
        dayqnt = 0;
        saleDay = moment()
          .subtract(contador, 'd')
          .format('DD/MM/YYYY');
        dayqnt++;
        daySaleCreditCard.push(dayqnt);
        console.log(daySaleCreditCard);
      }
      return{
        date:sale.dateApproval,
        cont:1,
      }
    }); */
    const weekDay = semana.map((dia) => parserWeekDay(dia));
    const data = {
      labels: [
        weekDay[0],
        weekDay[1],
        weekDay[2],
        weekDay[3],
        weekDay[4],
        weekDay[5],
        weekDay[6],
      ],
      datasets: [
        {
          label: 'Boleto',
          backgroundColor: '#42A5F5',
          borderColor: '#1E88E5',
          data: [
            daySaleSplit[0],
            daySaleSplit[1],
            daySaleSplit[2],
            (daySaleSplit[3] = 50),
            daySaleSplit[4],
            daySaleSplit[5],
            daySaleSplit[6],
          ],
        },
        {
          label: 'Cartão de Crédito',
          backgroundColor: '#9CCC65',
          borderColor: '#7CB342',
          data: [0, 1],
        },
      ],
    };
    return data;
  }
}
