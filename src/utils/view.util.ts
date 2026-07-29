import type { Response } from 'express';
import * as ejs from 'ejs';
import { join } from 'path';

export async function renderView(res: Response, viewName: string, data: any) {
  const viewsDir = join(process.cwd(), 'src/views');
  
  // Render the specific view content file first
  const body = await ejs.renderFile(join(viewsDir, `${viewName}.ejs`), data);
  
  // Render it inside the master wrapper layout containing the sidebar
  return res.render('layouts/app-layout', { ...data, body });
}