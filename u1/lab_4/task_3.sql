-- Creating index on t1(t_pad)
CREATE UNIQUE INDEX udx_t1 ON t1(t_pad);

-- Enable autotrace
set autotrace on;

-- Selecting all rows from t1 using index
SELECT t1.*  FROM t1 where t1.t_pad = '1';

-- Disable autotrace
set autotrace off;
