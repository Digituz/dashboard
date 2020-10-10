import { Injectable } from '@nestjs/common';
import moment, { Moment } from 'moment';

import { PaymentType } from '../sales-order/entities/payment-type.enum';
import { SalesOrderService } from '../sales-order/sales-order.service';
import { parseWeekDay } from '../util/parsers';

@Injectable()
export class ChartService {
  constructor(private salesOrderService: SalesOrderService) {}

  async graphicalData() {
    const sales = await this.salesOrderService.getSalesForLast7Days();

    const weekDay = this.getLast7Days();

    const bankSlipData = this.quantitySales(sales, PaymentType.BANK_SLIP);
    const creditCardData = this.quantitySales(sales, PaymentType.CREDIT_CARD);

    const data = {
      labels: weekDay.map(day => day.dayOfWeek),
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
          data: creditCardData,
        },
      ],
    };
    return data;
  }

  getLast7Days() {
    // we add one day here because the while loop subtract one
    // i.e., if we didn't do that, we would ignore "today"
    const currentDay = moment().add(1, 'days');
    const lastSevenDays: { date: Moment; dayOfWeek: string }[] = [];
    while (lastSevenDays.length < 7) {
      lastSevenDays.push({
        date: moment(currentDay.subtract(1, 'days')).startOf('day'),
        dayOfWeek: parseWeekDay(currentDay.weekday()),
      });
    }
    return lastSevenDays.reverse();
  }

  private quantitySales(sales, paymentType) {
    const last7Days = this.getLast7Days();
    return last7Days
      .map(day => day.date)
      .map(date => {
        return sales
          .filter(sale => sale.paymentDetails.paymentType === paymentType)
          .filter(sale => {
            return moment(sale.approvalDate)
              .startOf('day')
              .isSame(date);
          })
          .reduce((total, sale) => (total += sale.paymentDetails.total), 0);
      });
  }
}
