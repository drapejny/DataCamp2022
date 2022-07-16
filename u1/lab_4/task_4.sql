-- Enable autotrace
SET AUTOTRACE ON;

-- Selecting rows from t2
SELECT t2.*  FROM t2 where t2.id = '1';

-- Disable autotrace
SET AUTOTRACE OFF;