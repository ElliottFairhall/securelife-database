-- =============================================================================
-- STG_MOTOR_POLICY
-- =============================================================================

USE SCHEMA SECURELIFE_DB.STAGING;

CREATE OR REPLACE TABLE STG_MOTOR_POLICY (
    POLICY_ID VARCHAR(50),
    HOLDER_NAME VARCHAR(255),
    ADDRESS_POSTCODE VARCHAR(10),
    VEHICLE_REG VARCHAR(15),
    ANNUAL_PREMIUM DECIMAL(12, 2),
    RENEWAL_DATE DATE,
    EXTRACT_TS TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
)
COMMENT = 'Landing table for legacy Motor insurance policy system';
