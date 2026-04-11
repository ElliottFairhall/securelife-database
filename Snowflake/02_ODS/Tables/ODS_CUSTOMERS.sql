-- =============================================================================
-- ODS_CUSTOMERS
-- =============================================================================

USE SCHEMA SECURELIFE_DB.ODS;

CREATE OR REPLACE TABLE ODS_CUSTOMERS (
    CUSTOMER_ID VARCHAR(50) PRIMARY KEY,
    FIRST_NAME VARCHAR(100),
    LAST_NAME VARCHAR(100),
    DOB DATE,
    PI_NINO VARCHAR(255), -- Will be masked in Domain
    EMAIL_ADDRESS VARCHAR(255),
    ADDRESS_POSTCODE VARCHAR(10),
    MARKETING_CONSENT BOOLEAN,

    -- ODS Audit Metadata
    MD5_HASH VARCHAR(32),
    DW_INSERT_TS TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    DW_UPDATE_TS TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    SOURCE_SYSTEM VARCHAR(50)
)
COMMENT = 'Operational store for customer master data with change tracking';
