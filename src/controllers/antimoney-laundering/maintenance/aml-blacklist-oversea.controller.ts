import { Controller, Get, Post, Param, Body, Query, Res, Req } from '@nestjs/common';
import type { Response, Request } from 'express';
import { renderView } from '../../../utils/view.util';
import { ServiceAmlResourceDownloadFiles } from '../../../services/aml_oversea_download_files.service';

@Controller('aml/maintenance/blacklist/oversea')
export class ControllerAMLMaintenanceBlacklistOversea {

  constructor(
    private readonly serviceAmlResourceDownloadFiles: ServiceAmlResourceDownloadFiles
  ) {}
  
  @Get()
  async list(@Query('search') search: string, @Res() res: Response, @Req() req: Request) {
    if (!(req.session as any)?.user) return res.redirect('/login');

    const process_id = "yyyy-day_of_year-hhiiss";

    const modules = await this.serviceAmlResourceDownloadFiles.aml_resource_download(process_id, "AML.OVERSEA.001"); // UN - Consolidated

    return renderView(res, 'anti-money-laundering/maintenance/blacklist-oversea/index', { 
      user: (req.session as any).user, 
      search: search || '', 
    });

  }
  
}