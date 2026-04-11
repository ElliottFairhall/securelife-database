-- =============================================================================
-- UTL_LOG_EVENT
-- =============================================================================

USE SCHEMA SECURELIFE_DB.UTILS;

CREATE OR REPLACE TABLE EVENT_LOG (
    EVENT_ID INTEGER IDENTITY (1, 1) PRIMARY KEY,
    EVENT_TYPE VARCHAR(50),
    OBJECT_NAME VARCHAR(100),
    MESSAGE TEXT,
    EVENT_TS TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    USER_NAME VARCHAR(100) DEFAULT CURRENT_USER()
);

CREATE OR REPLACE PROCEDURE UTL_LOG_EVENT(event_type VARCHAR, object_name VARCHAR, message VARCHAR)
RETURNS STRING
LANGUAGE SQL
EXECUTE AS CALLER
AS
$$
BEGIN
    INSERT INTO EVENT_LOG (EVENT_TYPE, OBJECT_NAME, MESSAGE)
    VALUES (:event_type, :object_name, :message);
    RETURN 'Event logged';
END;
$$;
