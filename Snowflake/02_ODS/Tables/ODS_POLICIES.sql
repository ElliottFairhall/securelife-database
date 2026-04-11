-- =============================================================================
-- ODS_POLICIES
-- =============================================================================

USE SCHEMA SECURELIFE_DB.ODS;

CREATE OR REPLACE TABLE ODS_POLICIES (
    POLICY_REF VARCHAR(50) PRIMARY KEY,
    SOURCE_SYSTEM VARCHAR(50),
    CUSTOMER_ID_REF VARCHAR(255),
    POSTCODE VARCHAR(10),
    PREMIUM_AMOUNT DECIMAL(12, 2),
    RENEWAL_DATE DATE,
    PRODUCT_LINE VARCHAR(20),

    -- Audit
    MD5_HASH VARCHAR(32),
    DW_INSERT_TS TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    DW_UPDATE_TS TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
)
COMMENT = 'Unified operational store for all policy types (Motor, Home, Life)';
