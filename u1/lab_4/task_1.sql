-- Disable autotrace
SET AUTOTRACE OFF;

-- Creating table t2
CREATE TABLE t2 AS
  SELECT TRUNC(rownum / 100) id, RPAD(rownum, 100) t_pad
  FROM dual
CONNECT BY rownum < 100000;

-- Creating index on t2(id)
CREATE INDEX t2_idx1 ON t2 (id);

------------------ Printing statistics -----------------------

-- Selecting blocks from t2 table
SELECT blocks
FROM user_segments
WHERE segment_name = 'T2';

-- Selecting used blocks count from t2 table
SELECT COUNT(DISTINCT (dbms_rowid.rowid_block_number(rowid))) block_ct 
FROM t2;

-- Enable autotrace to show execution plan and statistics
SET AUTOTRACE ON;

-- Selecting count of rows in t2
SELECT COUNT(*)
FROM t2;

-- Disable autotrace
SET AUTOTRACE OFF;

----------------------------END-------------------------------

-- Deleting all rows from t2
DELETE FROM t2;

------------------ Printing statistics -----------------------

-- Selecting blocks from t2 table
SELECT blocks
FROM user_segments
WHERE segment_name = 'T2';

-- Selecting used blocks count from t2 table
SELECT COUNT(DISTINCT (dbms_rowid.rowid_block_number(rowid))) block_ct 
FROM t2;

-- Enable autotrace to show execution plan and statistics
SET AUTOTRACE ON;

-- Selecting count of rows in t2
SELECT COUNT(*)
FROM t2;

-- Disable autotrace
SET AUTOTRACE OFF;

--------------------------END------------------------------

-- Inserting one row
INSERT INTO t2 (ID, T_PAD)
       VALUES (1, '1');

COMMIT;

------------------ Printing statistics -----------------------

-- Selecting blocks from t2 table
SELECT blocks
FROM user_segments
WHERE segment_name = 'T2';

-- Selecting used blocks count from t2 table
SELECT COUNT(DISTINCT (dbms_rowid.rowid_block_number(rowid))) block_ct 
FROM t2;

-- Enable autotrace to show execution plan and statistics
SET AUTOTRACE ON;

-- Selecting count of rows in t2
SELECT COUNT(*)
FROM t2;

-- Disable autotrace
SET AUTOTRACE OFF;

----------------------------END------------------------------

-- Truncating table
TRUNCATE TABLE t2;

------------------ Printing statistics -----------------------

-- Selecting blocks from t2 table
SELECT blocks
FROM user_segments
WHERE segment_name = 'T2';

-- Selecting used blocks count from t2 table
SELECT COUNT(DISTINCT (dbms_rowid.rowid_block_number(rowid))) block_ct 
FROM t2;

-- Enable autotrace to show execution plan and statistics
SET AUTOTRACE ON;

-- Selecting count of rows in t2
SELECT COUNT(*)
FROM t2;

-- Disable autotrace
SET AUTOTRACE OFF;

----------------------------END------------------------------

drop table t2;