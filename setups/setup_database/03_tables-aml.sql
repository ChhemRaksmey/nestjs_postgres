SET SQL_SAFE_UPDATES = 0;



DROP TABLE IF EXISTS aml_oversea_end_points;
CREATE TABLE aml_oversea_end_points (
    aml_oversea_end_point_id VARCHAR(35) NOT NULL PRIMARY KEY,
    short_name VARCHAR(35),
    full_name VARCHAR(150),
    end_point VARCHAR(250),
    enable_status VARCHAR(1) DEFAULT 'Y'
);
DROP TABLE IF EXISTS aml_oversea_extract;
CREATE TABLE aml_oversea_extract (
    aml_process_id VARCHAR(35) NOT NULL,
    aml_oversea_end_point_id VARCHAR(35) NOT NULL,
    load_date_start VARCHAR(35) NOT NULL,
    load_date_end VARCHAR(35) NOT NULL,
    extract_date_start VARCHAR(35) NOT NULL,
    extract_date_end VARCHAR(35) NOT NULL,
    process_status VARCHAR(15) NOT NULL, -- -- comment 'Blank, Completed, Downloading, Extracting',
    narrative VARCHAR(250) NOT NULL,
    PRIMARY KEY(aml_process_id, aml_oversea_end_point_id)
);
DROP TABLE IF EXISTS aml_oversea_download_files;
CREATE TABLE aml_oversea_download_files (
    aml_process_id VARCHAR(35) NOT NULL,
    aml_oversea_end_point_id VARCHAR(35) NOT NULL,
    narrative TEXT,
    PRIMARY KEY(aml_process_id, aml_oversea_end_point_id)
);


DROP TABLE IF EXISTS aml_ofac_cons_sdn_entry;
CREATE TABLE aml_ofac_cons_sdn_entry (
    aml_process_id VARCHAR(35) NOT NULL,
    main_uid INT,
    first_name VARCHAR(255) NULL,
    last_name VARCHAR(255) NOT NULL,
    sdn_type VARCHAR(50) NOT NULL, -- -- comment 'Individual, Entity',
    remarks TEXT NULL
);
DROP TABLE IF EXISTS aml_ofac_cons_programs;
CREATE TABLE aml_ofac_cons_programs (
    aml_process_id VARCHAR(35) NOT NULL,
    main_uid INT,
    sdn_uid INT NOT NULL,
    program_name VARCHAR(100) NOT NULL,
    PRIMARY KEY(aml_process_id, main_uid)
);
DROP TABLE IF EXISTS aml_ofac_cons_akas;
CREATE TABLE aml_ofac_cons_akas (
    aml_process_id VARCHAR(35) NOT NULL,
    main_uid INT,
    sdn_uid INT NOT NULL,
    type VARCHAR(50) NULL, -- -- comment 'a.k.a., f.k.a'.
    category VARCHAR(50) NULL, -- -- comment 'strong, weak',
    first_name VARCHAR(255) NULL,
    last_name VARCHAR(255) NOT NULL,
    PRIMARY KEY(aml_process_id, main_uid)
);
DROP TABLE IF EXISTS aml_ofac_cons_ids;
CREATE TABLE aml_ofac_cons_ids (
    aml_process_id VARCHAR(35) NOT NULL,
    main_uid INT,
    sdn_uid INT NOT NULL,
    id_type VARCHAR(255) NULL,
    id_number TEXT NULL,
    id_country VARCHAR(100) NULL,
    PRIMARY KEY(aml_process_id, main_uid)
);
DROP TABLE IF EXISTS aml_ofac_cons_addresss;
CREATE TABLE aml_ofac_cons_addresss (
    aml_process_id VARCHAR(35) NOT NULL,
    main_uid INT,
    sdn_uid INT NOT NULL,
    address1 VARCHAR(255) NULL,
    address2 VARCHAR(255) NULL,
    address3 VARCHAR(255) NULL,
    city VARCHAR(100) NULL,
    state_or_province VARCHAR(100) NULL,
    postal_code VARCHAR(50) NULL,
    country VARCHAR(100) NULL,
    PRIMARY KEY(aml_process_id, main_uid)
);
DROP TABLE IF EXISTS aml_ofac_cons_date_of_births;
CREATE TABLE aml_ofac_cons_date_of_births (
    aml_process_id VARCHAR(35) NOT NULL,
    main_uid INT,
    sdn_uid INT NOT NULL,
    date_of_birth VARCHAR(50) NULL,
    main_entry BOOLEAN NULL,
    PRIMARY KEY(aml_process_id, main_uid)
);
DROP TABLE IF EXISTS aml_ofac_cons_place_of_births;
CREATE TABLE aml_ofac_cons_place_of_births (
    aml_process_id VARCHAR(35) NOT NULL,
    main_uid INT,
    sdn_uid INT NOT NULL,
    place_of_birth VARCHAR(255) NULL,
    main_entry BOOLEAN NULL,
    PRIMARY KEY(aml_process_id, main_uid)
);
DROP TABLE IF EXISTS aml_ofac_cons_nationalitys;
CREATE TABLE aml_ofac_cons_nationalitys (
    aml_process_id VARCHAR(35) NOT NULL,
    main_uid INT,
    sdn_uid INT NOT NULL,
    country VARCHAR(100) NULL,
    main_entry BOOLEAN NULL,
    PRIMARY KEY(aml_process_id, main_uid)
);


DROP TABLE IF EXISTS aml_ofac_sdn_sdn_entries;
CREATE TABLE aml_ofac_sdn_sdn_entries (
    aml_process_id VARCHAR(35) NOT NULL,
    main_uid INT NOT NULL UNIQUE,          -- Unique SDN entity number
    first_name VARCHAR(255) NULL,         -- First name or primary name
    last_name VARCHAR(255) NULL,          -- Last name / Surname
    sdn_type VARCHAR(50) NOT NULL,        -- e.g., 'individual', 'entity', 'vessel'
    title VARCHAR(100) NULL,              -- Title if applicable
    remarks TEXT NULL                     -- General remarks and history
);
DROP TABLE IF EXISTS aml_ofac_sdn_sdn_programs;
CREATE TABLE aml_ofac_sdn_sdn_programs (
    aml_process_id VARCHAR(35) NOT NULL,
    main_uid INT,
    ent_num SERIAL,
    program_code VARCHAR(50) NOT NULL,    -- e.g., 'CUBA', 'SDGT', 'IRAN'
    PRIMARY KEY(aml_process_id, main_uid, ent_num)
);
DROP TABLE IF EXISTS aml_ofac_sdn_sdn_aliases;
CREATE TABLE aml_ofac_sdn_sdn_aliases (
    aml_process_id VARCHAR(35) NOT NULL,
    main_uid INT,
    ent_num SERIAL,
    alias_type VARCHAR(50) NOT NULL,      -- e.g., 'a.k.a.', 'f.k.a.'
    first_name VARCHAR(255) NULL,
    last_name VARCHAR(255) NULL,
    category VARCHAR(50) NULL,            -- e.g., 'strong', 'weak'
    PRIMARY KEY(aml_process_id, main_uid, ent_num)
);
DROP TABLE IF EXISTS aml_ofac_sdn_sdn_addresses;
CREATE TABLE aml_ofac_sdn_sdn_addresses (
    aml_process_id VARCHAR(35) NOT NULL,
    main_uid INT,
    ent_num SERIAL,
    address_1 VARCHAR(255) NULL,
    address_2 VARCHAR(255) NULL,
    city VARCHAR(100) NULL,
    state_province VARCHAR(100) NULL,
    postal_code VARCHAR(50) NULL,
    country VARCHAR(100) NULL,
    PRIMARY KEY(aml_process_id, main_uid, ent_num)
);
DROP TABLE IF EXISTS aml_ofac_sdn_sdn_identifications;
CREATE TABLE aml_ofac_sdn_sdn_identifications (
    aml_process_id VARCHAR(35) NOT NULL,
    main_uid INT,
    ent_num SERIAL,
    id_type VARCHAR(100) NOT NULL,        -- e.g., 'Passport', 'Tax ID', 'Registration Number'
    id_number VARCHAR(100) NOT NULL,      -- The actual identification number/string
    id_country VARCHAR(100) NULL,         -- Issuing country
    issue_date VARCHAR(50) NULL,          -- Date of issue if available
    PRIMARY KEY(aml_process_id, main_uid, ent_num)
);
DROP TABLE IF EXISTS aml_ofac_sdn_sdn_crypto_wallets;
CREATE TABLE aml_ofac_sdn_sdn_crypto_wallets (
    aml_process_id VARCHAR(35) NOT NULL,
    main_uid INT,
    ent_num SERIAL,
    asset_type VARCHAR(50) NOT NULL,      -- e.g., 'XBT' (Bitcoin), 'ETH' (Ethereum)
    wallet_address VARCHAR(255) NOT NULL, -- The blockchain wallet address string
    PRIMARY KEY(aml_process_id, main_uid, ent_num)
);


DROP TABLE IF EXISTS aml_un_cons_individuals;
CREATE TABLE aml_un_cons_individuals (
    aml_process_id VARCHAR(35) NOT NULL,
    dataid BIGINT,
    versionnum INT,
    first_name VARCHAR(255) NOT NULL,
    second_name VARCHAR(255) DEFAULT '',
    third_name VARCHAR(255) DEFAULT '',
    fourth_name VARCHAR(255) DEFAULT '',
    un_list_type VARCHAR(100) DEFAULT '',
    reference_number VARCHAR(50) DEFAULT '',
    listed_on DATE,
    gender VARCHAR(50) DEFAULT '',
    comments1 TEXT,
    has_interpol_link VARCHAR(3),
    interpol_link TEXT,
    name_original_script TEXT,
    PRIMARY KEY(aml_process_id, dataid)
);
DROP TABLE IF EXISTS aml_un_cons_individual_aliases;
CREATE TABLE aml_un_cons_individual_aliases (
    aml_process_id VARCHAR(35) NOT NULL,
    dataid BIGINT,
    quality VARCHAR(50) DEFAULT '',
    alias_name VARCHAR(255) NOT NULL,
    PRIMARY KEY(aml_process_id, dataid)
);
DROP TABLE IF EXISTS aml_un_cons_individual_addresses;
CREATE TABLE aml_un_cons_individual_addresses (
    aml_process_id VARCHAR(35) NOT NULL,
    dataid BIGINT,
    street VARCHAR(255) DEFAULT '',
    city VARCHAR(100) DEFAULT '',
    state_province VARCHAR(100) DEFAULT '',
    zip_code VARCHAR(50) DEFAULT '',
    country VARCHAR(100) DEFAULT '',
    note TEXT,
    PRIMARY KEY(aml_process_id, dataid)
);
DROP TABLE IF EXISTS aml_un_cons_individual_dates_of_birth;
CREATE TABLE aml_un_cons_individual_dates_of_birth (
    aml_process_id VARCHAR(35) NOT NULL,
    dataid BIGINT,
    type_of_date VARCHAR(50) DEFAULT '',
    birth_year INT,
    birth_date DATE,
    note TEXT,
    PRIMARY KEY(aml_process_id, dataid)
);
DROP TABLE IF EXISTS aml_un_cons_individual_places_of_birth;
CREATE TABLE aml_un_cons_individual_places_of_birth (
    aml_process_id VARCHAR(35) NOT NULL,
    dataid BIGINT,
    city VARCHAR(100) DEFAULT '',
    state_province VARCHAR(100) DEFAULT '',
    country VARCHAR(100) DEFAULT '',
    PRIMARY KEY(aml_process_id, dataid)
);
DROP TABLE IF EXISTS aml_un_cons_individual_documents;
CREATE TABLE aml_un_cons_individual_documents (
    aml_process_id VARCHAR(35) NOT NULL,
    dataid BIGINT,
    type_of_document VARCHAR(100) DEFAULT '',
    type_of_document2 VARCHAR(100) DEFAULT '',
    number VARCHAR(100) DEFAULT '',
    issuing_country VARCHAR(100) DEFAULT '',
    date_of_issue DATE,
    date_of_expiry DATE,
    city_of_issue VARCHAR(100) DEFAULT '',
    country_of_issue VARCHAR(100) DEFAULT '',
    note TEXT,
    PRIMARY KEY(aml_process_id, dataid)
);
DROP TABLE IF EXISTS aml_un_cons_individual_nationalities;
CREATE TABLE aml_un_cons_individual_nationalities (
    aml_process_id VARCHAR(35) NOT NULL,
    dataid BIGINT,
    nationality VARCHAR(150),
    PRIMARY KEY(aml_process_id, dataid)
);
DROP TABLE IF EXISTS aml_un_cons_individual_designations;
CREATE TABLE aml_un_cons_individual_designations (
    aml_process_id VARCHAR(35) NOT NULL,
    dataid BIGINT,
    designation TEXT,
    PRIMARY KEY(aml_process_id, dataid)
);
DROP TABLE IF EXISTS aml_un_cons_individual_titles;
CREATE TABLE aml_un_cons_individual_titles (
    aml_process_id VARCHAR(35) NOT NULL,
    dataid BIGINT,
    title VARCHAR(150),
    PRIMARY KEY(aml_process_id, dataid)
);
DROP TABLE IF EXISTS aml_un_cons_individual_last_day_updated;
CREATE TABLE aml_un_cons_individual_last_day_updated (
    aml_process_id VARCHAR(35) NOT NULL,
    dataid BIGINT,
    updated_date DATE,
    PRIMARY KEY(aml_process_id, dataid)
);
DROP TABLE IF EXISTS aml_un_cons_entities;
CREATE TABLE aml_un_cons_entities (
    aml_process_id VARCHAR(35) NOT NULL,
    dataid BIGINT,
    versionnum INT,
    first_name VARCHAR(255) NOT NULL,
    un_list_type VARCHAR(100) DEFAULT '',
    reference_number VARCHAR(50) DEFAULT '',
    listed_on DATE,
    comments1 TEXT,
    has_interpol_link VARCHAR(3),
    interpol_link TEXT,
    list_type VARCHAR(100) DEFAULT '',
    name_original_script TEXT,
    PRIMARY KEY(aml_process_id, dataid)
);
DROP TABLE IF EXISTS aml_un_cons_entity_aliases;
CREATE TABLE aml_un_cons_entity_aliases (
    aml_process_id VARCHAR(35) NOT NULL,
    dataid BIGINT,
    quality VARCHAR(50) DEFAULT '',
    alias_name VARCHAR(255) NOT NULL,
    PRIMARY KEY(aml_process_id, dataid)
);
DROP TABLE IF EXISTS aml_un_cons_entity_addresses;
CREATE TABLE aml_un_cons_entity_addresses (
    aml_process_id VARCHAR(35) NOT NULL,
    dataid BIGINT,
    street VARCHAR(255) DEFAULT '',
    city VARCHAR(100) DEFAULT '',
    state_province VARCHAR(100) DEFAULT '',
    zip_code VARCHAR(50) DEFAULT '',
    country VARCHAR(100) DEFAULT '',
    note TEXT,
    PRIMARY KEY(aml_process_id, dataid)
);
DROP TABLE IF EXISTS aml_un_cons_entity_last_day_updated;
CREATE TABLE aml_un_cons_entity_last_day_updated (
    aml_process_id VARCHAR(35) NOT NULL,
    dataid BIGINT,
    updated_date DATE,
    PRIMARY KEY(aml_process_id, dataid)
);










DROP TABLE IF EXISTS aml_oversea_end_points;
CREATE TABLE aml_oversea_end_points (
    aml_oversea_end_point_id VARCHAR(35) NOT NULL PRIMARY KEY,
    short_name VARCHAR(35),
    full_name VARCHAR(150),
    end_point VARCHAR(250),
    enable_status VARCHAR(1) DEFAULT 'Y'
);
INSERT INTO aml_oversea_end_points VALUES
	('AML.OVERSEA.001', 'UN', 'United Nation', 'https://scsanctions.un.org/resources/xml/en/consolidated.xml', 'Y'),
	('AML.OVERSEA.002', 'OFAC-SDN', 'Office of Foreign Assets Control - SND', 'https://www.treasury.gov/ofac/downloads/consolidated/consolidated.xml', 'Y'),
	('AML.OVERSEA.003', 'OFAC-Consolidated', 'Office of Foreign Assets Control - Consolidated', 'https://www.treasury.gov/ofac/downloads/consolidated/consolidated.xml', 'Y'),
	('AML.OVERSEA.004', 'EU', 'European Union', 'https://webgate.ec.europa.eu/europeaid/fsd/fsf/public/files/xmlFullSanctionsList_1_1/content?token=n002pc6m', 'Y');

DROP TABLE IF EXISTS aml_oversea_extract;
CREATE TABLE aml_oversea_extract (
    aml_process_id VARCHAR(35) NOT NULL,
    aml_oversea_end_point_id VARCHAR(35) NOT NULL,
    load_date_start VARCHAR(35) NOT NULL,
    load_date_end VARCHAR(35) NOT NULL,
    extract_date_start VARCHAR(35) NOT NULL,
    extract_date_end VARCHAR(35) NOT NULL,
    process_status VARCHAR(15) NOT NULL, -- -- comment 'Blank, Completed, Downloading, Extracting',
    narrative VARCHAR(250) NOT NULL,
    PRIMARY KEY(aml_process_id, aml_oversea_end_point_id)
);
-- INSERT INTO aml_oversea_extract VALUES
-- 	('AML_PROCESS.260010001', 'AML.OVERSEA.001', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Completed', ''),
-- 	('AML_PROCESS.260010001', 'AML.OVERSEA.002', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Completed', ''),
-- 	('AML_PROCESS.260010001', 'AML.OVERSEA.003', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Completed', ''),
-- 	('AML_PROCESS.260010001', 'AML.OVERSEA.004', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Completed', '');

DROP TABLE IF EXISTS aml_oversea_download_files;
CREATE TABLE aml_oversea_download_files (
    aml_process_id VARCHAR(35) NOT NULL,
    aml_oversea_end_point_id VARCHAR(35) NOT NULL,
    file_contents XML,
    PRIMARY KEY(aml_process_id, aml_oversea_end_point_id)
);
-- INSERT INTO aml_oversea_download_files VALUES
-- 	('AML.PROCESS.260010001', 'AML.OVERSEA.001', ''),
-- 	('AML.PROCESS.260010001', 'AML.OVERSEA.002', ''),
-- 	('AML.PROCESS.260010001', 'AML.OVERSEA.003', ''),
-- 	('AML.PROCESS.260010001', 'AML.OVERSEA.004', '');



DROP VIEW IF EXISTS vw_aml_sanctions;

CREATE OR REPLACE VIEW vw_aml_sanctions AS
SELECT 
	aml_res.short_name,
	'Consumer' AS customer_type,
    COALESCE(indv.dataid, '') AS dataid,
    COALESCE(indv.first_name, '') AS first_name,
    COALESCE(indv.second_name, '') AS second_name,
	'' AS name_original_script,
    COALESCE(indv.un_list_type, '') AS un_list_type,
    COALESCE(indv.reference_number, '') AS reference_number,
    COALESCE(indv.listed_on, '') AS listed_on,
    COALESCE(indv.gender, '') AS gender,
    COALESCE(indv.comments1, '') AS comments1,
    COALESCE(indv.has_interpol_link, '') AS has_interpol_link,
    COALESCE(indv.interpol_link, '') AS interpol_link
FROM aml_oversea_end_points AS aml_res
	JOIN aml_oversea_download_files t ON aml_res.aml_oversea_end_point_id = t.aml_oversea_end_point_id,
XMLTABLE(
    '//INDIVIDUAL'
    PASSING t.file_contents
    COLUMNS 
        xml_node XML PATH '.',
        dataid TEXT PATH 'DATAID',
        first_name TEXT PATH 'FIRST_NAME',
        second_name TEXT PATH 'SECOND_NAME',
        un_list_type TEXT PATH 'UN_LIST_TYPE',
        reference_number TEXT PATH 'REFERENCE_NUMBER',
        listed_on TEXT PATH 'LISTED_ON',
        gender TEXT PATH 'GENDER',
        comments1 TEXT PATH 'COMMENTS1',
        has_interpol_link TEXT PATH 'HAS_INTERPOL_LINK',
        interpol_link TEXT PATH 'INTERPOL_LINK'
) indv
UNION ALL
SELECT 
	aml_res.short_name,
    'Commercial' AS customer_type,
    COALESCE(enty.dataid, '') AS dataid,
    COALESCE(enty.first_name, '') AS first_name,
    '' AS second_name,
    COALESCE(enty.name_original_script, '') AS name_original_script,
    COALESCE(enty.un_list_type, '') AS un_list_type,
    COALESCE(enty.reference_number, '') AS reference_number,
    COALESCE(enty.listed_on, '') AS listed_on,
    COALESCE(enty.gender, '') AS gender,
    COALESCE(enty.comments1, '') AS comments1,
    COALESCE(enty.has_interpol_link, '') AS has_interpol_link,
    COALESCE(enty.interpol_link, '') AS interpol_link
FROM aml_oversea_end_points AS aml_res
	JOIN aml_oversea_download_files t ON aml_res.aml_oversea_end_point_id = t.aml_oversea_end_point_id,
XMLTABLE(
    '//ENTITY'
    PASSING t.file_contents
    COLUMNS 
        xml_node XML PATH '.',
        dataid TEXT PATH 'DATAID',
        first_name TEXT PATH 'FIRST_NAME',
        name_original_script TEXT PATH 'NAME_ORIGINAL_SCRIPT',
        un_list_type TEXT PATH 'UN_LIST_TYPE',
        reference_number TEXT PATH 'REFERENCE_NUMBER',
        listed_on TEXT PATH 'LISTED_ON',
        gender TEXT PATH 'GENDER',
        comments1 TEXT PATH 'COMMENTS1',
        has_interpol_link TEXT PATH 'HAS_INTERPOL_LINK',
        interpol_link TEXT PATH 'INTERPOL_LINK'
) enty;


SELECT * FROM vw_aml_sanctions;





