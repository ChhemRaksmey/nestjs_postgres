import { Controller, Get, Post, Param, Body, Query, Res, Req } from '@nestjs/common';
import type { Response, Request } from 'express';
import { AppModuleService } from '../services/app-module.service';
import { renderView } from '../utils/view.util';

@Controller('sys/user')
export class ControllerSysUser {
  
  constructor(private readonly moduleService: AppModuleService) {}

  @Get()
  async list(@Query('search') search: string, @Res() res: Response, @Req() req: Request) {
    if (!(req.session as any)?.user) return res.redirect('/login');
    const modules = await this.moduleService.findAll(search);
    return renderView(res, 'sys-user/index', { 
      user: (req.session as any).user, 
      modules, 
      search: search || '', 
      title: 'App Modules' 
    });
  }

  @Get('create')
  async renderCreate(@Res() res: Response, @Req() req: Request) {
    if (!(req.session as any)?.user) return res.redirect('/login');
    return renderView(res, 'sys-user/create', { 
      user: (req.session as any).user, 
      error: null, 
      title: 'Create App Module' 
    });
  }

  @Post('create')
  async create(@Body() body: any, @Res() res: Response, @Req() req: Request) {
    if (!(req.session as any)?.user) return res.redirect('/login');
    try {
      await this.moduleService.create(body);
      return res.redirect('/app-modules');
    } catch (err: any) {
      return renderView(res, 'sys-user/create', { 
        user: (req.session as any).user, 
        error: err.message, 
        title: 'Create App Module' 
      });
    }
  }

  @Get('edit/:id')
  async renderEdit(@Param('id') id: string, @Res() res: Response, @Req() req: Request) {
    if (!(req.session as any)?.user) return res.redirect('/login');
    try {
      const module = await this.moduleService.findOne(id);
      return renderView(res, 'sys-user/edit', { 
        user: (req.session as any).user, 
        module, 
        error: null, 
        title: 'Edit App Module' 
      });
    } catch (err: any) {
      return res.redirect('/app-modules');
    }
  }

  @Post('edit/:id')
  async update(@Param('id') id: string, @Body() body: any, @Res() res: Response, @Req() req: Request) {
    if (!(req.session as any)?.user) return res.redirect('/login');
    try {
      await this.moduleService.update(id, body);
      return res.redirect('/app-modules');
    } catch (err: any) {
      const module = await this.moduleService.findOne(id);
      return renderView(res, 'sys-user/edit', { 
        user: (req.session as any).user, 
        module, 
        error: err.message, 
        title: 'Edit App Module' 
      });
    }
  }

  

  @Get('view/:id')
  async renderView(@Param('id') id: string, @Res() res: Response, @Req() req: Request) {
    if (!(req.session as any)?.user) return res.redirect('/login');
    try {
      const module = await this.moduleService.findOne(id);
      return renderView(res, 'sys-user/view', { 
        user: (req.session as any).user, 
        module, 
        error: null, 
        title: 'Edit App Module' 
      });
    } catch (err: any) {
      return res.redirect('/app-modules');
    }
  }

  @Get('delete/:id')
  async delete(@Param('id') id: string, @Res() res: Response, @Req() req: Request) {
    if (!(req.session as any)?.user) return res.redirect('/login');
    try {
      await this.moduleService.delete(id);
    } catch (err) {}
    return res.redirect('/app-modules');
  }
}