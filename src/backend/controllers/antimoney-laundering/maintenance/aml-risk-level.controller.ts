import { Controller, Get, Post, Param, Body, Query, Res, Req } from '@nestjs/common';
import type { Response, Request } from 'express';
import { renderView } from '../../../utils/view.util';

import { HttpService } from '../../../utils/http.service.util';

@Controller('aml/maintenance/risk/level')
export class ControllerAMLMaintenanceRiskLevel {

  constructor(private readonly httpService: HttpService) {}
  
  @Get()
  async list(@Query('search') search: string, @Res() res: Response, @Req() req: Request) {
    if (!(req.session as any)?.user) return res.redirect('/login');

    const url = 'http://localhost:3000/data_sample_aml/un_consolidated.xml';
    
    const data = await this.httpService.get<string>(url, {
      maxBodyLength: Infinity,
    });

    console.log(data);

    return renderView(res, 'anti-money-laundering/maintenance/risk-level/index', { 
      user: (req.session as any).user, 
      search: search || '', 
    });
  }
  
}