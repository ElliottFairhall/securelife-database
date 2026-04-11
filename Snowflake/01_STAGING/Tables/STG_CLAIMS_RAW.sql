-- =============================================================================
-- STG_CLAIMS_RAW
-- =============================================================================

USE SCHEMA SECURELIFE_DB.STAGING;

CREATE OR REPLACE TABLE STG_CLAIMS_RAW (
    CLAIM_ID VARCHAR(50),
    POLICY_REF_SOURCE VARCHAR(50),
    SYSTEM_SOURCE VARCHAR(20), -- MOTOR, HOME, LIFE
    CLAIM_DATE DATE,
    SETTLEMENT_AMOUNT DECIMAL(15, 2),
    STATUS VARCHAR(20),
    DESCRIPTION TEXT,
    EXTRACT_TS TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
)
COMMENT = 'Unified landing for claims from all legacy systems';
