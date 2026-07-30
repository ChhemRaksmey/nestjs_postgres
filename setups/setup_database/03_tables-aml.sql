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





