-- =============================================================================
-- SECURELIFE UK INSURANCE - STAGING DATA LOAD (ENHANCED)
-- =============================================================================
-- Purpose:    Seed Staging Layer with Legacy System extracts for end-to-end testing
-- Author:     Elliott Fairhall
-- UK English: Standardised
-- =============================================================================

USE ROLE SECURELIFE_ADMIN;
USE SCHEMA SECURELIFE_DB.STAGING;

-- 1. Load Customer Reference (Identity Resolution Source)
TRUNCATE TABLE STG_CUSTOMER_REFERENCE;
INSERT INTO STG_CUSTOMER_REFERENCE (
    CUSTOMER_ID, FIRST_NAME, LAST_NAME, DOB, PI_NINO, EMAIL_ADDRESS, ADDRESS_POSTCODE, MARKETING_CONSENT
)
VALUES
('C-1001', 'Oliver', 'Bennett', '1985-05-12', 'OB112233A', 'o.bennett@example.co.uk', 'LS1 1UR', TRUE),
('C-1002', 'Amelia', 'Davies', '1992-11-20', 'AD445566B', 'a.davies@example.com', 'M1 1AE', FALSE),
('C-1003', 'Jack', 'Thompson', '1965-03-30', 'JT778899C', 'j.thompson@example.net', 'SW1A 1AA', TRUE);

-- 2. Load Motor Staging
TRUNCATE TABLE STG_MOTOR_POLICY;
INSERT INTO STG_MOTOR_POLICY (POLICY_ID, HOLDER_NAME, ADDRESS_POSTCODE, VEHICLE_REG, ANNUAL_PREMIUM, RENEWAL_DATE)
VALUES
('MTR-7712', 'C-1001', 'LS1 1UR', 'BT72 ABC', 450.00, '2027-01-01'),
('MTR-7713', 'C-1002', 'M1 1AE', 'ND20 XYZ', 520.00, '2026-11-20');

-- 3. Load Home Staging
TRUNCATE TABLE STG_HOME_POLICY;
INSERT INTO STG_HOME_POLICY (POLICY_REF, CUSTOMER_EMAIL, CITY, POSTCODE, BUILDING_VALUE, CONTENTS_VALUE, TOTAL_PREMIUM)
VALUES
('HOM-202', 'o.bennett@example.co.uk', 'Leeds', 'LS1 1UR', 250000.00, 50000.00, 220.00),
('HOM-203', 'j.thompson@example.net', 'London', 'SW1A 1AA', 800000.00, 100000.00, 450.00);

-- 4. Load Life Staging
TRUNCATE TABLE STG_LIFE_POLICY;
INSERT INTO STG_LIFE_POLICY (
    TRANS_ID,
    CLIENT_FIRST_NAME,
    CLIENT_LAST_NAME,
    CLIENT_DOB,
    NATIONAL_INS_NUM,
    MONTHLY_PREMIUM,
    SUM_ASSURED,
    POLICY_STATUS
)
VALUES
('LFT-500', 'Jack', 'Thompson', '1965-03-30', 'JT778899C', 100.00, 250000.00, 'ACTIVE');

-- 5. Load Claims Staging
TRUNCATE TABLE STG_CLAIMS_RAW;
INSERT INTO STG_CLAIMS_RAW (
    CLAIM_ID, POLICY_REF_SOURCE, SYSTEM_SOURCE, CLAIM_DATE, SETTLEMENT_AMOUNT, STATUS, DESCRIPTION
)
VALUES
('CLM-601', 'MTR-7712', 'MOTOR', '2026-02-14', 1250.00, 'SETTLED', 'Minor collision at Leeds roundabout.'),
('CLM-602', 'HOM-203', 'HOME', '2025-12-12', 0.00, 'OPEN', 'Theft of garden furniture from secured shed in SW1A.');

-- =============================================================================
-- EXECUTE FULL PIPELINE
-- =============================================================================
-- Note: Change streams must be consumed.
-- CALL SECURELIFE_DB.UTILS.PRC_LOAD_ALL_LAYERS(FALSE);
