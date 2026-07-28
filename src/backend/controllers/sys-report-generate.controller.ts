import { Controller, Get, Post, Param, Body, Query, Res, Req } from '@nestjs/common';
import type { Response, Request } from 'express';
import { AppModuleService } from '../services/app-module.service';
import { renderView } from '../utils/view.util';

@Controller('sys/reports')
export class ControllerReportGenerate {
  constructor(private readonly moduleService: AppModuleService) {}

  @Get()
  async list(@Query('search') search: string, @Res() res: Response, @Req() req: Request) {
    if (!(req.session as any)?.user) return res.redirect('/login');
    const modules = await this.moduleService.findAll(search);
    return renderView(res, 'report-gerneate/index', { 
      user: (req.session as any).user, 
      modules, 
      search: search || '', 
      title: 'App Modules' 
    });
  }

}