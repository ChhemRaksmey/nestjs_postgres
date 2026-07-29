import { Injectable, UnauthorizedException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { SysUser } from '../models/sys-user.entity';
import { UserValidator } from '../validators/user.validator';
import * as crypto from 'crypto';

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(SysUser)
    private readonly userRepository: Repository<SysUser>,
    private readonly userValidator: UserValidator,
  ) {}

  async authenticate(credentials: { signon_name: string; password: string }) {
    // 1. Validation check
    const validation = this.userValidator.validateLogin(credentials);
    if (!validation.valid) {
      throw new UnauthorizedException(validation.message);
    }

    // 2. Database query matching MD5 binary storage format
    const hashedPassword = crypto.createHash('md5').update(credentials.password).digest();

    const user = await this.userRepository.findOne({
      where: {
        signon_name: credentials.signon_name,
        user_status: 'Active',
      },
    });

    // if (!user || Buffer.compare(user.user_password, hashedPassword) !== 0) {
    // if (!user || user.user_password !== hashedPassword.toString()) {
    //   throw new UnauthorizedException('Invalid credentials or inactive account.');
    // }

    if (!user || user.user_password !== credentials.password) {
      throw new UnauthorizedException('Invalid credentials or inactive account.');
    }

    return user;
  }
}