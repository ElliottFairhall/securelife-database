-- =============================================================================
-- FCT_CLAIMS
-- =============================================================================

USE SCHEMA SECURELIFE_DB.DOMAIN;

CREATE OR REPLACE TABLE FCT_CLAIMS (
    CLAIM_KEY INTEGER IDENTITY (1, 1) PRIMARY KEY,
    CLAIM_REFERENCE VARCHAR(50),

    CUSTOMER_KEY INTEGER NOT NULL,
    POLICY_SALES_KEY INTEGER NOT NULL,
    EVENT_DATE_KEY INTEGER NOT NULL,

    RESERVE_AMOUNT_GBP DECIMAL(15, 2),
    PAID_OUT_AMOUNT_GBP DECIMAL(15, 2),
    EXCESS_AMOUNT_GBP DECIMAL(10, 2),

    IS_AT_FAULT_CLAIM BOOLEAN,
    CLAIM_DESCRIPTION TEXT,

    DW_INSERT_TS TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
)
COMMENT = 'Grain: One row per insurance claim event across all business lines.';
