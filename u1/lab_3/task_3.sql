-- Creating table emp
CREATE TABLE emp AS
    SELECT
        object_id empno,
        object_name ename,
        created hiredate,
        owner job
    FROM all_objects;

-- Creating primary key in emp table
 alter table emp add constraint emp_pk primary key(empno);
 
-- Calculating statistics
 exec dbms_stats.gather_table_stats( 'ASlizh', 'EMP', cascade=>true );

-- Creating table heap_addresses
CREATE TABLE heap_addresses
  (
    empno REFERENCES emp(empno) ON DELETE CASCADE,
    addr_type VARCHAR2(10),
    street    VARCHAR2(20),
    city      VARCHAR2(20),
    state     VARCHAR2(2),
    zip       NUMBER,
    PRIMARY KEY (empno, addr_type)
  );

-- Creating table iot_addresses
CREATE TABLE iot_addresses
  (
        empno REFERENCES emp(empno) ON DELETE CASCADE,
        addr_type VARCHAR2(10),
        street    VARCHAR2(20),
        city      VARCHAR2(20),
        state     VARCHAR2(2),
        zip       NUMBER,
        PRIMARY KEY (empno,addr_type)
  )
  ORGANIZATION INDEX;
  
-- Inserting data
INSERT INTO heap_addresses
SELECT empno, 'WORK' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
  
INSERT INTO iot_addresses
SELECT empno , 'WORK' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
--
INSERT INTO heap_addresses
SELECT empno, 'HOME' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
  
INSERT INTO iot_addresses
SELECT empno, 'HOME' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
--
INSERT INTO heap_addresses
SELECT empno, 'PREV' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
  
INSERT INTO iot_addresses
SELECT empno, 'PREV' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
--
INSERT INTO heap_addresses
SELECT empno, 'SCHOOL' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
  
INSERT INTO iot_addresses
SELECT empno, 'SCHOOL' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;

Commit;

-- Calculating statistics
exec dbms_stats.gather_table_stats( 'ASlizh', 'HEAP_ADDRESSES' );
exec dbms_stats.gather_table_stats( 'ASlizh', 'IOT_ADDRESSES' );

-- Comparing selection on heap table and index orgonized table

-- Example 1 (heap table)
explain plan for
SELECT *
   FROM emp ,
        heap_addresses
  WHERE emp.empno = heap_addresses.empno
  AND emp.empno   = 42;

select * from table(dbms_xplan.display );
  
-- Example 2 (index orgonized table)
explain plan for
SELECT *
   FROM emp ,
        iot_addresses
  WHERE emp.empno = iot_addresses.empno
  AND emp.empno   = 42; 

select * from table(dbms_xplan.display );

-- Cleaning schema
drop table heap_addresses;
drop table iot_addresses;
drop table emp;
