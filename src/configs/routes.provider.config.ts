import { HttpService } from '../utils/http.service.util';

import { AuthService } from '../services/auth.service';
import { AppModuleService } from '../services/app-module.service';
import { ServiceAmlResourceDownloadFiles } from '../services/aml_oversea_download_files.service';

import { UserValidator } from '../validators/user.validator';
import { AppModuleValidator } from '../validators/app-module.validator';

export const import_providers = [
    HttpService,

    AuthService,
    UserValidator,
    AppModuleValidator, AppModuleService,

    ServiceAmlResourceDownloadFiles,
    
];