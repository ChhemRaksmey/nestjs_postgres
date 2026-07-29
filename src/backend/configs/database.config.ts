import { TypeOrmModuleOptions } from '@nestjs/typeorm';
import * as dotenv from 'dotenv';
dotenv.config();


export const databaseConfig: TypeOrmModuleOptions = {
  type: 'mysql',
  host: process.env.DB_HOST || '127.0.0.1',
  port: parseInt(process.env.DB_PORT as string, 10) || 3306,
  username: process.env.DB_USER || 'root',
  password: process.env.DB_PASS || '123456789',
  database: process.env.DB_NAME || 'db_core_system',
  autoLoadEntities: true,
  synchronize: false,
};

// export const databaseConfig: TypeOrmModuleOptions = {
//   type: 'postgres',
//   host: process.env.DB_HOST || '127.0.0.1',
//   port: parseInt(process.env.DB_PORT as string, 10) || 5432,
//   username: process.env.DB_USER || 'root',
//   password: process.env.DB_PASS || '123456789',
//   database: process.env.DB_NAME || 'db_core_system',
//   autoLoadEntities: true,
//   synchronize: false,
// };

