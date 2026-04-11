-- =============================================================================
-- DIM_CLAIM_STATUS
-- =============================================================================

USE SCHEMA SECURELIFE_DB.DOMAIN;

CREATE OR REPLACE TABLE DIM_CLAIM_STATUS (
    CLAIM_STATUS_KEY INTEGER IDENTITY (1, 1) PRIMARY KEY,
    STATUS_CODE VARCHAR(20) UNIQUE,
    STATUS_DESCRIPTION VARCHAR(100),
    IS_FINAL_STATE BOOLEAN, -- Settled or Repudiated
    DW_INSERT_TS TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
)
COMMENT = 'Standardised claim lifecycle states for SecureLife UK';
