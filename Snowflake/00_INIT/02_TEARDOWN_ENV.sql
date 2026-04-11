-- =============================================================================
-- SECURELIFE UK INSURANCE - SYSTEM TEARDOWN
-- =============================================================================
-- Purpose:    Decommission the SecureLife UK environment
-- Author:     Elliott Fairhall
-- UK English: Standardised
-- =============================================================================

USE ROLE ACCOUNTADMIN;

-- 1. Drop Database (drops all schemas, tables, views, streams, etc.)
DROP DATABASE IF EXISTS SECURELIFE_DB;

-- 2. Drop Warehouse
DROP WAREHOUSE IF EXISTS SECURELIFE_WH;

-- 3. Drop Roles
DROP ROLE IF EXISTS SECURELIFE_ADMIN;
DROP ROLE IF EXISTS SECURELIFE_DEVELOPER;
DROP ROLE IF EXISTS SECURELIFE_ANALYST;
DROP ROLE IF EXISTS SECURELIFE_COMPLIANCE;

-- 4. Unset context (safety)
USE DATABASE NULL;
USE SCHEMA NULL;
USE WAREHOUSE NULL;
