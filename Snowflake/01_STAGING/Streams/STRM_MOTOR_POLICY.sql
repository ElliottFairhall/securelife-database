-- =============================================================================
-- STRM_MOTOR_POLICY
-- =============================================================================

USE SCHEMA SECURELIFE_DB.STAGING;

CREATE OR REPLACE STREAM STRM_MOTOR_POLICY ON TABLE STG_MOTOR_POLICY;
