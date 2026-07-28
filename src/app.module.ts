import { Module, MiddlewareConsumer } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ServeStaticModule } from '@nestjs/serve-static';
import { join } from 'path';
import { databaseConfig } from './backend/configs/database.config';
import { AuthMiddleware } from './backend/middlewares/auth.middleware';

// import controler, provide and database entity
import { import_controllers } from './backend/configs/routes.controler.config';
import { import_providers } from './backend/configs/routes.provider.config';
import { import_entitys } from './backend/configs/routes.entity.config';


@Module({
  imports: [
    TypeOrmModule.forRoot(databaseConfig),
    TypeOrmModule.forFeature(import_entitys),
    ServeStaticModule.forRoot({
      rootPath: join(process.cwd(), 'public'),
      serveRoot: '/', 
    }),
  ],
  controllers: import_controllers,
  providers: import_providers,
})
export class AppModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(AuthMiddleware).forRoutes('*');
  }
}