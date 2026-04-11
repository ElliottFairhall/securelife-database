-- =============================================================================
-- ODS_CLAIMS
-- =============================================================================

USE SCHEMA SECURELIFE_DB.ODS;

CREATE OR REPLACE TABLE ODS_CLAIMS (
    CLAIM_ID VARCHAR(50) PRIMARY KEY,
    POLICY_REF VARCHAR(50),
    BUSINESS_LINE VARCHAR(20),
    CLAIM_DATE DATE,
    SETTLEMENT_AMOUNT DECIMAL(15, 2),
    STATUS VARCHAR(20),
    DESCRIPTION TEXT,

    -- Audit
    DW_INSERT_TS TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    DW_UPDATE_TS TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    SOURCE_SYSTEM VARCHAR(50)
)
COMMENT = 'Integrated operational store for claims data';
