-- =============================================================================
-- 02_ROW_ACCESS_POLICIES
-- =============================================================================

USE SCHEMA SECURELIFE_DB.GOVERNANCE;

-- Row Level Security: Vulnerable Customer Protection
CREATE OR REPLACE ROW ACCESS POLICY RAP_VULNERABLE_CUSTOMERS
AS (vulnerable_flag boolean) RETURNS boolean ->
    CASE
        WHEN NOT vulnerable_flag THEN TRUE
        WHEN CURRENT_ROLE() IN ('SECURELIFE_ADMIN', 'SECURELIFE_COMPLIANCE_OFFICER', 'SECURELIFE_VULNERABLE_CARE_TEAM') THEN TRUE
        ELSE FALSE
    END;

-- Apply to DIM_CUSTOMER
ALTER TABLE SECURELIFE_DB.DOMAIN.DIM_CUSTOMER
ADD ROW ACCESS POLICY RAP_VULNERABLE_CUSTOMERS ON (VULNERABLE_CUSTOMER_FLAG);
