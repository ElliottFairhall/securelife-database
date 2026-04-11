-- =============================================================================
-- STG_CUSTOMER_REFERENCE
-- =============================================================================

USE SCHEMA SECURELIFE_DB.STAGING;

CREATE OR REPLACE TABLE STG_CUSTOMER_REFERENCE (
    CUSTOMER_ID VARCHAR(50),
    FIRST_NAME VARCHAR(100),
    LAST_NAME VARCHAR(100),
    DOB DATE,
    PI_NINO VARCHAR(20), -- National Insurance Number
    EMAIL_ADDRESS VARCHAR(255),
    ADDRESS_POSTCODE VARCHAR(10),
    MARKETING_CONSENT BOOLEAN,
    EXTRACT_TS TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
)
COMMENT = 'Master customer identity reference used for identity resolution';
