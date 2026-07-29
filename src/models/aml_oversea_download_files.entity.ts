import { Entity, PrimaryColumn, Column } from 'typeorm';

@Entity('aml_oversea_download_files')
export class ModelAmlOverseaDownloadFiles {

  @PrimaryColumn()
  aml_process_id: string;
  
  @PrimaryColumn()
  aml_oversea_end_point_id: string;

  @Column()
  file_contents: string;

}