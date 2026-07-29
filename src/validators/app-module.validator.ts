import { Injectable } from '@nestjs/common';

@Injectable()
export class AppModuleValidator {
  validateCreate(data: any): { valid: boolean; message?: string } {
    if (!data.app_module_id || !data.full_name) {
      return { valid: false, message: 'Module ID and Full Name are required.' };
    }
    if (data.app_module_id.length > 25) {
      return { valid: false, message: 'Module ID must be under 25 characters.' };
    }
    return { valid: true };
  }

  validateUpdate(data: any): { valid: boolean; message?: string } {
    if (!data.full_name) {
      return { valid: false, message: 'Full Name is required for update.' };
    }
    return { valid: true };
  }
}