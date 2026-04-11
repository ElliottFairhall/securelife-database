-- =============================================================================
-- PRC_LOAD_DIM_CUSTOMER
-- =============================================================================

USE SCHEMA SECURELIFE_DB.DOMAIN;

CREATE OR REPLACE PROCEDURE PRC_LOAD_DIM_CUSTOMER()
RETURNS STRING
LANGUAGE SQL
EXECUTE AS CALLER
AS
$$
BEGIN
    -- 1. Expire existing records that have changed
    UPDATE DIM_CUSTOMER target
    SET
        EFFECTIVE_TO = CURRENT_TIMESTAMP(),
        IS_CURRENT = FALSE,
        DW_UPDATE_TS = CURRENT_TIMESTAMP()
    FROM SECURELIFE_DB.ODS.VW_ODS_CUSTOMERS source
    WHERE target.GLOBAL_CUSTOMER_ID = source.CUSTOMER_ID
      AND target.IS_CURRENT = TRUE
      AND target.MD5_HASH != MD5(NVL(source.FIRST_NAME,'') || NVL(source.LAST_NAME,'') || NVL(source.EMAIL_ADDRESS,''));

    -- 2. Insert new records (both brand new and new versions of expired)
    INSERT INTO DIM_CUSTOMER (
        GLOBAL_CUSTOMER_ID, FIRST_NAME, LAST_NAME, DATE_OF_BIRTH,
        NATIONAL_INSURANCE_NUMBER, EMAIL_ADDRESS, POSTCODE, CITY_TOWN,
        MARKETING_CONSENT_FLAG, SOURCE_SYSTEMS, EFFECTIVE_FROM, IS_CURRENT, MD5_HASH
    )
    SELECT
        source.CUSTOMER_ID,
        source.FIRST_NAME,
        source.LAST_NAME,
        source.DOB,
        source.PI_NINO,
        source.EMAIL_ADDRESS,
        source.ADDRESS_POSTCODE,
        'UNKNOWN', -- City/Town not in all sources
        source.MARKETING_CONSENT,
        source.SOURCE_SYSTEM,
        CURRENT_TIMESTAMP(),
        TRUE,
        MD5(NVL(source.FIRST_NAME,'') || NVL(source.LAST_NAME,'') || NVL(source.EMAIL_ADDRESS,''))
    FROM SECURELIFE_DB.ODS.VW_ODS_CUSTOMERS source
    LEFT JOIN DIM_CUSTOMER target
      ON source.CUSTOMER_ID = target.GLOBAL_CUSTOMER_ID
      AND target.IS_CURRENT = TRUE
    WHERE target.GLOBAL_CUSTOMER_ID IS NULL;

    RETURN 'DIM_CUSTOMER loaded successfully with SCD Type 2 logic';
END;
$$;
