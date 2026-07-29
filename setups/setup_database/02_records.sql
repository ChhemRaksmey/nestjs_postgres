SET SQL_SAFE_UPDATES = 0;


INSERT INTO sys_app_module VALUES
    ('SYS_APP_MDL_2026_001_01', 'System Administrator');
INSERT INTO sys_app_screen VALUES
    ('SYS_APP_MDL_2026_001_01', 'SYS_APP_SRC_2026_001_01', 'Application Module'),
    ('SYS_APP_MDL_2026_001_01', 'SYS_APP_SRC_2026_001_02', 'Application Screen'),
    ('SYS_APP_MDL_2026_001_01', 'SYS_APP_SRC_2026_001_03', 'User Privilege'),
    ('SYS_APP_MDL_2026_001_01', 'SYS_APP_SRC_2026_001_04', 'User Setup');
INSERT INTO sys_app_screen_actions VALUES
    ('SYS_APP_SRC_2026_001_01', 'Search'),
    ('SYS_APP_SRC_2026_001_01', 'View'),
    ('SYS_APP_SRC_2026_001_01', 'Create'),
    ('SYS_APP_SRC_2026_001_01', 'Edit'),
    ('SYS_APP_SRC_2026_001_01', 'Aprrove'),
    ('SYS_APP_SRC_2026_001_01', 'Delete'),
    ('SYS_APP_SRC_2026_001_01', 'Enable'),
    ('SYS_APP_SRC_2026_001_01', 'Disable'),
    
    ('SYS_APP_SRC_2026_001_02', 'Search'),
    ('SYS_APP_SRC_2026_001_02', 'View'),
    ('SYS_APP_SRC_2026_001_02', 'Create'),
    ('SYS_APP_SRC_2026_001_02', 'Edit'),
    ('SYS_APP_SRC_2026_001_02', 'Aprrove'),
    ('SYS_APP_SRC_2026_001_02', 'Delete'),
    ('SYS_APP_SRC_2026_001_02', 'Enable'),
    ('SYS_APP_SRC_2026_001_02', 'Disable'),

    ('SYS_APP_SRC_2026_001_03', 'Search'),
    ('SYS_APP_SRC_2026_001_03', 'View'),
    ('SYS_APP_SRC_2026_001_03', 'Create'),
    ('SYS_APP_SRC_2026_001_03', 'Edit'),
    ('SYS_APP_SRC_2026_001_03', 'Aprrove'),
    ('SYS_APP_SRC_2026_001_03', 'Delete'),
    ('SYS_APP_SRC_2026_001_03', 'Enable'),
    ('SYS_APP_SRC_2026_001_03', 'Disable'),

    ('SYS_APP_SRC_2026_001_04', 'Search'),
    ('SYS_APP_SRC_2026_001_04', 'View'),
    ('SYS_APP_SRC_2026_001_04', 'Create'),
    ('SYS_APP_SRC_2026_001_04', 'Edit'),
    ('SYS_APP_SRC_2026_001_04', 'Delete'),
    ('SYS_APP_SRC_2026_001_04', 'Password Reset'),
    ('SYS_APP_SRC_2026_001_04', 'Enable'),
    ('SYS_APP_SRC_2026_001_04', 'Disable');
INSERT INTO sys_user_privilege VALUES
    ('SYS_USR_PVL_2026_001_01', 'Administrator');
INSERT INTO sys_user_privilege_permission VALUES
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_01', 'Search'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_01', 'View'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_01', 'Create'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_01', 'Edit'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_01', 'Aprrove'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_01', 'Delete'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_01', 'Enable'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_01', 'Disable'),
    
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_02', 'Search'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_02', 'View'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_02', 'Create'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_02', 'Edit'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_02', 'Aprrove'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_02', 'Delete'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_02', 'Enable'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_02', 'Disable'),

    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_03', 'Search'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_03', 'View'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_03', 'Create'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_03', 'Edit'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_03', 'Aprrove'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_03', 'Delete'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_03', 'Enable'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_03', 'Disable'),

    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_04', 'Search'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_04', 'View'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_04', 'Create'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_04', 'Edit'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_04', 'Delete'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_04', 'Password Reset'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_04', 'Enable'),
    ('SYS_USR_PVL_2026_001_01', 'SYS_APP_SRC_2026_001_04', 'Disable');
INSERT INTO sys_user VALUES
    ('USR_2026_001_000001', '99999999999', 'adminstrattor', 'System Administrator', '2020-01-01', '2999-12-31', '00:00', '23:59', UNHEX(MD5('12341234')), 'Active'),
    ('USR_2026_001_000002', '20260000001', 'user1', 'User Name 1', '2020-01-01', '2999-12-31', '00:00', '23:59', UNHEX(MD5('12341234')), 'Active'),
    ('USR_2026_001_000003', '20260000002', 'user2', 'User Name 2', '2020-01-01', '2999-12-31', '00:00', '23:59', UNHEX(MD5('12341234')), 'Active');
INSERT INTO sys_user_access_privileges VALUES
    ('USR_2026_001_000001', 'SYS_USR_PVL_2026_001_01'),
    ('USR_2026_001_000002', 'SYS_USR_PVL_2026_001_01'),
    ('USR_2026_001_000003', 'SYS_USR_PVL_2026_001_01');
