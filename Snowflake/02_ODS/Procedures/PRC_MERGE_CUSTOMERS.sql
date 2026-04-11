-- =============================================================================
-- PRC_MERGE_CUSTOMERS (Refactored)
-- =============================================================================

USE SCHEMA SECURELIFE_DB.ODS;

CREATE OR REPLACE PROCEDURE PRC_MERGE_CUSTOMERS()
RETURNS STRING
LANGUAGE SQL
EXECUTE AS CALLER
AS
$$
BEGIN
    MERGE INTO ODS_CUSTOMERS target
    USING (
        SELECT
            CUSTOMER_ID,
            FIRST_NAME,
            LAST_NAME,
            DOB,
            PI_NINO,
            EMAIL_ADDRESS,
            ADDRESS_POSTCODE,
            MARKETING_CONSENT,
            MD5(NVL(FIRST_NAME,'') || NVL(LAST_NAME,'') || NVL(EMAIL_ADDRESS,'')) as NEW_MD5_HASH,
            SOURCE_SYSTEM
        FROM SECURELIFE_DB.ODS.VW_ODS_CUSTOMERS
    ) source
    ON target.CUSTOMER_ID = source.CUSTOMER_ID
    WHEN MATCHED AND target.MD5_HASH != source.NEW_MD5_HASH THEN
        UPDATE SET
            FIRST_NAME = source.FIRST_NAME,
            LAST_NAME = source.LAST_NAME,
            DOB = source.DOB,
            PI_NINO = source.PI_NINO,
            EMAIL_ADDRESS = source.EMAIL_ADDRESS,
            ADDRESS_POSTCODE = source.ADDRESS_POSTCODE,
            MARKETING_CONSENT = source.MARKETING_CONSENT,
            MD5_HASH = source.NEW_MD5_HASH,
            DW_UPDATE_TS = CURRENT_TIMESTAMP()
    WHEN NOT MATCHED THEN
        INSERT (CUSTOMER_ID, FIRST_NAME, LAST_NAME, DOB, PI_NINO, EMAIL_ADDRESS, ADDRESS_POSTCODE, MARKETING_CONSENT, MD5_HASH, SOURCE_SYSTEM)
        VALUES (source.CUSTOMER_ID, source.FIRST_NAME, source.LAST_NAME, source.DOB, source.PI_NINO, source.EMAIL_ADDRESS, source.ADDRESS_POSTCODE, source.MARKETING_CONSENT, source.NEW_MD5_HASH, source.SOURCE_SYSTEM);

    RETURN 'ODS_CUSTOMERS merged successfully using VW_ODS_CUSTOMERS';
END;
$$;
