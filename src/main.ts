import { NestFactory } from '@nestjs/core';
import { NestExpressApplication } from '@nestjs/platform-express';
import { join } from 'path';
import { AppModule } from './app.module';
import session from 'express-session';

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);
  
  // Setup View Engine (EJS)
  app.setBaseViewsDir(join(process.cwd(), 'views'));
  app.setViewEngine('ejs');

  // Express session configuration
  app.use(
    session({
      secret: 'core_system_secret_key',
      resave: false,
      saveUninitialized: false,
    }),
  );

  await app.listen(3000);
  console.log(`Application is running on: http://localhost:3000/login`);
}
bootstrap();