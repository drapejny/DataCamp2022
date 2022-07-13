-- Creating cluster emp_dept_cluster
  CREATE cluster emp_dept_cluster( deptno NUMBER( 2 ) )
    SIZE 1024 
    STORAGE( INITIAL 100K NEXT 50K );
    
-- Creating cluster index
CREATE INDEX idxcl_emp_dept on cluster emp_dept_cluster;

-- Creating table dept and put it into cluster
CREATE TABLE dept
  (
    deptno NUMBER( 2 ) PRIMARY KEY,
    dname  VARCHAR2( 14 ),
    loc    VARCHAR2( 13 )
  )
  cluster emp_dept_cluster ( deptno ) ;

-- Creating table emp and put it into cluster
CREATE TABLE emp
  (
    empno NUMBER PRIMARY KEY,
    ename VARCHAR2( 10 ),
    job   VARCHAR2( 9 ),
    mgr   NUMBER,
    hiredate DATE,
    sal    NUMBER,
    comm   NUMBER,
    deptno NUMBER( 2 ) REFERENCES dept( deptno )
  )
  cluster emp_dept_cluster ( deptno );
  
-- Inserting data into tables
INSERT INTO dept( deptno , dname , loc)
SELECT deptno , dname , loc
FROM scott.dept;
   
commit;

INSERT INTO emp ( empno, ename, job, mgr, hiredate, sal, comm, deptno )
SELECT rownum, ename, job, mgr, hiredate, sal, comm, deptno
FROM scott.emp
      
commit;

-- Selecting block number for rows in emp and dept tables
SELECT *
   FROM
  (
     SELECT dept_blk,
            emp_blk,
            CASE
                WHEN dept_blk <> emp_blk 
                THEN '*' 
            END flag,
            deptno
       FROM
      (
         SELECT dbms_rowid.rowid_block_number( dept.rowid ) dept_blk,
                dbms_rowid.rowid_block_number( emp.rowid ) emp_blk,
                dept.deptno
         FROM emp , dept
        WHERE emp.deptno = dept.deptno
      )
  )
ORDER BY deptno;

-- Clean up
drop cluster emp_dept_cluster INCLUDING TABLES;

