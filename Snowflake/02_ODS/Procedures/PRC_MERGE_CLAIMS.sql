-- =============================================================================
-- PRC_MERGE_CLAIMS (Refactored)
-- =============================================================================

USE SCHEMA SECURELIFE_DB.ODS;

CREATE OR REPLACE PROCEDURE PRC_MERGE_CLAIMS()
RETURNS STRING
LANGUAGE SQL
EXECUTE AS CALLER
AS
$$
BEGIN
    MERGE INTO ODS_CLAIMS target
    USING (
        SELECT
            CLAIM_ID,
            POLICY_REF,
            BUSINESS_LINE,
            CLAIM_DATE,
            SETTLEMENT_AMOUNT,
            STATUS,
            DESCRIPTION,
            SOURCE_SYSTEM
        FROM SECURELIFE_DB.ODS.VW_ODS_CLAIMS
    ) source
    ON target.CLAIM_ID = source.CLAIM_ID
    WHEN MATCHED THEN
        UPDATE SET
            SETTLEMENT_AMOUNT = source.SETTLEMENT_AMOUNT,
            STATUS = source.STATUS,
            DESCRIPTION = source.DESCRIPTION,
            DW_UPDATE_TS = CURRENT_TIMESTAMP()
    WHEN NOT MATCHED THEN
        INSERT (CLAIM_ID, POLICY_REF, BUSINESS_LINE, CLAIM_DATE, SETTLEMENT_AMOUNT, STATUS, DESCRIPTION, SOURCE_SYSTEM)
        VALUES (source.CLAIM_ID, source.POLICY_REF, source.BUSINESS_LINE, source.CLAIM_DATE, source.SETTLEMENT_AMOUNT, source.STATUS, source.DESCRIPTION, source.SOURCE_SYSTEM);

    RETURN 'ODS_CLAIMS merged successfully using VW_ODS_CLAIMS';
END;
$$;
