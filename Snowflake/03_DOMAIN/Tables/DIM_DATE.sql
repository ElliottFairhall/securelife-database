-- =============================================================================
-- DIM_DATE
-- =============================================================================

USE SCHEMA SECURELIFE_DB.DOMAIN;

CREATE OR REPLACE TABLE DIM_DATE (
    DATE_KEY INTEGER PRIMARY KEY,
    FULL_DATE DATE NOT NULL,
    DAY_NAME VARCHAR(10),
    MONTH_NAME VARCHAR(10),
    YEAR_NUMBER INTEGER,
    FISCAL_YEAR INTEGER,
    IS_UK_BANK_HOLIDAY BOOLEAN,
    DW_INSERT_TS TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
)
COMMENT = 'Standard UK date dimension for insurance period reporting';
