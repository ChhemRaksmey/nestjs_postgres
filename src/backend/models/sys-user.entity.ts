import { Entity, PrimaryColumn, Column } from 'typeorm';

@Entity('sys_user')
export class SysUser {
  @PrimaryColumn()
  user_id: string;

  @Column()
  staff_id: string;

  @Column()
  signon_name: string;

  @Column()
  full_name: string;

  @Column()
  date_start: string;

  @Column()
  date_expire: string;

  @Column()
  time_start: string;

  @Column()
  time_end: string;

  @Column()
  user_password: string;

  @Column()
  user_status: string;
}