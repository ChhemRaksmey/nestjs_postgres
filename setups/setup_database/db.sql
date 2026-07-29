DROP DATABASE IF EXISTS db_core_system;
CREATE DATABASE db_core_system DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE db_core_system;


CREATE TABLE sys_app_module (
    app_module_id VARCHAR(25) NOT NULL Comment "Format {SYS_APP_MDL}_DATE(4)_DAYOFYEAR(3)_SEQ(2) example: SYS_APP_MDL_2026_001_01",
    full_name VARCHAR(100) NOT NULL,
    PRIMARY KEY(app_module_id)
);
INSERT INTO sys_app_module VALUES
    ("SYS_APP_MDL_2026_001_01", "System Administrator");

CREATE TABLE sys_app_screen (
    app_module_id VARCHAR(25) NOT NULL,
    app_screen_id VARCHAR(25) NOT NULL Comment "Format {SYS_APP_SRC}_DATE(4)_DAYOFYEAR(3)_SEQ(2) example: SYS_APP_SRC_2026_001_01",
    full_name VARCHAR(100) NOT NULL,
    PRIMARY KEY(app_screen_id),
    FOREIGN KEY (app_module_id) REFERENCES sys_app_module(app_module_id)
);
INSERT INTO sys_app_screen VALUES
    ("SYS_APP_MDL_2026_001_01", "SYS_APP_SRC_2026_001_01", "Application Module"),
    ("SYS_APP_MDL_2026_001_01", "SYS_APP_SRC_2026_001_02", "Application Screen"),
    ("SYS_APP_MDL_2026_001_01", "SYS_APP_SRC_2026_001_03", "User Privilege"),
    ("SYS_APP_MDL_2026_001_01", "SYS_APP_SRC_2026_001_04", "User Setup");

CREATE TABLE sys_app_screen_actions (
    app_screen_id VARCHAR(25) NOT NULL,
    full_name VARCHAR(50) NOT NULL,
    PRIMARY KEY(app_screen_id, full_name),
    FOREIGN KEY (app_screen_id) REFERENCES sys_app_screen(app_screen_id)
);
INSERT INTO sys_app_screen_actions VALUES
    ("SYS_APP_SRC_2026_001_01", "Search"),
    ("SYS_APP_SRC_2026_001_01", "View"),
    ("SYS_APP_SRC_2026_001_01", "Create"),
    ("SYS_APP_SRC_2026_001_01", "Edit"),
    ("SYS_APP_SRC_2026_001_01", "Aprrove"),
    ("SYS_APP_SRC_2026_001_01", "Delete"),
    ("SYS_APP_SRC_2026_001_01", "Enable"),
    ("SYS_APP_SRC_2026_001_01", "Disable"),
    
    ("SYS_APP_SRC_2026_001_02", "Search"),
    ("SYS_APP_SRC_2026_001_02", "View"),
    ("SYS_APP_SRC_2026_001_02", "Create"),
    ("SYS_APP_SRC_2026_001_02", "Edit"),
    ("SYS_APP_SRC_2026_001_02", "Aprrove"),
    ("SYS_APP_SRC_2026_001_02", "Delete"),
    ("SYS_APP_SRC_2026_001_02", "Enable"),
    ("SYS_APP_SRC_2026_001_02", "Disable"),

    ("SYS_APP_SRC_2026_001_03", "Search"),
    ("SYS_APP_SRC_2026_001_03", "View"),
    ("SYS_APP_SRC_2026_001_03", "Create"),
    ("SYS_APP_SRC_2026_001_03", "Edit"),
    ("SYS_APP_SRC_2026_001_03", "Aprrove"),
    ("SYS_APP_SRC_2026_001_03", "Delete"),
    ("SYS_APP_SRC_2026_001_03", "Enable"),
    ("SYS_APP_SRC_2026_001_03", "Disable"),

    ("SYS_APP_SRC_2026_001_04", "Search"),
    ("SYS_APP_SRC_2026_001_04", "View"),
    ("SYS_APP_SRC_2026_001_04", "Create"),
    ("SYS_APP_SRC_2026_001_04", "Edit"),
    ("SYS_APP_SRC_2026_001_04", "Delete"),
    ("SYS_APP_SRC_2026_001_04", "Password Reset"),
    ("SYS_APP_SRC_2026_001_04", "Enable"),
    ("SYS_APP_SRC_2026_001_04", "Disable");

CREATE TABLE sys_user_privilege (
    sys_user_privilege_id VARCHAR(25) NOT NULL Comment "Format {SYS_USR_PVL}_DATE(4)_DAYOFYEAR(3)_SEQ(2) example: SYS_USR_PVL_2026_001_01",
    full_name VARCHAR(100) NOT NULL,
    PRIMARY KEY(sys_user_privilege_id)
);
INSERT INTO sys_user_privilege VALUES
    ("SYS_USR_PVL_2026_001_01", "Administrator");

CREATE TABLE sys_user_privilege_permission (
    sys_user_privilege_id VARCHAR(25) NOT NULL,
    app_screen_id VARCHAR(25) NOT NULL,
    action_name VARCHAR(50) NOT NULL,
    PRIMARY KEY(sys_user_privilege_id, app_screen_id, action_name),
    FOREIGN KEY (sys_user_privilege_id) REFERENCES sys_user_privilege(sys_user_privilege_id),
    FOREIGN KEY (app_screen_id, action_name) REFERENCES sys_app_screen_actions(app_screen_id, full_name)
);
INSERT INTO sys_user_privilege_permission VALUES
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_01", "Search"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_01", "View"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_01", "Create"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_01", "Edit"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_01", "Aprrove"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_01", "Delete"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_01", "Enable"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_01", "Disable"),
    
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_02", "Search"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_02", "View"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_02", "Create"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_02", "Edit"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_02", "Aprrove"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_02", "Delete"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_02", "Enable"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_02", "Disable"),

    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_03", "Search"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_03", "View"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_03", "Create"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_03", "Edit"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_03", "Aprrove"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_03", "Delete"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_03", "Enable"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_03", "Disable"),

    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_04", "Search"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_04", "View"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_04", "Create"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_04", "Edit"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_04", "Delete"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_04", "Password Reset"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_04", "Enable"),
    ("SYS_USR_PVL_2026_001_01", "SYS_APP_SRC_2026_001_04", "Disable");

CREATE TABLE sys_user (
    user_id VARCHAR(25) NOT NULL COMMENT "Format {USR}_DATE(4)_DAYOFYEAR(3)_SEQ(6) example: USR_2026_001_000001",
    staff_id VARCHAR(11) NOT NULL,
    signon_name VARCHAR(35) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    date_start VARCHAR(10) NOT NULL COMMENT "YYYY-mm-dd",
    date_expire VARCHAR(10) NOT NULL COMMENT "YYYY-mm-dd",
    time_start VARCHAR(5) NOT NULL COMMENT "HH:ii",
    time_end VARCHAR(5) NOT NULL COMMENT "HH:ii",
    user_password BINARY(16) COMMENT "encryption",
    user_status VARCHAR(100) NOT NULL COMMENT "Active, Expired, Locked, Disabled, Password Reset",
    PRIMARY KEY(user_id)
);

INSERT INTO sys_user VALUES
    ("USR_2026_001_000001", "99999999999", "adminstrattor", "System Administrator", "2020-01-01", "2999-12-31", "00:00", "23:59", UNHEX(MD5('12341234')), "Active"),
    ("USR_2026_001_000002", "20260000001", "user1", "User Name 1", "2020-01-01", "2999-12-31", "00:00", "23:59", UNHEX(MD5('12341234')), "Active"),
    ("USR_2026_001_000003", "20260000002", "user2", "User Name 2", "2020-01-01", "2999-12-31", "00:00", "23:59", UNHEX(MD5('12341234')), "Active");
    
CREATE TABLE sys_user_access_privileges (
    user_id VARCHAR(25) NOT NULL,
    sys_user_privilege_id VARCHAR(100) NOT NULL,
    PRIMARY KEY(user_id, sys_user_privilege_id),
    FOREIGN KEY (user_id) REFERENCES sys_user(user_id),
    FOREIGN KEY (sys_user_privilege_id) REFERENCES sys_user_privilege(sys_user_privilege_id)
);
INSERT INTO sys_user_access_privileges VALUES
    ("USR_2026_001_000001", "SYS_USR_PVL_2026_001_01"),
    ("USR_2026_001_000002", "SYS_USR_PVL_2026_001_01"),
    ("USR_2026_001_000003", "SYS_USR_PVL_2026_001_01");

CREATE TABLE sys_user_password_history (
    user_id VARCHAR(25) NOT NULL,
    date_change TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    user_password TEXT Comment "encryption",
    PRIMARY KEY(user_id, date_change),
    FOREIGN KEY (user_id) REFERENCES sys_user(user_id)
);








CREATE TABLE aml_resources (
    aml_resource_id VARCHAR(35) NOT NULL COMMENT "Format AML_RESOURCE_DATE(4)_DAYOFYEAR(3)_SEQ(2) example: AML_RESOURCE_2026001_01",
    short_name VARCHAR(50) NOT NULL,
    full_name VARCHAR(150) NOT NULL,
    end_point TEXT NOT NULL,
    enable_status INT DEFAULT 0,
    PRIMARY KEY(aml_resource_id)
);
CREATE TABLE aml_resource_load (
    aml_resource_id VARCHAR(35) NOT NULL COMMENT "Format AML_RESOURCE_DATE(4)_DAYOFYEAR(3)_SEQ(2) example: AML_RESOURCE_2026001_01",
    datetime_process TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    action_type VARCHAR(35) DEFAULT "Auto" COMMENT "Auto, Manual",
    datetime_resource_load_start TIMESTAMP DEFAULT NULL,
    datetime_resource_load_end TIMESTAMP DEFAULT NULL,
    datetime_resource_extract_start TIMESTAMP DEFAULT NULL,
    datetime_resource_extract_end TIMESTAMP DEFAULT NULL,
    load_status VARCHAR(15) DEFAULT '' COMMENT "Blank, Pending, Loading, Extracting, Completed, Error",
    narrative TEXT,
    PRIMARY KEY(aml_resource_id, datetime_process)
);
CREATE TABLE aml_resource_load_files (
    aml_resource_id VARCHAR(35) NOT NULL COMMENT "Format AML_RESOURCE_DATE(4)_DAYOFYEAR(3)_SEQ(2) example: AML_RESOURCE_2026001_01",
    datetime_process TIMESTAMP DEFAULT NULL,
    aml_resource_records TEXT,
    PRIMARY KEY(aml_resource_id, datetime_process)
);







CREATE TABLE ls_country (
    country_id2 VARCHAR(2) NOT NULL,
    country_id3 VARCHAR(3) NOT NULL,
    full_name VARCHAR(150) NOT NULL,
    PRIMARY KEY(country_id2, country_id3)
);
INSERT INTO ls_country VALUES
    ("AFG", "AF", "Afghanistan"),
    ("ALB", "AL", "Albania"),
    ("DZA", "DZ", "Algeria"),
    ("AND", "AD", "Andorra"),
    ("AGO", "AO", "Angola"),
    ("ATG", "AG", "Antigua and Barbuda"),
    ("ARG", "AR", "Argentina"),
    ("ARM", "AM", "Armenia"),
    ("AUS", "AU", "Australia"),
    ("AUT", "AT", "Austria"),
    ("AZE", "AZ", "Azerbaijan"),
    ("BHS", "BS", "Bahamas"),
    ("BHR", "BH", "Bahrain"),
    ("BGD", "BD", "Bangladesh"),
    ("BRB", "BB", "Barbados"),
    ("BLR", "BY", "Belarus"),
    ("BEL", "BE", "Belgium"),
    ("BLZ", "BZ", "Belize"),
    ("BEN", "BJ", "Benin"),
    ("BTN", "BT", "Bhutan"),
    ("BOL", "BO", "Bolivia"),
    ("BIH", "BA", "Bosnia and Herzegovina"),
    ("BWA", "BW", "Botswana"),
    ("BRA", "BR", "Brazil"),
    ("BRN", "BN", "Brunei"),
    ("BGR", "BG", "Bulgaria"),
    ("BFA", "BF", "Burkina Faso"),
    ("BDI", "BI", "Burundi"),
    ("CPV", "CV", "Cabo Verde"),
    ("KHM", "KH", "Cambodia"),
    ("CMR", "CM", "Cameroon"),
    ("CAN", "CA", "Canada"),
    ("CAF", "CF", "Central African Republic"),
    ("TCD", "TD", "Chad"),
    ("CHL", "CL", "Chile"),
    ("CHN", "CN", "China"),
    ("COL", "CO", "Colombia"),
    ("COM", "KM", "Comoros"),
    ("COG", "CG", "Congo (Republic)"),
    ("COD", "CD", "Congo (Democratic Republic)"),
    ("CRI", "CR", "Costa Rica"),
    ("HRV", "HR", "Croatia"),
    ("CUB", "CU", "Cuba"),
    ("CYP", "CY", "Cyprus"),
    ("CZE", "CZ", "Czechia (Czech Republic)"),
    ("DNK", "DK", "Denmark"),
    ("DJI", "DJ", "Djibouti"),
    ("DMA", "DM", "Dominica"),
    ("DOM", "DO", "Dominican Republic"),
    ("ECU", "EC", "Ecuador"),
    ("EGY", "EG", "Egypt"),
    ("SLV", "SV", "El Salvador"),
    ("GNQ", "GQ", "Equatorial Guinea"),
    ("ERI", "ER", "Eritrea"),
    ("EST", "EE", "Estonia"),
    ("SWZ", "SZ", "Eswatini"),
    ("ETH", "ET", "Ethiopia"),
    ("FJI", "FJ", "Fiji"),
    ("FIN", "FI", "Finland"),
    ("FRA", "FR", "France"),
    ("GAB", "GA", "Gabon"),
    ("GMB", "GM", "Gambia"),
    ("GEO", "GE", "Georgia"),
    ("DEU", "DE", "Germany"),
    ("GHA", "GH", "Ghana"),
    ("GRC", "GR", "Greece"),
    ("GRD", "GD", "Grenada"),
    ("GTM", "GT", "Guatemala"),
    ("GIN", "GN", "Guinea"),
    ("GNB", "GW", "Guinea-Bissau"),
    ("GUY", "GY", "Guyana"),
    ("HTI", "HT", "Haiti"),
    ("HND", "HN", "Honduras"),
    ("HUN", "HU", "Hungary"),
    ("ISL", "IS", "Iceland"),
    ("IND", "IN", "India"),
    ("IDN", "ID", "Indonesia"),
    ("IRN", "IR", "Iran"),
    ("IRQ", "IQ", "Iraq"),
    ("IRL", "IE", "Ireland"),
    ("ISR", "IL", "Israel"),
    ("ITA", "IT", "Italy"),
    ("JAM", "JM", "Jamaica"),
    ("JPN", "JP", "Japan"),
    ("JOR", "JO", "Jordan"),
    ("KAZ", "KZ", "Kazakhstan"),
    ("KEN", "KE", "Kenya"),
    ("KIR", "KI", "Kiribati"),
    ("KWT", "KW", "Kuwait"),
    ("KGZ", "KG", "Kyrgyzstan"),
    ("LAO", "LA", "Laos"),
    ("LVA", "LV", "Latvia"),
    ("LBN", "LB", "Lebanon"),
    ("LSO", "LS", "Lesotho"),
    ("LBR", "LR", "Liberia"),
    ("LBY", "LY", "Libya"),
    ("LIE", "LI", "Liechtenstein"),
    ("LTU", "LT", "Lithuania"),
    ("LUX", "LU", "Luxembourg"),
    ("MDG", "MG", "Madagascar"),
    ("MWI", "MW", "Malawi"),
    ("MYS", "MY", "Malaysia"),
    ("MDV", "MV", "Maldives"),
    ("MLI", "ML", "Mali"),
    ("MLT", "MT", "Malta"),
    ("MHL", "MH", "Marshall Islands"),
    ("MRT", "MR", "Mauritania"),
    ("MUS", "MU", "Mauritius"),
    ("MEX", "MX", "Mexico"),
    ("FSM", "FM", "Micronesia"),
    ("MDA", "MD", "Moldova"),
    ("MCO", "MC", "Monaco"),
    ("MNG", "MN", "Mongolia"),
    ("MNE", "ME", "Montenegro"),
    ("MAR", "MA", "Morocco"),
    ("MOZ", "MZ", "Mozambique"),
    ("MMR", "MM", "Myanmar"),
    ("NAM", "NA", "Namibia"),
    ("NRU", "NR", "Nauru"),
    ("NPL", "NP", "Nepal"),
    ("NLD", "NL", "Netherlands"),
    ("NZL", "NZ", "New Zealand"),
    ("NIC", "NI", "Nicaragua"),
    ("NER", "NE", "Niger"),
    ("NGA", "NG", "Nigeria"),
    ("PRK", "KP", "North Korea"),
    ("MKD", "MK", "North Macedonia"),
    ("NOR", "NO", "Norway"),
    ("OMN", "OM", "Oman"),
    ("PAK", "PK", "Pakistan"),
    ("PLW", "PW", "Palau"),
    ("PSE", "PS", "Palestine"),
    ("PAN", "PA", "Panama"),
    ("PNG", "PG", "Papua New Guinea"),
    ("PRY", "PY", "Paraguay"),
    ("PER", "PE", "Peru"),
    ("PHL", "PH", "Philippines"),
    ("POL", "PL", "Poland"),
    ("PRT", "PT", "Portugal"),
    ("QAT", "QA", "Qatar"),
    ("ROU", "RO", "Romania"),
    ("RUS", "RU", "Russia"),
    ("RWA", "RW", "Rwanda"),
    ("KNA", "KN", "Saint Kitts and Nevis"),
    ("LCA", "LC", "Saint Lucia"),
    ("WSM", "WS", "Samoa"),
    ("SMR", "SM", "San Marino"),
    ("STP", "ST", "Sao Tome and Principe"),
    ("SAU", "SA", "Saudi Arabia"),
    ("SEN", "SN", "Senegal"),
    ("SRB", "RS", "Serbia"),
    ("SYC", "SC", "Seychelles"),
    ("SLE", "SL", "Sierra Leone"),
    ("SGP", "SG", "Singapore"),
    ("SVK", "SK", "Slovakia"),
    ("SVN", "SI", "Slovenia"),
    ("SLB", "SB", "Solomon Islands"),
    ("SOM", "SO", "Somalia"),
    ("ZAF", "ZA", "South Africa"),
    ("KOR", "KR", "South Korea"),
    ("SSD", "SS", "South Sudan"),
    ("ESP", "ES", "Spain"),
    ("LKA", "LK", "Sri Lanka"),
    ("SDN", "SD", "Sudan"),
    ("SUR", "SR", "Suriname"),
    ("SWE", "SE", "Sweden"),
    ("CHE", "CH", "Switzerland"),
    ("SYR", "SY", "Syria"),
    ("TWN", "TW", "Taiwan"),
    ("TJK", "TJ", "Tajikistan"),
    ("TZA", "TZ", "Tanzania"),
    ("THA", "TH", "Thailand"),
    ("TLS", "TL", "Timor-Leste"),
    ("TGO", "TG", "Togo"),
    ("TON", "TO", "Tonga"),
    ("TTO", "TT", "Trinidad and Tobago"),
    ("TUN", "TN", "Tunisia"),
    ("TUR", "TR", "Türkiye (Turkey)"),
    ("TKM", "TM", "Turkmenistan"),
    ("TUV", "TV", "Tuvalu"),
    ("UGA", "UG", "Uganda"),
    ("UKR", "UA", "Ukraine"),
    ("ARE", "AE", "United Arab Emirates"),
    ("GBR", "GB", "United Kingdom"),
    ("USA", "US", "United States"),
    ("URY", "UY", "Uruguay"),
    ("UZB", "UZ", "Uzbekistan"),
    ("VUT", "VU", "Vanuatu"),
    ("VAT", "VA", "Vatican City"),
    ("VEN", "VE", "Venezuela"),
    ("VNM", "VN", "Vietnam"),
    ("YEM", "YE", "Yemen"),
    ("ZMB", "ZM", "Zambia"),
    ("ZWE", "ZW", "Zimbabwe");


