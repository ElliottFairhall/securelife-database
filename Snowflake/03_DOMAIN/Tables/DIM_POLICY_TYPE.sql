-- =============================================================================
-- DIM_POLICY_TYPE
-- =============================================================================

USE SCHEMA SECURELIFE_DB.DOMAIN;

CREATE OR REPLACE TABLE DIM_POLICY_TYPE (
    POLICY_TYPE_KEY INTEGER IDENTITY (1, 1) PRIMARY KEY,
    PRODUCT_CODE VARCHAR(20) UNIQUE,
    PRODUCT_NAME VARCHAR(100),
    BUSINESS_LINE VARCHAR(50), -- Motor, Home, Life
    STANDARD_IPT_RATE DECIMAL(5, 2) DEFAULT 12.00,
    IS_REGULATED BOOLEAN DEFAULT TRUE,
    DW_INSERT_TS TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
)
COMMENT = 'Insurance product catalogue for SecureLife UK';
