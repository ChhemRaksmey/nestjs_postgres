import { Controller, Get, Post, Param, Body, Query, Res, Req } from '@nestjs/common';
import type { Response, Request } from 'express';
import { renderView } from '../../../utils/view.util';

@Controller('aml/maintenance/risk/level')
export class ControllerAMLMaintenanceRiskLevel {
  
  @Get()
  async list(@Query('search') search: string, @Res() res: Response, @Req() req: Request) {
    if (!(req.session as any)?.user) return res.redirect('/login');

    return renderView(res, 'anti-money-laundering/maintenance/risk-level/index', { 
      user: (req.session as any).user, 
      search: search || '', 
    });
  }

  @Get('edit/:id')
  async renderEdit(@Param('id') id: string, @Res() res: Response, @Req() req: Request) {    
    try {
      if (!(req.session as any)?.user) return res.redirect('/login');

      return renderView(res, 'anti-money-laundering/risk-level/edit', { 
        user: (req.session as any).user, 
        error: null,
      });
    } catch (err: any) {
      return res.redirect('/aml/maintenance/risk/level');
    }
  }

  @Post('edit/:id')
  async update(@Param('id') id: string, @Body() body: any, @Res() res: Response, @Req() req: Request) {
    try {
      if (!(req.session as any)?.user) return res.redirect('/login');

      return res.redirect('/aml/maintenance/risk/level');
    } catch (err: any) {

      return renderView(res, 'anti-money-laundering/risk-level/edit', { 
        user: (req.session as any).user, 
        error: err.message,
      });
    }
  }

  @Get('view/:id')
  async renderView(@Param('id') id: string, @Res() res: Response, @Req() req: Request) {
    try {
      if (!(req.session as any)?.user) return res.redirect('/login');

      return renderView(res, 'anti-money-laundering/risk-level/view', { 
        user: (req.session as any).user, 
        error: null,
      });
    } catch (err: any) {
      return res.redirect('/aml/maintenance/risk/level');
    }
  }
  
}