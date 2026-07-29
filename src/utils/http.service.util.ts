import { Injectable, HttpException, HttpStatus } from '@nestjs/common';
import axios, { AxiosRequestConfig, AxiosResponse } from 'axios';

@Injectable()
export class HttpService {
    
  private async handleRequest<T>(requestFn: () => Promise<AxiosResponse<T>>): Promise<T> {
    try {
      const response = await requestFn();
      return response.data;
    } catch (error) {
      throw new HttpException(
        error.response?.data || error.message || 'External API Error',
        error.response?.status || HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  // GET Method
  async get<T>(url: string, config?: AxiosRequestConfig): Promise<T> {
    return this.handleRequest(() => axios.get<T>(url, config));
  }

  // POST Method
  async post<T>(url: string, data?: any, config?: AxiosRequestConfig): Promise<T> {
    return this.handleRequest(() => axios.post<T>(url, data, config));
  }

  // PUT Method
  async put<T>(url: string, data?: any, config?: AxiosRequestConfig): Promise<T> {
    return this.handleRequest(() => axios.put<T>(url, data, config));
  }

  // DELETE Method
  async delete<T>(url: string, config?: AxiosRequestConfig): Promise<T> {
    return this.handleRequest(() => axios.delete<T>(url, config));
  }

}