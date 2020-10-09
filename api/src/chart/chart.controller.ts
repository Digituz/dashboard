import { Controller, Get } from '@nestjs/common';
import { ChartService } from './chart.service';

@Controller('chart')
export class ChartController {
  constructor(private chartService: ChartService) {}

  @Get()
  async graphicalData() {
    return this.chartService.graphicalData();
  }
}
