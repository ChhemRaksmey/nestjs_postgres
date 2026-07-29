import { Controller, Get, Post, Param, Body, Query, Res, Req } from '@nestjs/common';
import type { Response, Request } from 'express';
import { renderView } from '../../../utils/view.util';

@Controller('aml/maintenance/risk/level')
export class ControllerAMLMaintenanceRiskLevel {

  constructor() {}

  @Get()
  async list(
    @Query('search') search: string,
    @Query('success') success: string,
    @Res() res: Response,
    @Req() req: Request
  ) {
    if (!(req.session as any)?.user) return res.redirect('/login');

    return renderView(res, 'anti-money-laundering/maintenance/risk-level/index', { 
      user: (req.session as any).user,
      success: success,
      search: search || '',
    });
  }

  @Get('edit/:id')
  async renderEdit(@Param('id') id: string, @Res() res: Response, @Req() req: Request) {
    if (!(req.session as any)?.user) return res.redirect('/login');

    var list_risk_levels;

    list_risk_levels = [
      { risk_level_name: "HIGH",   risk_color: "#e83e8c", max_score: 100.00 },
      { risk_level_name: "MEDUIM", risk_color: "#f1b44c", max_score: 700.00 },
      { risk_level_name: "LOW",    risk_color: "#34c38f", max_score: 40.00 },
    ];

    return renderView(res, 'anti-money-laundering/maintenance/risk-level/edit', { 
      user: (req.session as any).user,
      recid: id,
      list_risk_levels: list_risk_levels
    });
  }

  
@Post('edit/:id')
  async save_edit(
    @Param('id') id: string, 
    @Body() body: any, 
    @Res() res: Response, 
    @Req() req: Request
  ) {
    try {
      if (!(req.session as any)?.user) return res.redirect('/login');

      // TODO: Add your actual database update logic here using `id` and `body`

      // Encode the message to handle spaces and special characters safely
      const success_message = encodeURIComponent('Risk level updated successfully!');

      return res.redirect(`/aml/maintenance/risk/level?success=${success_message}`);
    } catch (err: any) {
      return res.render('anti-money-laundering/maintenance/risk-level/edit', { 
        user: (req.session as any).user,
        error: err.message, 
      });
    }
  }
  
}