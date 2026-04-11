-- =============================================================================
-- PRC_LOAD_FCT_CLAIMS
-- =============================================================================

USE SCHEMA SECURELIFE_DB.DOMAIN;

CREATE OR REPLACE PROCEDURE PRC_LOAD_FCT_CLAIMS()
RETURNS STRING
LANGUAGE SQL
EXECUTE AS CALLER
AS
$$
BEGIN
    INSERT INTO FCT_CLAIMS (
        CLAIM_REFERENCE, CUSTOMER_KEY, POLICY_SALES_KEY,
        EVENT_DATE_KEY, RESERVE_AMOUNT_GBP, PAID_OUT_AMOUNT_GBP,
        IS_AT_FAULT_CLAIM, CLAIM_DESCRIPTION
    )
    SELECT
        c.CLAIM_ID,
        p.CUSTOMER_KEY,
        p.POLICY_SALES_KEY,
        20260101, -- Placeholder for date logic
        c.SETTLEMENT_AMOUNT * 1.2, -- Mock reserve
        c.SETTLEMENT_AMOUNT,
        CASE WHEN c.STATUS = 'SETTLED' THEN TRUE ELSE FALSE END,
        c.DESCRIPTION
    FROM SECURELIFE_DB.ODS.VW_ODS_CLAIMS c
    JOIN FCT_POLICY_SALES p ON c.POLICY_REF = p.POLICY_REFERENCE
    LEFT JOIN FCT_CLAIMS target ON c.CLAIM_ID = target.CLAIM_REFERENCE
    WHERE target.CLAIM_REFERENCE IS NULL;

    RETURN 'FCT_CLAIMS loaded successfully';
END;
$$;
