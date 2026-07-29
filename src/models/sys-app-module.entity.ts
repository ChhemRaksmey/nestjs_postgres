import { Entity, PrimaryColumn, Column } from 'typeorm';

@Entity('sys_app_module')
export class SysAppModule {
  @PrimaryColumn()
  app_module_id: string;

  @Column()
  full_name: string;
}