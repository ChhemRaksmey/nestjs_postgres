import { Injectable } from '@nestjs/common';

@Injectable()
export class UserValidator {
  validateLogin(data: any): { valid: boolean; message?: string } {
    if (!data.signon_name || !data.password) {
      return { valid: false, message: 'Signon name and password are required.' };
    }
    return { valid: true };
  }
}