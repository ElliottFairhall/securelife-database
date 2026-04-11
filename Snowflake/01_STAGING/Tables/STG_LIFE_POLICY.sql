-- =============================================================================
-- STG_LIFE_POLICY
-- =============================================================================

USE SCHEMA SECURELIFE_DB.STAGING;

CREATE OR REPLACE TABLE STG_LIFE_POLICY (
    TRANS_ID VARCHAR(50),
    CLIENT_FIRST_NAME VARCHAR(100),
    CLIENT_LAST_NAME VARCHAR(100),
    CLIENT_DOB DATE,
    NATIONAL_INS_NUM VARCHAR(15),
    MONTHLY_PREMIUM DECIMAL(12, 2),
    SUM_ASSURED DECIMAL(15, 2),
    POLICY_STATUS VARCHAR(20),
    EXTRACT_TS TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
)
COMMENT = 'Landing table for legacy Life insurance system';
