-- =============================================================================
-- STG_HOME_POLICY
-- =============================================================================

USE SCHEMA SECURELIFE_DB.STAGING;

CREATE OR REPLACE TABLE STG_HOME_POLICY (
    POLICY_REF VARCHAR(50),
    CUSTOMER_EMAIL VARCHAR(255),
    CITY VARCHAR(100),
    POSTCODE VARCHAR(10),
    BUILDING_VALUE DECIMAL(15, 2),
    CONTENTS_VALUE DECIMAL(15, 2),
    TOTAL_PREMIUM DECIMAL(12, 2),
    EXTRACT_TS TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
)
COMMENT = 'Landing table for legacy Home insurance system';
