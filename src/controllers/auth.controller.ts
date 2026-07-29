import { Controller, Get, Post, Body, Res, Req } from '@nestjs/common';
import type { Response, Request } from 'express';
import { AuthService } from '../services/auth.service';
import { renderView } from '../utils/view.util';

@Controller()
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Get('login')
  renderLogin(@Res() res: Response) {
    return res.render('auth/login', { error: null });
  }

  @Post('login')
  async handleLogin(@Body() body: any, @Res() res: Response, @Req() req: Request) {
    try {
      const user = await this.authService.authenticate({
        signon_name: body.signon_name,
        password: body.password,
      });
      
      (req.session as any).user = user;
      return res.redirect('/dashboard');
    } catch (err: any) {
      return res.render('auth/login', { error: err.message });
    }
  }

  @Get()
  async renderDashboard1(@Res() res: Response, @Req() req: Request) {
    const user = (req.session as any)?.user;
    if (!user) return res.redirect('/login');
    return renderView(res, 'layouts/main', { user, title: 'Dashboard' });
  }

  @Get('dashboard')
  async renderDashboard2(@Res() res: Response, @Req() req: Request) {
    const user = (req.session as any)?.user;
    if (!user) return res.redirect('/login');
    return renderView(res, 'layouts/main', { user, title: 'Dashboard' });
  }

  @Get('logout')
  logout(@Res() res: Response, @Req() req: Request) {
    req.session.destroy((err) => {
      res.redirect('/login');
    });
  }
}