SELECT 
    t.aml_process_id,
    t.aml_oversea_end_point_id,
    
    COALESCE(indv.DATAID, '') AS DATAID,
    COALESCE(indv.VERSIONNUM, '') AS VERSIONNUM,
    COALESCE(indv.FIRST_NAME, '') AS FIRST_NAME,
    COALESCE(indv.SECOND_NAME, '') AS SECOND_NAME,
    COALESCE(indv.UN_LIST_TYPE, '') AS UN_LIST_TYPE,
    COALESCE(indv.REFERENCE_NUMBER, '') AS REFERENCE_NUMBER,
    COALESCE(indv.LISTED_ON, '') AS LISTED_ON,
    COALESCE(indv.GENDER, '') AS GENDER,
    COALESCE(indv.COMMENTS1, '') AS COMMENTS1,
    COALESCE(indv.HAS_INTERPOL_LINK, '') AS HAS_INTERPOL_LINK,
    COALESCE(indv.INTERPOL_LINK, '') AS INTERPOL_LINK,
    COALESCE(indv.DESIGNATION, '') AS DESIGNATION,

    COALESCE(pob.city, '') AS city,
    COALESCE(pob.state_province, '') AS state_province,
    COALESCE(pob.country, '') AS country

FROM aml_oversea_download_files t,
XMLTABLE(
    '//INDIVIDUAL'
    PASSING t.file_contents
    COLUMNS 
		indv_node XML PATH '.',
        DATAID TEXT PATH 'DATAID',
        VERSIONNUM TEXT PATH 'VERSIONNUM',
        FIRST_NAME TEXT PATH 'FIRST_NAME',
        SECOND_NAME TEXT PATH 'SECOND_NAME',
        UN_LIST_TYPE TEXT PATH 'UN_LIST_TYPE',
        REFERENCE_NUMBER TEXT PATH 'REFERENCE_NUMBER',
        LISTED_ON TEXT PATH 'LISTED_ON',
        GENDER TEXT PATH 'GENDER',
        COMMENTS1 TEXT PATH 'COMMENTS1',
        HAS_INTERPOL_LINK TEXT PATH 'HAS_INTERPOL_LINK',
        INTERPOL_LINK TEXT PATH 'INTERPOL_LINK',
        DESIGNATION TEXT PATH 'DESIGNATION'

) indv,
XMLTABLE(
    '//INDIVIDUAL_PLACE_OF_BIRTH'
    PASSING indv.indv_node
    COLUMNS 
        city VARCHAR(100) PATH 'CITY',
        state_province VARCHAR(100) PATH 'STATE_PROVINCE',
        country VARCHAR(100) PATH 'COUNTRY'
) pob;
















<INDIVIDUAL>
    <DATAID>6908001</DATAID>
    <VERSIONNUM>1</VERSIONNUM>
    <FIRST_NAME>CALLIXTE</FIRST_NAME>
    <SECOND_NAME>MBARUSHIMANA</SECOND_NAME>
    <UN_LIST_TYPE>DRC</UN_LIST_TYPE>
    <REFERENCE_NUMBER>CDi.010</REFERENCE_NUMBER>
    <LISTED_ON>2009-03-03</LISTED_ON>
    <GENDER>Male</GENDER>
    <COMMENTS1>Arrested in Paris on 3 October 2010 under ICC warrant for war crimes and crimes against humanity committed by FDLR troops in the Kivus in 2009.  Transferred to The Hague on 25 January 2011 and released by the ICC in late 2011. Elected FDLR Executive Secretary on 29 Nov. 2014 for a five-year term.</COMMENTS1>
    <HAS_INTERPOL_LINK>YES</HAS_INTERPOL_LINK>
    <INTERPOL_LINK>https://www.interpol.int/en/How-we-work/Notices/View-UN-Notices-Individuals</INTERPOL_LINK>
    <DESIGNATION>
        <VALUE>FDLR Executive Secretary</VALUE>
    </DESIGNATION>
    <NATIONALITY>
        <VALUE>Rwanda</VALUE>
    </NATIONALITY>
    <LIST_TYPE>
        <VALUE>UN List</VALUE>
    </LIST_TYPE>
    <LAST_DAY_UPDATED>
        <VALUE>2016-10-13</VALUE>
    </LAST_DAY_UPDATED>
    <INDIVIDUAL_ALIAS>
        <QUALITY/>
        <ALIAS_NAME/>
    </INDIVIDUAL_ALIAS>
    <INDIVIDUAL_ADDRESS>
        <COUNTRY/>
    </INDIVIDUAL_ADDRESS>
    <INDIVIDUAL_DATE_OF_BIRTH>
        <TYPE_OF_DATE>EXACT</TYPE_OF_DATE>
        <DATE>1963-07-24</DATE>
    </INDIVIDUAL_DATE_OF_BIRTH>
    <INDIVIDUAL_PLACE_OF_BIRTH>
        <CITY>Ndusus / Ruhengeri</CITY>
        <STATE_PROVINCE>Northern Province</STATE_PROVINCE>
        <COUNTRY>Rwanda</COUNTRY>
    </INDIVIDUAL_PLACE_OF_BIRTH>
    <INDIVIDUAL_DOCUMENT/>
    <SORT_KEY/>
    <SORT_KEY_LAST_MOD/>
</INDIVIDUAL>