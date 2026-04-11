-- =============================================================================
-- STRM_CUSTOMER_REFERENCE
-- =============================================================================

USE SCHEMA SECURELIFE_DB.STAGING;

CREATE OR REPLACE STREAM STRM_CUSTOMER_REFERENCE ON TABLE STG_CUSTOMER_REFERENCE;
