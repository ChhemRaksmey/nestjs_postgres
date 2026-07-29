import { Controller, Get, Post, Param, Body, Query, Res, Req } from '@nestjs/common';
import type { Response, Request } from 'express';
import { renderView } from '../../../utils/view.util';

@Controller('aml/front-office/onboard')
export class ControllerAMLFrontOfficeOnboard {

  @Get()
  async list(@Query('search') search: string, @Res() res: Response, @Req() req: Request) {
    if (!(req.session as any)?.user) return res.redirect('/login');

    return renderView(res, 'anti-money-laundering/front-office/onboard/index', { 
      user: (req.session as any).user, 
      search: search || '', 
    });
  }
  
}