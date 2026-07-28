import { Injectable, BadRequestException, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Like } from 'typeorm';
import { SysAppModule } from '../models/sys-app-module.entity';
import { AppModuleValidator } from '../validators/app-module.validator';

@Injectable()
export class AppModuleService {

  constructor(
    @InjectRepository(SysAppModule)
    private readonly moduleRepo: Repository<SysAppModule>,
    private readonly validator: AppModuleValidator,
  ) {}

  async findAll(search: string = ''): Promise<SysAppModule[]> {
    if (search) {
      return this.moduleRepo.find({
        where: [
          { app_module_id: Like(`%${search}%`) },
          { full_name: Like(`%${search}%`) },
        ],
      });
    }
    return this.moduleRepo.find();
  }

  async findOne(id: string): Promise<SysAppModule> {
    const record = await this.moduleRepo.findOne({ where: { app_module_id: id } });
    if (!record) throw new NotFoundException(`Application Module ID ${id} not found.`);
    return record;
  }

  async create(data: any): Promise<SysAppModule> {
    const check = this.validator.validateCreate(data);
    if (!check.valid) throw new BadRequestException(check.message);

    const exists = await this.moduleRepo.findOne({ where: { app_module_id: data.app_module_id } });
    if (exists) throw new BadRequestException('Module ID already exists.');

    const newRecord = this.moduleRepo.create({
      app_module_id: data.app_module_id,
      full_name: data.full_name,
    });
    
    return await this.moduleRepo.save(newRecord);
  }

  async update(id: string, data: any): Promise<SysAppModule> {
    const check = this.validator.validateUpdate(data);
    if (!check.valid) throw new BadRequestException(check.message);

    const record = await this.findOne(id);
    record.full_name = data.full_name;
    return this.moduleRepo.save(record);
  }

  async delete(id: string): Promise<void> {
    const record = await this.findOne(id);
    await this.moduleRepo.remove(record);
  }

}