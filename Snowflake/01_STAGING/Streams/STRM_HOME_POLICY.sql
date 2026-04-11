-- =============================================================================
-- STRM_HOME_POLICY
-- =============================================================================

USE SCHEMA SECURELIFE_DB.STAGING;

CREATE OR REPLACE STREAM STRM_HOME_POLICY ON TABLE STG_HOME_POLICY;
