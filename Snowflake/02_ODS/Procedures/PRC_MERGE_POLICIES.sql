-- =============================================================================
-- PRC_MERGE_POLICIES (Refactored)
-- =============================================================================

USE SCHEMA SECURELIFE_DB.ODS;

CREATE OR REPLACE PROCEDURE PRC_MERGE_POLICIES()
RETURNS STRING
LANGUAGE SQL
EXECUTE AS CALLER
AS
$$
BEGIN
    MERGE INTO ODS_POLICIES target
    USING (
        SELECT
            POLICY_REF,
            SOURCE_SYSTEM,
            CUSTOMER_ID_REF,
            POSTCODE,
            PREMIUM_AMOUNT,
            RENEWAL_DATE,
            PRODUCT_LINE,
            MD5(NVL(CUSTOMER_ID_REF,'') || NVL(POSTCODE,'') || PRODUCT_LINE) as NEW_MD5_HASH
        FROM SECURELIFE_DB.ODS.VW_ODS_POLICIES
    ) source
    ON target.POLICY_REF = source.POLICY_REF
    WHEN MATCHED AND target.MD5_HASH != source.NEW_MD5_HASH THEN
        UPDATE SET
            PREMIUM_AMOUNT = source.PREMIUM_AMOUNT,
            RENEWAL_DATE = source.RENEWAL_DATE,
            MD5_HASH = source.NEW_MD5_HASH,
            DW_UPDATE_TS = CURRENT_TIMESTAMP()
    WHEN NOT MATCHED THEN
        INSERT (POLICY_REF, SOURCE_SYSTEM, CUSTOMER_ID_REF, POSTCODE, PREMIUM_AMOUNT, RENEWAL_DATE, PRODUCT_LINE, MD5_HASH)
        VALUES (source.POLICY_REF, source.SOURCE_SYSTEM, source.CUSTOMER_ID_REF, source.POSTCODE, source.PREMIUM_AMOUNT, source.RENEWAL_DATE, source.PRODUCT_LINE, source.NEW_MD5_HASH);

    RETURN 'ODS_POLICIES merged successfully using VW_ODS_POLICIES';
END;
$$;
