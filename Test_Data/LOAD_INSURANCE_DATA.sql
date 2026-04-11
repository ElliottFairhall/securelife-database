-- =============================================================================
-- SECURELIFE UK INSURANCE - TEST DATA SEEDING
-- =============================================================================

USE SCHEMA SECURELIFE_DB.DOMAIN;

-- 1. Seed Policy Types
INSERT INTO DIM_POLICY_TYPE (PRODUCT_CODE, PRODUCT_NAME, BUSINESS_LINE, MIN_IPT_RATE)
VALUES
('MTR_COMP', 'Motor Comprehensive', 'Motor', 12.00),
('HTH_LIFE', 'Life Protection Plus', 'Life', 0.00),
('HOM_MID', 'Standard Home & Contents', 'Home', 12.00);

-- 2. Seed SCV Customers (Examples of records matched from diff systems)
INSERT INTO DIM_CUSTOMER (
    GLOBAL_CUSTOMER_ID, FIRST_NAME, LAST_NAME, DATE_OF_BIRTH,
    EMAIL_ADDRESS, POSTCODE, MARKETING_CONSENT_FLAG, SOURCE_SYSTEMS,
    EFFECTIVE_FROM, MD5_HASH
)
VALUES
(
    'SL-1001',
    'Oliver',
    'Bennett',
    '1985-05-12',
    'o.bennett@example.co.uk',
    'LS1 1UR',
    TRUE,
    'MOTOR,HOME',
    CURRENT_TIMESTAMP(),
    'HASH_001'
),
(
    'SL-1002',
    'Amelia',
    'Davies',
    '1992-11-20',
    'a.davies@example.com',
    'M1 1AE',
    FALSE,
    'MOTOR',
    CURRENT_TIMESTAMP(),
    'HASH_002'
),
(
    'SL-1003',
    'Jack',
    'Thompson',
    '1965-03-30',
    'j.thompson@example.net',
    'SW1A 1AA',
    TRUE,
    'LIFE,HOME',
    CURRENT_TIMESTAMP(),
    'HASH_003'
);

-- 3. Seed Policy Facts
INSERT INTO FCT_POLICY_SALES (
    POLICY_REFERENCE, CUSTOMER_KEY, POLICY_TYPE_KEY,
    INCEPTION_DATE_KEY, EXPIRY_DATE_KEY,
    BASE_PREMIUM_AMOUNT, IPT_AMOUNT, TOTAL_WRITTEN_PREMIUM,
    SOURCE_SYSTEM
)
VALUES
('POL-M-889', 1, 1, 20260101, 20270101, 450.00, 54.00, 504.00, 'MOTOR_LEGACY'),
('POL-H-212', 1, 3, 20260315, 20270315, 220.00, 26.40, 246.40, 'HOME_LEGACY'),
('POL-L-003', 3, 2, 20240101, 20990101, 1200.00, 0.00, 1200.00, 'LIFE_LEGACY');

-- 4. Seed Claims
INSERT INTO FCT_CLAIMS (
    CLAIM_REFERENCE, CUSTOMER_KEY, POLICY_SALES_KEY,
    EVENT_DATE_KEY, RESERVE_AMOUNT_GBP, PAID_OUT_AMOUNT_GBP,
    IS_AT_FAULT_CLAIM, CLAIM_DESCRIPTION
)
VALUES
('CLM-991', 1, 1, 20260214, 1500.00, 1250.00, TRUE, 'Minor collision at roundabout involving third party.'),
('CLM-992', 3, 3, 20251212, 5000.00, 0.00, FALSE, 'Theft of garden furniture from secured shed.');
