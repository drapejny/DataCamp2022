SET AUTOTRACE ON EXPLAIN;

-- Task 2.1 Nested Loops Joins
SELECT  *
FROM scott.emp e, scott.dept d
WHERE e.deptno = d.deptno AND d.deptno = 10;

-- Task 2.2 Sort-Merge Joins
SELECT /*+ USE_MERGE*/  *
FROM scott.emp e, scott.dept d
WHERE e.deptno = d.deptno;

-- Task 2.3 Hash Joins
SELECT /*+ USE_HASH(e, d)*/  *
FROM scott.emp e, scott.dept d
WHERE e.deptno = d.deptno;

-- Task 2.4 Cartesian Joins
SELECT *
FROM scott.emp e, scott.dept d;

-- Task 2.5 Left/Right Outer Joins
-- Left Outer Join
SELECT *
FROM scott.dept d
LEFT JOIN scott.emp e
ON e.deptno = d.deptno ;

-- Right Outer Join
SELECT *
FROM scott.emp e
RIGHT JOIN scott.dept d
ON e.deptno = d.deptno;

-- Task 2.6 Full Outer Join
SELECT *
FROM scott.emp e
FULL OUTER JOIN scott.dept d
ON e.deptno = d.deptno;

-- Task 2.7 Semi Joins
SELECT dname
FROM SCOTT.dept dept
WHERE deptno IN
    (SELECT deptno FROM scott.emp );

-- Task 2.8 Anti Joins
SELECT DName
FROM SCOTT.dept dept
WHERE deptno NOT IN
    (SELECT deptno FROM scott.emp );