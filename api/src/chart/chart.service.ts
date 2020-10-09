import { Injectable } from '@nestjs/common';
import { PaymentType } from '../sales-order/entities/payment-type.enum';
import { SalesOrderService } from '../sales-order/sales-order.service';
import moment from 'moment';
import { parserWeekDay } from '../util/parsers';
@Injectable()
export class ChartService {
  constructor(private salesOrderService: SalesOrderService) {}

  async graphicalData() {
    const sales = await this.salesOrderService.getSalesForWeek();

    const weekDay = this.dayOfWeek();

    const bankSlipData = this.quantitySales(sales, PaymentType.BANK_SLIP);
    const CreditCardData = this.quantitySales(sales, PaymentType.CREDIT_CARD);

    const data = {
      labels: weekDay.map((day) => day.dayOfWeek),
      datasets: [
        {
          label: 'Boleto',
          backgroundColor: '#42A5F5',
          borderColor: '#1E88E5',
          data: bankSlipData,
        },
        {
          label: 'Cartão de Crédito',
          backgroundColor: '#9CCC65',
          borderColor: '#7CB342',
          data: CreditCardData,
        },
      ],
    };
    return data;
  }

  dayOfWeek() {
    let currentDay = new Date();
    const lastSevenDays: { date: String; dayOfWeek: string }[] = [];
    while (lastSevenDays.length < 7) {
      currentDay.setDate(currentDay.getDate() - 1);
      lastSevenDays.push({
        date: currentDay.toLocaleDateString(),
        dayOfWeek: parserWeekDay(currentDay.getDay()),
      });
    }
    return lastSevenDays.reverse();
  }

  quantitySales(sales, paymentType) {
    const weekDay = this.dayOfWeek();
    const salesQuantity: number[] = [];
    for (let i = 0; i < 7; i++) {
      const total = sales
        .filter((sale) => sale.paymentDetails.paymentType === paymentType)
        .filter((sale) => {
          const date = moment(sale.approvalDate).format('DD/MM/YYYY');
          return date === weekDay[i].date;
        })
        .reduce((total, saleOrder) => total + 1, 0);
      salesQuantity.push(total);
    }
    return salesQuantity;
  }
}
