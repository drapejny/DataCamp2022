SET AUTOTRACE OFF;

SET AUTOTRACE ON;
SELECT * FROM scott.emp;

SET AUTOTRACE TRACEONLY;
SELECT * FROM scott.emp;

SET AUTOTRACE ON EXPLAIN;
SELECT * FROM scott.emp;

SET AUTOTRACE ON STATISTICS;
SELECT * FROM scott.emp;

SET AUTOTRACE ON EXPLAIN STATISTICS;
SELECT * FROM scott.emp;

SET AUTOTRACE TRACEONLY EXPLAIN;
SELECT * FROM scott.emp;

SET AUTOTRACE TRACEONLY STATISTICS;
SELECT * FROM scott.emp;

SET AUTOTRACE TRACEONLY EXPLAIN STATISTICS;
SELECT * FROM scott.emp;

SET AUTOTRACE OFF EXPLAIN;
SELECT * FROM scott.emp;

SET AUTOTRACE OFF STATISTICS;
SELECT * FROM scott.emp;

SET AUTOTRACE OFF EXPLAIN STATISTICS;
SELECT * FROM scott.emp;
