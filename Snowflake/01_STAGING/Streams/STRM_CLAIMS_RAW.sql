-- =============================================================================
-- STRM_CLAIMS_RAW
-- =============================================================================

USE SCHEMA SECURELIFE_DB.STAGING;

CREATE OR REPLACE STREAM STRM_CLAIMS_RAW ON TABLE STG_CLAIMS_RAW;
