import { Injectable, BadRequestException, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Like } from 'typeorm';
import { ModelAmlOverseaDownloadFiles } from '../models/aml_oversea_download_files.entity';
import { HttpService } from '../utils/http.service.util';

@Injectable()
export class ServiceAmlResourceDownloadFiles {

  constructor(
    @InjectRepository(ModelAmlOverseaDownloadFiles)
    private readonly mdl: Repository<ModelAmlOverseaDownloadFiles>,
    private readonly httpService: HttpService
  ) {}

  async aml_resource_download (process_id: string, aml_resource_id: string) {

    const url = 'http://localhost:3000/data_sample_aml/un_consolidated.xml';
    const api_data = await this.httpService.get<string>(url, { maxBodyLength: Infinity });

    this.mdl ;

    var records = this.mdl.create({
      aml_process_id: process_id,
      aml_oversea_end_point_id: aml_resource_id,
      file_contents: api_data,
    });

    records = await this.mdl.save(records);

    console.log(records);

    return api_data;
  }

  async aml_resource_extract (id: string) {}

  async get_records (id: string) {}

  async get_record (id: string) {}

  async save_create (id: string) {}

  async save_update (id: string) {}

}