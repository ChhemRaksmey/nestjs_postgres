
import { AuthController } from '../controllers/auth.controller';

import { ControllerReportGenerate } from '../controllers/sys-report-generate.controller';

import { ControllerSysAppModule } from '../controllers/app-module.controller';
import { ControllerSysAppScreen } from '../controllers/sys-app-screen.controller';
import { ControllerSysUserPrivilege } from '../controllers/sys-user-privilege.controller';
import { ControllerSysUser } from '../controllers/sys-user.controller';

import { ControllerAMLMaintenanceRiskLevel } from '../controllers/antimoney-laundering/maintenance/aml-risk-level.controller';
import { ControllerAMLMaintenanceCustomerDetectionRole } from '../controllers/antimoney-laundering/maintenance/aml-customer-detection-role.controller';
import { ControllerAMLFrontOfficeCustomerDetectedAlert } from '../controllers/antimoney-laundering/front-office/aml-customer-detected-alert.controller';
import { ControllerAMLFrontOfficeWatchList } from '../controllers/antimoney-laundering/front-office/aml-watchlist.controller';
import { ControllerAMLFrontOfficeWhiteList } from '../controllers/antimoney-laundering/front-office/aml-whitelist.controller';

import { ControllerAMLFrontOfficeOnboard } from '../controllers/antimoney-laundering/front-office/aml-onboard.controller';

export const import_controllers = [
    
    AuthController,

    ControllerReportGenerate,

    ControllerSysAppModule,
    ControllerSysAppScreen,
    ControllerSysUserPrivilege,
    ControllerSysUser,

    ControllerAMLMaintenanceRiskLevel,
    ControllerAMLMaintenanceCustomerDetectionRole,
    
    ControllerAMLFrontOfficeCustomerDetectedAlert,
    ControllerAMLFrontOfficeWatchList,
    ControllerAMLFrontOfficeWhiteList,
    
    ControllerAMLFrontOfficeOnboard,

];