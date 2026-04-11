-- =============================================================================
-- PRC_LOAD_DIM_POLICY_TYPE
-- =============================================================================

USE SCHEMA SECURELIFE_DB.DOMAIN;

CREATE OR REPLACE PROCEDURE PRC_LOAD_DIM_POLICY_TYPE()
RETURNS STRING
LANGUAGE SQL
EXECUTE AS CALLER
AS
$$
BEGIN
    -- Seed default product types
    MERGE INTO DIM_POLICY_TYPE target
    USING (
        SELECT 'MTR_COMP' as PRODUCT_CODE, 'Motor Comprehensive' as PRODUCT_NAME, 'MOTOR' as BUSINESS_LINE
        UNION ALL
        SELECT 'HOM_STD', 'Standard Home', 'HOME'
        UNION ALL
        SELECT 'LFT_PROT', 'Life Protection', 'LIFE'
    ) source
    ON target.PRODUCT_CODE = source.PRODUCT_CODE
    WHEN NOT MATCHED THEN
        INSERT (PRODUCT_CODE, PRODUCT_NAME, BUSINESS_LINE)
        VALUES (source.PRODUCT_CODE, source.PRODUCT_NAME, source.BUSINESS_LINE);

    RETURN 'DIM_POLICY_TYPE synchronised';
END;
$$;
