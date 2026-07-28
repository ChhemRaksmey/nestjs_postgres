DROP DATABASE IF EXISTS db_core_system;
CREATE DATABASE db_core_system DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE db_core_system;




DROP TABLE IF EXISTS sys_app_module CASCADE;
CREATE TABLE sys_app_module (
    app_module_id VARCHAR(25) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    PRIMARY KEY(app_module_id)
);
DROP TABLE IF EXISTS sys_app_screen CASCADE;
CREATE TABLE sys_app_screen (
    app_module_id VARCHAR(25) NOT NULL,
    app_screen_id VARCHAR(25) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    PRIMARY KEY(app_screen_id)
);
DROP TABLE IF EXISTS sys_app_screen_actions CASCADE;
CREATE TABLE sys_app_screen_actions (
    app_screen_id VARCHAR(25) NOT NULL,
    full_name VARCHAR(50) NOT NULL,
    PRIMARY KEY(app_screen_id, full_name)
);
DROP TABLE IF EXISTS sys_user_privilege CASCADE;
CREATE TABLE sys_user_privilege (
    sys_user_privilege_id VARCHAR(25) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    PRIMARY KEY(sys_user_privilege_id)
);
DROP TABLE IF EXISTS sys_user_privilege_permission CASCADE;
CREATE TABLE sys_user_privilege_permission (
    sys_user_privilege_id VARCHAR(25) NOT NULL,
    app_screen_id VARCHAR(25) NOT NULL,
    action_name VARCHAR(50) NOT NULL,
    PRIMARY KEY(sys_user_privilege_id, app_screen_id, action_name)
);
DROP TABLE IF EXISTS sys_user CASCADE;
CREATE TABLE sys_user (
    user_id VARCHAR(25) NOT NULL,
    staff_id VARCHAR(11) NOT NULL,
    signon_name VARCHAR(35) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    date_start VARCHAR(10) NOT NULL,
    date_expire VARCHAR(10) NOT NULL,
    time_start VARCHAR(5) NOT NULL,
    time_end VARCHAR(5) NOT NULL,
    user_password TEXT,
    user_status VARCHAR(100) NOT NULL,
    PRIMARY KEY(user_id)
);
DROP TABLE IF EXISTS sys_user_access_privileges CASCADE;
CREATE TABLE sys_user_access_privileges (
    user_id VARCHAR(25) NOT NULL,
    sys_user_privilege_id VARCHAR(100) NOT NULL,
    PRIMARY KEY(user_id, sys_user_privilege_id)
);
DROP TABLE IF EXISTS sys_user_password_history CASCADE;
CREATE TABLE sys_user_password_history (
    user_id VARCHAR(25) NOT NULL,
    date_change TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_password TEXT,
    PRIMARY KEY(user_id, date_change)
);



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
    ('USR_2026_001_000001', '99999999999', 'adminstrattor', 'System Administrator', '2020-01-01', '2999-12-31', '00:00', '23:59', '12341234', 'Active'),
    ('USR_2026_001_000002', '20260000001', 'user1', 'User Name 1', '2020-01-01', '2999-12-31', '00:00', '23:59', '12341234', 'Active'),
    ('USR_2026_001_000003', '20260000002', 'user2', 'User Name 2', '2020-01-01', '2999-12-31', '00:00', '23:59', '12341234', 'Active');
INSERT INTO sys_user_access_privileges VALUES
    ('USR_2026_001_000001', 'SYS_USR_PVL_2026_001_01'),
    ('USR_2026_001_000002', 'SYS_USR_PVL_2026_001_01'),
    ('USR_2026_001_000003', 'SYS_USR_PVL_2026_001_01');

