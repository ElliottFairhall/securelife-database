-- =============================================================================
-- DIM_GEOGRAPHY
-- =============================================================================

USE SCHEMA SECURELIFE_DB.DOMAIN;

CREATE OR REPLACE TABLE DIM_GEOGRAPHY (
    GEOGRAPHY_KEY INTEGER IDENTITY (1, 1) PRIMARY KEY,
    POSTCODE VARCHAR(10) UNIQUE,
    CITY VARCHAR(100),
    COUNTY VARCHAR(100),
    REGION VARCHAR(50),
    RISK_CLUSTER VARCHAR(10), -- A, B, C, D (Insurance risk zones)
    DW_INSERT_TS TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
)
COMMENT = 'UK Postcode based geographic and risk dimension';
