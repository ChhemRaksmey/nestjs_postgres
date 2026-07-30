SET SQL_SAFE_UPDATES = 0;
USE db_core_system;




DROP FUNCTION IF EXISTS fs_fmt_date;
DELIMITER $$
CREATE FUNCTION fs_fmt_date(
    p_date VARCHAR(35),
    p_fmt VARCHAR(35)
)
RETURNS VARCHAR(35) DETERMINISTIC
BEGIN
    DECLARE v_parsed_date DATETIME;

    IF p_date IS NULL OR TRIM(p_date) = '' THEN
        RETURN NULL;
    END IF;

    SET v_parsed_date = CASE

        -- Format: '202607291839' (12 digits)
        WHEN p_date REGEXP '^[0-9]{12}$'
            THEN STR_TO_DATE(p_date, '%Y%m%d%H%i')
             
        -- Format: '20260729' (8 digits)
        WHEN p_date REGEXP '^[0-9]{8}$'
            THEN STR_TO_DATE(p_date, '%Y%m%d')

        -- Format: '2026-07-29'
        WHEN p_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
            THEN STR_TO_DATE(p_date, '%Y-%m-%d')

        -- Format: '2026-07' (Append '-01' so it becomes a valid parseable date)
        WHEN p_date REGEXP '^[0-9]{4}-[0-9]{2}$'
            THEN STR_TO_DATE(CONCAT(p_date, '-01'), '%Y-%m-%d')

        -- Format: '2026' (Append '-01-01' for year-only inputs)
        WHEN p_date REGEXP '^[0-9]{4}$'
            THEN STR_TO_DATE(CONCAT(p_date, '-01-01'), '%Y-%m-%d')

        -- Format: '2026 July 29'
        WHEN p_date REGEXP '^[0-9]{4} [A-Za-z]+ [0-9]{1,2}$'
            THEN STR_TO_DATE(p_date, '%Y %M %d')

        -- Format: 'July 29 2026'
        WHEN p_date REGEXP '^[A-Za-z]+ [0-9]{1,2},? [0-9]{4}$'
            THEN STR_TO_DATE(p_date, '%M %d %Y')
        
        -- Format: 'July 2026'
        WHEN p_date REGEXP '^[A-Za-z]+ [0-9]{4}$'
            THEN STR_TO_DATE(p_date, '%M %Y')
        
        -- Format: '2026 July'
        WHEN p_date REGEXP '^[0-9]{4}$ [A-Za-z]+'
            THEN STR_TO_DATE(p_date, '%Y %M')

        ELSE CAST(p_date AS DATETIME)

    END;

    IF v_parsed_date IS NULL THEN
        RETURN NULL;
    END IF;

    RETURN DATE_FORMAT(v_parsed_date, p_fmt);
END $$
DELIMITER ;

-- SELECT
--     fs_fmt_date('202607291839', '%Y-%m-%d %H:%i') AS str_datetime,
--     fs_fmt_date('20260729', '%Y-%m-%d') AS str_yyyymmdd,
--     fs_fmt_date('2026-07-29', '%Y-%m-%d') AS str_yyyymmdd_hyphen,
--     fs_fmt_date('2026-07', '%Y-%m') AS str_yyyymm,
--     fs_fmt_date('2026', '%Y') AS str_yyyy,
--     fs_fmt_date('2026 July 29', '%Y-%m-%d') AS str_date_to_date1,
--     fs_fmt_date('July 29 2026', '%Y-%m-%d') AS str_date_to_date2;




DROP FUNCTION IF EXISTS fs_aml_similar_name;
DELIMITER $$
CREATE FUNCTION fs_aml_similar_name(
    p_name1 TEXT,
    p_name2 TEXT
) RETURNS DECIMAL(5, 2) DETERMINISTIC
BEGIN
    DECLARE v_name1, v_name2, v_name3 TEXT;
    DECLARE v_len1, v_len2, v_max_len INT;
    DECLARE v_match_count INT DEFAULT 0;
    DECLARE v_i INT DEFAULT 1;
    DECLARE v_similar DECIMAL(12, 2) DEFAULT 0.00;

    SET v_name1 = LOWER(REGEXP_REPLACE(p_name1, '[^a-zA-Z0-9]', ''));
    SET v_name2 = LOWER(REGEXP_REPLACE(p_name2, '[^a-zA-Z0-9]', ''));
    SET v_name3 = REVERSE(v_name2);

    IF p_name1 = '' OR p_name2 = '' THEN
        RETURN 100.00;
    END IF;

    SET v_len1 = CHAR_LENGTH(v_name1);
    SET v_len2 = CHAR_LENGTH(v_name2);
    SET v_max_len = GREATEST(v_len1, v_len2);

    WHILE v_i <= v_len1 - 1 DO
    
        IF LOCATE(SUBSTRING(v_name1, v_i, 2), v_name2) > 0 THEN
            SET v_match_count = v_match_count + 1;
        END IF;
        
        IF LOCATE(SUBSTRING(v_name1, v_i, 2), v_name3) > 0 THEN
            SET v_match_count = v_match_count + 1;
        END IF;
        
        SET v_i = v_i + 1;
    END WHILE;
    
    SET v_similar = ROUND((v_match_count / v_max_len) * 100, 2);

    RETURN IF(v_similar >= 100.00, 100.00, v_similar);
END $$
DELIMITER ;

SELECT
	customer_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    -- legal_holder_name,
    'Chhem Raksmey' AS sansaction_name,
    fs_aml_similar_name('Chhem Raksmey', CONCAT(first_name, last_name)) AS check_similar
FROM vw_customer
WHERE customer_id LIKE '10%'
HAVING check_similar >= 60.00
ORDER BY check_similar
LIMIT 100;







DROP VIEW IF EXISTS vw_company_branch;
CREATE OR REPLACE VIEW vw_company_branch AS SELECT RECID AS branch_id, CODE AS branch_no, SHORT_NAME AS short_name, FULL_NAME AS full_name FROM db_dp_ods.f_company_branch ;

DROP VIEW IF EXISTS vw_user;
CREATE OR REPLACE VIEW vw_user AS
SELECT
	user_id,
    IF(Signonname IS NULL, '', Signonname) AS signon_name,
    user_name AS full_name,
    co_code AS branch_id,
    IF(Startdateprofile IS NULL, '', fs_fmt_date(Startdateprofile, '%Y-%m-%d')) AS date_start,
    IF(Enddateprofile IS NULL, '', fs_fmt_date(Enddateprofile, '%Y-%m-%d')) AS date_end
FROM db_dp_ods.f_user;

DROP VIEW IF EXISTS vw_cbc_addr_province;
CREATE OR REPLACE VIEW vw_cbc_addr_province AS SELECT LPAD(CODE, 2, 0) AS province_id, NAME_ENG AS full_name, NAME_KH AS full_name_kh FROM db_dp_ods.cbc_province;

DROP VIEW IF EXISTS vw_cbc_addr_district;
CREATE OR REPLACE VIEW vw_cbc_addr_district AS SELECT LPAD(CODE, 4, 0) AS district_id, NAME_ENG AS full_name, NAME_KH AS full_name_kh FROM db_dp_ods.cbc_district;

DROP VIEW IF EXISTS vw_cbc_addr_commune;
CREATE OR REPLACE VIEW vw_cbc_addr_commune AS SELECT LPAD(CODE, 6, 0) AS commune_id, NAME_ENG AS full_name, NAME_KH AS full_name_kh FROM db_dp_ods.cbc_commune;

DROP VIEW IF EXISTS vw_cbc_addr_village;
CREATE OR REPLACE VIEW vw_cbc_addr_village AS SELECT LPAD(CODE, 8, 0) AS village_id, NAME_ENG AS full_name, NAME_KH AS full_name_kh FROM db_dp_ods.cbc_village;

DROP VIEW IF EXISTS vw_customer ;
CREATE OR REPLACE VIEW vw_customer AS
SELECT
    IF(title = 'NULL' OR title = '', 'Consumer', 'Commercial') AS customer_type,
	customer_id,
    IF(title = 'NULL', '',
		CASE title
			WHEN 'MRS' THEN 'Mrs'
			WHEN 'MR' THEN 'Mr'
			WHEN 'MISS' THEN 'Miss'
			WHEN 'MS' THEN 'Ms'
			WHEN 'DR' THEN 'Dr'
            ELSE title
        END
    ) AS title,
    IF(first_name = 'NULL', '', first_name) AS first_name,
    IF(last_name = 'NULL', '', last_name) AS last_name,
    IF(first_name_kh = 'NULL', '', first_name_kh) AS first_name_kh,
    IF(last_name_kh = 'NULL', '', last_name_kh) AS last_name_kh,
    IF(gender = 'NULL', '',
		CASE gender
			WHEN 'MALE' THEN 'Male'
            WHEN 'FEMALE' THEN 'Female'
            ELSE gender
        END
    ) AS gender,
    IF(dateofbirth = 'NULL', '', fs_fmt_date(dateofbirth, '%Y-%m-%d')) AS dateofbirth,
    IF(birth_province = 'NULL', '', birth_province) AS birth_province,
    IF(birth_city = 'NULL', '', birth_city) AS birth_city,
    IF(birth_country = 'NULL', '', birth_country) AS birth_country,
    IF(phone_number = 'NULL', '', phone_number) AS phone_number,
    IF(marital_status = 'NULL', '',
		CASE marital_status
			WHEN 'MARRIED' THEN 'Married'
            WHEN 'SINGLE' THEN 'Signle'
            WHEN 'WIDOWED' THEN 'Window'
            WHEN 'DIVORCED' THEN 'Divorced'
            ELSE marital_status
        END
    ) AS marital_status,
    IF(village_code = 'NULL', '', LPAD(village_code, 8, 0)) AS village_code,
    IF(address_street = 'NULL', '', address_street) AS address_street,
    IF(nationality = 'NULL', '', nationality) AS nationality,
    IF(legal_id = 'NULL', '', legal_id) AS legal_id,
    IF(legal_doc_name = 'NULL', '',
		CASE legal_doc_name
            WHEN 'NATIONAL.ID' THEN 'Nationality Identification Card'
			WHEN 'OTH' THEN 'Other'
			WHEN 'PASSPORT' THEN 'Passport'
			WHEN 'BIRTH.CERTIFI' THEN 'Birth Certificate'
			WHEN 'FAMILY.BOOK' THEN 'Family Book'
			WHEN 'LEI' THEN 'Legal Entity Identifier'
			WHEN 'EMP.ID' THEN 'Employee Identification Card'
			WHEN 'RESI.BOOK' THEN 'Residence Book'
            ELSE legal_holder_name
		END
    ) AS legal_doc_name,
    IF(legal_holder_name = 'NULL', '', legal_holder_name) AS legal_holder_name,
    IF(legal_issue_date = 'NULL', '', fs_fmt_date(legal_issue_date, '%Y-%m-%d')) AS legal_issue_date,
    IF(legal_expire_date = 'NULL', '', fs_fmt_date(legal_expire_date, '%Y-%m-%d')) AS legal_expire_date,
    IF(legal_issue_authority = 'NULL', '', legal_issue_authority) AS legal_issue_authority,
    IF(occupation = 'NULL', '', occupation) AS occupation,
    IF(income_currency = 'NULL', '', income_currency) AS income_currency,
    IF(income_net_monthly = 'NULL', '', income_net_monthly) AS income_net_monthly,
    IF(service_in_month = 'NULL', '', service_in_month) AS service_in_month,
    IF(residence = 'NULL', '', residence) AS residence,
    IF(dptype = 'NULL', '', dptype) AS dptype,
    IF(dpsettaccno = 'NULL', '', dpsettaccno) AS dpsettaccno,
    IF(dpremark = 'NULL', '', dpremark) AS dpremark,
    company_book AS branch_code,
    fs_fmt_date(dateTime, '%Y-%m-%d %H:%i') AS date_time,
    SUBSTRING_INDEX(SUBSTRING_INDEX(inputter, '_', 2), '_', -1) AS inputter,
    SUBSTRING_INDEX(SUBSTRING_INDEX(authoriser, '_', 2), '_', -1) AS authoriser
FROM db_dp_ods.fbnk_customer
ORDER BY title;

DROP VIEW IF EXISTS vw_arrangement ;
CREATE OR REPLACE VIEW vw_arrangement AS
SELECT
	'Account' AS arrangement_group,
	aa_id AS arrangement_id,
    account_id,
    legacy_account_id,
    CASE product_name
        WHEN 'SAVINGS.ACCOUNT.IND' THEN 'Saving Account Individaul'
        WHEN 'DP.STAFF.ACCOUNT' THEN 'Daun Penh Staff Account'
        WHEN 'SAVINGS.ACCOUNT.CORP' THEN 'Saving Account Corporate'
        ELSE product_name
    END AS product_name,
    currency,
    fs_fmt_date(open_date, '%Y-%m-%d') AS open_date
FROM db_dp_ods.fbnk_account
UNION
SELECT
	'Loan' AS arrangement_group,
	loan_id,
    loan_acct_id,
    legacy_id,
    CASE aa_product_id
        WHEN 'STAFF.LOAN' THEN 'Staff Loan'
        WHEN 'HOME.IMPROVE.LOAN' THEN 'Home Improve Loan'
        WHEN 'STAFF.HOUSING.LOAN' THEN 'Staff Housing Loan'
        WHEN 'HOUSING.LOAN' THEN 'Housing Loan'
        WHEN 'AUTO.LOAN' THEN 'Auto Loan'
        WHEN 'MOTOR.LOAN' THEN 'Motor Loan'
        WHEN 'MOTOR.LOAN MOTOR.LOAN.ST' THEN 'Motor Loan'
        WHEN 'MOTOR.LOAN.ST' THEN 'Motor Loan'
        WHEN 'MOTOR.LOAN.ST MOTOR.LOAN' THEN 'Motor Loan'
        WHEN 'MICRO.BUSINESS.LOAN.ST' THEN 'Micro Business Loan'
        WHEN 'MICRO.BUSINESS.LOAN' THEN 'Micro Bussiness Loan'
        ELSE aa_product_id
    END AS product_name,
    currency,
    fs_fmt_date(open_date, '%Y-%m-%d') AS open_date
FROM db_dp_ods.fbnk_aaloan;

DROP VIEW IF EXISTS vw_arrangement_balance ;
CREATE OR REPLACE VIEW vw_arrangement_balance AS
SELECT
	SUBSTRING_INDEX(system_id, '.', -1) AS arrangement_id,
    fs_fmt_date(SUBSTRING_INDEX(system_id, '.', 1), '%Y-%m-%d') AS balance_date,
    ROUND(balance_amount, 2) AS balance_amount,
    IF(status IS NULL, 'Active',
		CASE LOWER(status)
			WHEN 'active' THEN 'Active'
			WHEN 'dormant' THEN 'Dormant'
			ELSE status
		END
	) AS account_status
FROM db_dp_ods.fbnk_account_balances;

DROP VIEW IF EXISTS vw_arrangement_joiners ;
CREATE OR REPLACE VIEW vw_arrangement_joiners AS
SELECT arrangement_id, account_id, legacy_account_id, customer_id, customer_role
FROM db_core_system.vw_arrangement AS arr JOIN db_dp_ods.fbnk_aaloan_customer_join AS arrj ON arr.arrangement_id = arrj.loan_id;

DROP VIEW IF EXISTS vw_limit_global ;
CREATE OR REPLACE VIEW vw_limit_global AS
SELECT limit_id, customer_id FROM db_dp_ods.f_limit WHERE limitproudct = '1GLOBALLREV1';

DROP VIEW IF EXISTS vw_limit_parent ;
CREATE OR REPLACE VIEW vw_limit_parent AS
SELECT
	lmt.parentid AS limit_global,
	lmt.limit_id AS limit_parent,
    lmt.customer_id, lmt.limitproudct, lmt.currency
FROM db_core_system.vw_limit_global AS lmtg JOIN db_dp_ods.f_limit AS lmt ON lmtg.limit_id = lmt.parentid;

DROP VIEW IF EXISTS vw_limit_child ;
CREATE OR REPLACE VIEW vw_limit_child AS
SELECT
	lmtp.limit_global,
	lmtp.limit_parent,
	lmt.limit_id AS limit_child,
    lmt.customer_id,
	lmt.currency,
	lmt.ltv,
	lmt.intamount,
	fs_fmt_date(lmt.expirydate, '%Y-%m-%d') AS expirydate,
	fs_fmt_date(lmt.approvaldate, '%Y-%m-%d') AS approvaldate,
	lmt.maximumsecured,
	lmt.maximumtotal
FROM db_core_system.vw_limit_parent AS lmtp JOIN db_dp_ods.f_limit AS lmt ON lmtp.limit_parent = lmt.parentid;

DROP VIEW IF EXISTS vw_collateral_link;
CREATE OR REPLACE VIEW vw_collateral_link AS 
SELECT DISTINCT customer_id, limit_id AS limit_child_id, collateral_right_id AS collat_link_id FROM db_dp_ods.f_collateral_right;

DROP VIEW IF EXISTS vw_collaterals;
CREATE OR REPLACE VIEW vw_collaterals AS 
SELECT
	customer_id,
    collateral_right_id, collateral_id,
    collateral_type, asset_id,
    country, company AS businessunit,
    currency, nominal_value, execution_value,
    IF(value_date = '', '', fs_fmt_date(value_date, '%Y-%m-%d')) AS value_date,
    IF(expiry_date = '', '', fs_fmt_date(expiry_date, '%Y-%m-%d')) AS expiry_date,
    co_code AS branch_code,
    fs_fmt_date(date_time, '%Y-%m-%d %H:%i') AS date_time,
    SUBSTRING_INDEX(SUBSTRING_INDEX(inputter, '_', 2), '_', -1) AS inputter,
    SUBSTRING_INDEX(SUBSTRING_INDEX(authoriser, '_', 2), '_', -1) AS authoriser
FROM db_dp_ods.f_collaterals;

DROP VIEW IF EXISTS vw_arrangement_limit ;
CREATE OR REPLACE VIEW vw_arrangement_limit AS
SELECT loan_id, limit_id FROM db_dp_ods.fbnk_aaloan_limit WHERE limit_id <> '';

DROP VIEW IF EXISTS vw_transaction_code;
CREATE OR REPLACE VIEW vw_transaction_code AS
SELECT DISTINCT 'Cash' AS module_type, transaction_code, trans_desc FROM db_dp_ods.fbnk_teller_dets
UNION SELECT 'Transfer' AS module_type,  'AC' AS transaction_code, 'Account Transfer' AS trans_desc
UNION SELECT 'Transfer' AS module_type,  'ACRP' AS transaction_code, 'Account Transfer Loan Repayment' AS trans_desc
UNION SELECT 'Transfer' AS module_type,  'ACPD' AS transaction_code, 'Account Transfer Loan Principal Decrease' AS trans_desc
UNION SELECT 'Transfer' AS module_type,  'ACPO' AS transaction_code, 'Account Transfer Loan Payoff' AS trans_desc
UNION SELECT 'Transfer' AS module_type,  'ACDI' AS transaction_code, 'Account Transfer Loan Disburse' AS trans_desc
UNION SELECT 'Transfer' AS module_type,  'ACPX' AS transaction_code, 'Account Transfer Bath Upload' AS trans_desc;

DROP VIEW IF EXISTS vw_transaction_cash ;
CREATE OR REPLACE VIEW vw_transaction_cash AS
SELECT
    fs_fmt_date(date_time, '%Y-%m-%d %H:%i') AS date_time,
	fs_fmt_date(auth_date, '%Y-%m-%d') AS date_auth,
	SUBSTRING_INDEX(main_deal, ';', 1) AS transaction_id,
	IF(record_status = 'REVE', 'REVE', '') AS record_status,
	transaction_code,
	trans_desc,
	dr_cr_marker,
	teller_id_1,
	currency_1 AS internal_acct_ccy,
	account_1 AS internal_acct_id,
	ROUND(amount_fcy_1, 2) AS internal_amt_fcy,
	ROUND(amount_local_1, 2) AS internal_amt_lcy,
	teller_id_2,
	currency_2 AS customer_acct_ccy,
	customer_2 AS customer_id,
	account_2 AS customer_acct_id,
	ROUND(amount_fcy_2, 2) AS customer_amt_fcy,
	ROUND(amount_local_2, 2) AS customer_amt_lcy,
	ROUND(IF(deal_rate = '', 1, deal_rate), 2) AS exchange_rate,
	narrative_1 AS internal_narrative,
	narrative_2	AS customer_narrative,
	their_reference,
	our_reference,
    waive_charges,
	SUBSTRING_INDEX(SUBSTRING_INDEX(inputter, '_', 2), '_', -1) AS inputter,
	SUBSTRING_INDEX(SUBSTRING_INDEX(authoriser, '_', 2), '_', -1) AS authoriser,
	co_code AS branch_code
FROM db_dp_ods.fbnk_teller_dets;

DROP VIEW IF EXISTS vw_transaction_transfer ;
CREATE OR REPLACE VIEW vw_transaction_transfer AS
SELECT
    fs_fmt_date(`DATE.TIME`, '%Y-%m-%d %H:%i') AS date_time,
	fs_fmt_date(`PROCESSING.DATE`, '%Y-%m-%d') AS date_auth,
	SUBSTRING_INDEX(`FT_RECID`, ';', 1) AS transaction_id,
	IF(`RECORD.STATUS` = 'REVE', 'REVE', '') AS record_status,
    `TRANSACTION.TYPE` AS transaction_code,
    `DEBIT.ACCT.NO` AS dr_acct_no,
    `DEBIT.CURRENCY` AS dr_ccy,
    `DEBIT.AMOUNT` AS dr_amt,
    fs_fmt_date(`DEBIT.VALUE.DATE`, '%Y-%m-%d') AS dr_value_date,
    `DEBIT.THEIR.REF` AS dr_their_ref,
    `CREDIT.ACCT.NO` AS cr_acct_no,
    `CREDIT.CURRENCY` AS cr_ccy,
    `CREDIT.AMOUNT` AS cr_amt,
    fs_fmt_date(`CREDIT.VALUE.DATE`, '%Y-%m-%d') AS cr_value_date,
    `CREDIT.THEIR.REF` AS cr_their_ref,
    IF(`TREASURY.RATE` = '', 1, `TREASURY.RATE`) AS exchange_rate,
    `ORDERING.CUST` AS ordering_customer,
    REPLACE(`AMOUNT.DEBITED`, `DEBIT.CURRENCY`, '') AS amt_debited,
    REPLACE(`AMOUNT.CREDITED`, `CREDIT.CURRENCY`, '') AS amt_credited,
    `LOC.AMT.DEBITED` AS amt_debited_lcy,
    `LOC.AMT.CREDITED` AS amt_credited_lcy,
    `DEBIT.CUSTOMER` AS debit_customer,
    `CREDIT.CUSTOMER` AS credit_customer,
    `CREDIT.COMP.CODE` AS create_branch,
    `DEBIT.COMP.CODE` AS debit_branch,
    `CO.CODE` AS branch_id,
    SUBSTRING_INDEX(SUBSTRING_INDEX(`INPUTTER`, '_', 2), '_', -1) AS inputter,
    SUBSTRING_INDEX(SUBSTRING_INDEX(`AUTHORISER`, '_', 2), '_', -1) AS authoriser
FROM db_dp_ods.fbnk_funds_transfer_det;

DROP VIEW IF EXISTS vw_transaction_data_capture;
CREATE OR REPLACE VIEW vw_transaction_data_capture AS
SELECT
    fs_fmt_date(date_time, '%Y-%m-%d %H:%i') AS date_time,
	fs_fmt_date(value_date, '%Y-%m-%d') AS date_auth,
	LEFT(SUBSTRING_INDEX(DC_RECID, ';', 1), LENGTH(SUBSTRING_INDEX(DC_RECID, ';', 1)) - 3) AS batch_id,
	SUBSTRING_INDEX(DC_RECID, ';', 1) AS transaction_id,
	IF(record_status = 'REVE', 'REVE', '') AS record_status,
    CASE sign
		WHEN 'D' THEN 'DEBIT'
        ELSE 'CREDIT'
    END AS dr_cr_marker,
    account_number,
    transaction_code,
    IF(currency = '', 'USD', currency) AS currency,
    ROUND(amount_lcy, 2) AS amount_lcy,
    ROUND(amount_fcy, 2) AS amount_fcy,
    ROUND(exchange_rate, 2) AS exchange_rate,
    their_reference,
    narrative,
    pl_category,
    customer_id,
    co_code AS branch_id,
    SUBSTRING_INDEX(SUBSTRING_INDEX(inputter, '_', 2), '_', -1) AS inputter,
    SUBSTRING_INDEX(SUBSTRING_INDEX(authoriser, '_', 2), '_', -1) AS authoriser
FROM db_dp_ods.fbnk_data_capture_dets;







SET @sansaction_name = 'Meng Socheata';
SET @sansaction_gender = '';
SET @sansaction_date_of_birth = '';
SET @sansaction_document_no = '010';
SET @sansaction_similar_percentage = 80.00;

WITH RECURSIVE
tmp_customer1 AS (
	SELECT
		customer_id, gender, dateofbirth,
		CONCAT(first_name, ' ', last_name) AS full_name,
		legal_holder_name, legal_id
	FROM vw_customer
	WHERE customer_id LIKE '1%'
		AND gender LIKE CONCAT(@sansaction_gender, '%')
		AND LOCATE(@sansaction_document_no, legal_id)
        AND (
			@sansaction_date_of_birth = ''
			OR fs_fmt_date(@sansaction_date_of_birth, '%Y') = fs_fmt_date(dateofbirth, '%Y')
		)
),
tmp_customer2 AS (
	SELECT
		customer_id, c.full_name, legal_id, dateofbirth, legal_holder_name,
		fs_aml_similar_name(@sansaction_name, c.full_name) AS check_full_name,
        IF(LOCATE(@sansaction_document_no, legal_id), 1, 0) AS check_document_no,
        IF(fs_fmt_date(@sansaction_date_of_birth, '%Y') = fs_fmt_date(c.dateofbirth, '%Y'), 1, 0) AS check_dateofbirth
	FROM tmp_customer1 AS c
	HAVING check_full_name >= @sansaction_similar_percentage
	ORDER BY check_full_name DESC, check_document_no DESC, check_dateofbirth DESC
)
SELECT * FROM tmp_customer2;









DROP TABLE IF EXISTS aml_scanning_role;
CREATE TABLE aml_scanning_role (
	batch_id VARCHAR(35) NOT NULL,
    scan_status VARCHAR(15) DEFAULT 'Running' Comment 'Running, Completed, Error',
    PRIMARY KEY(batch_id)
);
DROP TABLE IF EXISTS aml_scanning_roles;
CREATE TABLE aml_scanning_roles (
	batch_id VARCHAR(35) NOT NULL,
    date_time_start TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_time_end TIMESTAMP NULL,
    customer_id VARCHAR(15) NOT NULL,
    aml_0001 INT DEFAULT 0,
    aml_0002 INT DEFAULT 0,
    aml_0003 INT DEFAULT 0,
    aml_0004 INT DEFAULT 0,
    aml_0005 INT DEFAULT 0,
    aml_0006 INT DEFAULT 0,
    aml_0007 INT DEFAULT 0,
    aml_0008 INT DEFAULT 0,
    aml_0009 INT DEFAULT 0,
    aml_0010 INT DEFAULT 0,
    aml_0011 INT DEFAULT 0,
    aml_0012 INT DEFAULT 0,
    aml_0013 INT DEFAULT 0,
    aml_0014 INT DEFAULT 0,
    scan_status VARCHAR(15) DEFAULT 'Running' Comment 'Running, Completed, Error',
    scan_narrative TEXT,
    PRIMARY KEY(batch_id, customer_id)
);
DROP TABLE IF EXISTS aml_scanning_role_errors;
CREATE TABLE aml_scanning_role_errors (
	batch_id VARCHAR(35) NOT NULL,
    customer_id VARCHAR(15) NOT NULL,
    aml_0001 TEXT,
    aml_0002 TEXT,
    aml_0003 TEXT,
    aml_0004 TEXT,
    aml_0005 TEXT,
    aml_0006 TEXT,
    aml_0007 TEXT,
    aml_0008 TEXT,
    aml_0009 TEXT,
    aml_0010 TEXT,
    aml_0011 TEXT,
    aml_0012 TEXT,
    aml_0013 TEXT,
    aml_0014 TEXT,
    PRIMARY KEY(batch_id, customer_id)
);




DROP FUNCTION IF EXISTS fs_aml_consumer_0001;
DELIMITER $$
CREATE FUNCTION fs_aml_consumer_0001( p_customer_id VARCHAR(15), p_value_x DECIMAL(15, 2) ) RETURNS INT DETERMINISTIC
BEGIN

    DECLARE v_check DECIMAL(15, 2) DEFAULT 0.00;
    
    WITH RECURSIVE
    tmp_trn_cash AS (
        SELECT customer_id, transaction_id, record_status, customer_amt_lcy
        FROM vw_transaction_cash
        WHERE transaction_code IN (8, 14, 18) AND customer_id COLLATE utf8mb4_unicode_ci <= p_customer_id
    ),
    tmp_trn_cash_reve AS (
        SELECT DISTINCT transaction_id  FROM tmp_trn_cash WHERE record_status = 'REVE'
    ),
    tmp_trn AS (
        SELECT customer_id, SUM(customer_amt_lcy) AS total_amt FROM tmp_trn_cash
        WHERE transaction_id NOT IN (SELECT transaction_id FROM tmp_trn_cash_reve)
        GROUP BY customer_id
        HAVING total_amt >= p_value_x
        ORDER BY total_amt DESC
    )
    SELECT total_amt INTO v_check FROM tmp_trn  LIMIT 1;

    RETURN IF(v_check IS NOT NULL OR v_check >= p_value_x, 1, 0);
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS fs_aml_consumer_0002;
DELIMITER $$
CREATE FUNCTION fs_aml_consumer_0002( p_customer_id VARCHAR(15), p_value_x DECIMAL(15, 2) ) RETURNS INT DETERMINISTIC
BEGIN RETURN 1; END $$
DELIMITER ;

DROP FUNCTION IF EXISTS fs_aml_consumer_0003;
DELIMITER $$
CREATE FUNCTION fs_aml_consumer_0003( p_customer_id VARCHAR(15), p_value_x DECIMAL(15, 2) ) RETURNS INT DETERMINISTIC
BEGIN RETURN 1; END $$
DELIMITER ;

DROP FUNCTION IF EXISTS fs_aml_consumer_0004;
DELIMITER $$
CREATE FUNCTION fs_aml_consumer_0004( p_customer_id VARCHAR(15), p_value_x DECIMAL(15, 2) ) RETURNS INT DETERMINISTIC
BEGIN RETURN 1; END $$
DELIMITER ;

DROP FUNCTION IF EXISTS fs_aml_consumer_0005;
DELIMITER $$
CREATE FUNCTION fs_aml_consumer_0005( p_customer_id VARCHAR(15), p_value_x DECIMAL(15, 2) ) RETURNS INT DETERMINISTIC
BEGIN RETURN 1; END $$
DELIMITER ;

DROP FUNCTION IF EXISTS fs_aml_consumer_0006;
DELIMITER $$
CREATE FUNCTION fs_aml_consumer_0006( p_customer_id VARCHAR(15), p_value_x DECIMAL(15, 2) ) RETURNS INT DETERMINISTIC
BEGIN RETURN 1; END $$
DELIMITER ;

DROP FUNCTION IF EXISTS fs_aml_consumer_0007;
DELIMITER $$
CREATE FUNCTION fs_aml_consumer_0007( p_customer_id VARCHAR(15), p_value_x DECIMAL(15, 2) ) RETURNS INT DETERMINISTIC
BEGIN RETURN 1; END $$
DELIMITER ;

DROP FUNCTION IF EXISTS fs_aml_consumer_0009;
DELIMITER $$
CREATE FUNCTION fs_aml_consumer_0008( p_customer_id VARCHAR(15), p_value_x DECIMAL(15, 2) ) RETURNS INT DETERMINISTIC
BEGIN RETURN 1; END $$
DELIMITER ;

DROP FUNCTION IF EXISTS fs_aml_consumer_0009;
DELIMITER $$
CREATE FUNCTION fs_aml_consumer_0009( p_customer_id VARCHAR(15), p_value_x DECIMAL(15, 2) ) RETURNS INT DETERMINISTIC
BEGIN RETURN 1; END $$
DELIMITER ;

DROP FUNCTION IF EXISTS fs_aml_consumer_0010;
DELIMITER $$
CREATE FUNCTION fs_aml_consumer_0010( p_customer_id VARCHAR(15), p_value_x DECIMAL(15, 2) ) RETURNS INT DETERMINISTIC
BEGIN RETURN 1; END $$
DELIMITER ;

DROP FUNCTION IF EXISTS fs_aml_consumer_0011;
DELIMITER $$
CREATE FUNCTION fs_aml_consumer_0011( p_customer_id VARCHAR(15), p_value_x DECIMAL(15, 2) ) RETURNS INT DETERMINISTIC
BEGIN RETURN 1; END $$
DELIMITER ;

DROP FUNCTION IF EXISTS fs_aml_consumer_0012;
DELIMITER $$
CREATE FUNCTION fs_aml_consumer_0012( p_customer_id VARCHAR(15), p_value_x DECIMAL(15, 2) ) RETURNS INT DETERMINISTIC
BEGIN RETURN 1; END $$
DELIMITER ;

DROP FUNCTION IF EXISTS fs_aml_consumer_0013;
DELIMITER $$
CREATE FUNCTION fs_aml_consumer_0013( p_customer_id VARCHAR(15), p_value_x DECIMAL(15, 2) ) RETURNS INT DETERMINISTIC
BEGIN RETURN 1; END $$
DELIMITER ;

DROP FUNCTION IF EXISTS fs_aml_consumer_0014;
DELIMITER $$
CREATE FUNCTION fs_aml_consumer_0014( p_customer_id VARCHAR(15), p_value_x DECIMAL(15, 2) ) RETURNS INT DETERMINISTIC
BEGIN RETURN 1; END $$
DELIMITER ;




SET @cbs_customer_id = '1001747';

INSERT INTO aml_scanning_role VALUES('AML_ROLE_SCAN_2026120', 'Running');
INSERT INTO aml_scanning_roles
SELECT
	'AML_ROLE_SCAN_2026120',
	CURRENT_TIMESTAMP,
    NULL,
	@cbs_customer_id AS customer_id,
	fs_aml_consumer_0001(@cbs_customer_id, 200000.00) AS aml_0001,
    0 AS aml_0002,
    0 AS aml_0003,
    0 AS aml_0004,
    0 AS aml_0005,
    0 AS aml_0006,
    0 AS aml_0007,
    0 AS aml_0008,
    0 AS aml_0009,
    0 AS aml_0010,
    0 AS aml_0011,
    0 AS aml_0012,
    0 AS aml_0013,
    0 AS aml_0014,
    'Running',
    ''
;

SELECT * FROM aml_customer_alerts





