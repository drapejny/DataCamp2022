-- Creating table employees
CREATE TABLE employees AS
        SELECT *
        FROM scott.emp;

-- Creating indeex on employees
CREATE INDEX idx_emp01 ON employees(empno, ename, job);

-- Enable autotrace
SET AUTOTRACE ON;

-- Selecting with optimizer hints
SELECT /*+INDEX_SS(emp idx_emp01)*/ emp.* FROM employees emp where ename = 'SCOTT';

SELECT /*+FULL(emp)*/ emp.* FROM employees emp WHERE ename = 'SCOTT';

-- Disable autotrace
SET AUTOTRACE OFF;