-- Creating table t with deferred segments creation
create table t 
    ( x int primary key,
      y clob,
      z blob );

-- Selecting empty user_segments table
select segment_name, segment_type from user_segments;

-- Clean up
drop table t;

-- Creating table with immediate segments creation
create table t 
    ( x int primary key,
      y clob,
      z blob ) SEGMENT CREATION IMMEDIATE;
      
-- Selecting segments
select segment_name, segment_type from user_segments;

-- Selecting metadata for t table object
SELECT DBMS_METADATA.GET_DDL('TABLE','T') FROM dual;
