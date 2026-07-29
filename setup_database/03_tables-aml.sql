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






DROP PROCEDURE IF EXISTS sp_import_aml_individuals;
CREATE OR REPLACE PROCEDURE sp_import_aml_individuals(
    p_aml_process_id VARCHAR(35),
    p_xml_data XML
)
LANGUAGE plpgsql
AS $$
BEGIN

    -- 1. Insert into main Individuals table
    INSERT INTO aml_un_cons_individuals (
        aml_process_id, dataid, versionnum, first_name, second_name, third_name, fourth_name,
        un_list_type, reference_number, listed_on, gender, comments1, has_interpol_link, 
        interpol_link, name_original_script
    )
    SELECT 
        p_aml_process_id,
        NULLIF(x.dataid, '')::BIGINT,
        NULLIF(x.versionnum, '')::INT,
        x.first_name,
        x.second_name,
        x.third_name,
        x.fourth_name,
        x.un_list_type,
        x.reference_number,
        NULLIF(x.listed_on, '')::DATE,
        x.gender,
        x.comments1,
        x.has_interpol_link,
        x.interpol_link,
        x.name_original_script
    FROM XMLTABLE(
        '//INDIVIDUAL'
        PASSING p_xml_data
        COLUMNS 
            dataid VARCHAR(50) PATH 'DATAID',
            versionnum VARCHAR(20) PATH 'VERSIONNUM',
            first_name VARCHAR(255) PATH 'FIRST_NAME',
            second_name VARCHAR(255) PATH 'SECOND_NAME',
            third_name VARCHAR(255) PATH 'THIRD_NAME',
            fourth_name VARCHAR(255) PATH 'FOURTH_NAME',
            un_list_type VARCHAR(100) PATH 'UN_LIST_TYPE',
            reference_number VARCHAR(50) PATH 'REFERENCE_NUMBER',
            listed_on VARCHAR(50) PATH 'LISTED_ON',
            gender VARCHAR(50) PATH 'GENDER',
            comments1 TEXT PATH 'COMMENTS1',
            has_interpol_link VARCHAR(3) PATH 'HAS_INTERPOL_LINK',
            interpol_link TEXT PATH 'INTERPOL_LINK',
            name_original_script TEXT PATH 'NAME_ORIGINAL_SCRIPT'
    ) x
    ON CONFLICT (aml_process_id, dataid) DO NOTHING;

    -- 2. Insert into Individual Aliases table
    INSERT INTO aml_un_cons_individual_aliases (aml_process_id, dataid, quality, alias_name)
	SELECT 
	    p_aml_process_id,
	    NULLIF(parent.dataid, '')::BIGINT,
	    alias.quality,
	    alias.alias_name
	FROM XMLTABLE(
	    '//INDIVIDUAL'
	    PASSING p_xml_data
	    COLUMNS 
	        dataid VARCHAR(50) PATH 'DATAID',
	        aliases XML PATH 'INDIVIDUAL_ALIAS'
	) parent,
	XMLTABLE(
	    '//INDIVIDUAL_ALIAS'
	    PASSING p_xml_data
	    COLUMNS 
	        quality VARCHAR(50) PATH 'QUALITY',
	        alias_name VARCHAR(255) PATH 'ALIAS_NAME'
	) alias
    WHERE alias.alias_name IS NOT NULL AND alias.alias_name <> ''
    ON CONFLICT (aml_process_id, dataid) DO NOTHING;

    -- 3. Insert into Individual Addresses table
    INSERT INTO aml_un_cons_individual_addresses (aml_process_id, dataid, street, city, state_province, zip_code, country, note)
	SELECT 
	    p_aml_process_id,
	    NULLIF(ind.dataid, '')::BIGINT,
	    addr.street,
	    addr.city,
	    addr.state_province,
	    addr.zip_code,
	    addr.country,
	    addr.note
	FROM XMLTABLE(
	    '//INDIVIDUAL'
	    PASSING p_xml_data
	    COLUMNS 
	        dataid VARCHAR(50) PATH 'DATAID',
	        ind_node XML PATH '.'
	) ind,
	XMLTABLE(
	    '//INDIVIDUAL_ADDRESS'
	    PASSING ind.ind_node
	    COLUMNS 
	        street VARCHAR(255) PATH 'STREET',
	        city VARCHAR(100) PATH 'CITY',
	        state_province VARCHAR(100) PATH 'STATE_PROVINCE',
	        zip_code VARCHAR(50) PATH 'ZIP_CODE',
	        country VARCHAR(100) PATH 'COUNTRY',
	        note TEXT PATH 'NOTE'
	) addr
	ON CONFLICT (aml_process_id, dataid) DO NOTHING;

END;
$$;

