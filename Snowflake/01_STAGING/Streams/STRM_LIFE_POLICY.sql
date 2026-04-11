-- =============================================================================
-- STRM_LIFE_POLICY
-- =============================================================================

USE SCHEMA SECURELIFE_DB.STAGING;

CREATE OR REPLACE STREAM STRM_LIFE_POLICY ON TABLE STG_LIFE_POLICY;
