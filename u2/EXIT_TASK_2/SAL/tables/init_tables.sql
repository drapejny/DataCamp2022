-- Create users and tablespaces
CREATE TABLESPACE ts_sal_fcts_01
DATAFILE '/oracle/u02/oradata/ASlizhdb/ts_sal_fcts_01.dat'
SIZE 150M
AUTOEXTEND ON NEXT 50M
SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_sal_dims_01
DATAFILE '/oracle/u02/oradata/ASlizhdb/ts_sal_dims_01.dat'
SIZE 150M
AUTOEXTEND ON NEXT 50M
SEGMENT SPACE MANAGEMENT AUTO;

CREATE USER SAL_DATA
IDENTIFIED BY "%PWD%"
DEFAULT TABLESPACE ts_sa_fct_sales_01;

GRANT CONNECT, CREATE VIEW, RESOURCE TO SAL_DATA;
ALTER USER sal_data QUOTA UNLIMITED ON ts_sal_fcts_01;
ALTER USER sal_data QUOTA UNLIMITED ON ts_sal_dims_01;


--================================
-- DIM_STORES
--================================
DROP TABLE sal_data.dim_stores;
CREATE TABLE sal_data.dim_stores
(
    store_id NUMBER NOT NULL,
    address VARCHAR2(50 CHAR) NOT NULL,
    country VARCHAR2(50 CHAR) NOT NULL,
    region VARCHAR2(50 CHAR) NOT NULL,
    city VARCHAR2(50 CHAR) NOT NULL,
    phone VARCHAR2(20 CHAR) NOT NULL,
    insert_dt DATE NOT NULL,
    update_dt DATE NOT NULL,
    CONSTRAINT PK_DIM_STORES PRIMARY KEY (store_id)
) TABLESPACE ts_sal_dims_01;

--================================
-- DIM_CUSTOMERS
--================================
DROP TABLE sal_data.dim_customers;
CREATE TABLE sal_data.dim_customers
(
    customer_id NUMBER NOT NULL,
    first_name VARCHAR2(50 CHAR) NOT NULL,
    last_name VARCHAR2(50 CHAR) NOT NULL,
    phone VARCHAR2(50 CHAR) NOT NULL,
    country VARCHAR2(200 CHAR) NOT NULL,
    email VARCHAR2(100 CHAR) NOT NULL,
    birthday DATE NOT NULL,
    insert_dt DATE NOT NULL,
    update_dt DATE NOT NULL,
    CONSTRAINT PK_DIM_CUSTOMERS PRIMARY KEY (customer_id)
) TABLESPACE ts_sal_dims_01;

--================================
-- DIM_DATES
--================================
DROP TABLE sal_data.dim_dates;
CREATE TABLE sal_data.dim_dates
(
    date_id DATE NOT NULL,
    day_name VARCHAR2(44) NOT NULL,
    day_number_in_week VARCHAR2(1 BYTE) NOT NULL,
    day_number_in_month VARCHAR2(2 BYTE) NOT NULL,
    day_number_in_year VARCHAR2(3 BYTE) NOT NULL,
    calendar_week_number VARCHAR2(1 BYTE) NOT NULL,
    week_ending_date DATE NOT NULL,
    calendar_month_number VARCHAR2(2 BYTE) NOT NULL,
    days_in_cal_month VARCHAR2(2 BYTE) NOT NULL,
    end_of_cal_month DATE NOT NULL,
    calendar_month_name VARCHAR2(32 BYTE) NOT NULL,
    days_in_cal_quarter NUMBER NOT NULL,
    beg_of_cal_quarter DATE NOT NULL,
    end_of_cal_quarter DATE NOT NULL,
    calendar_quarter_number VARCHAR2(1 BYTE) NOT NULL,
    calendar_year VARCHAR2(4 BYTE) NOT NULL,
    days_in_cal_year NUMBER NOT NULL,
    beg_of_cal_year DATE NOT NULL,
    end_of_cal_year DATE NOT NULL,
    CONSTRAINT PK_DIM_DATES PRIMARY KEY (date_id)
) TABLESPACE ts_sal_dims_01;

--=================================
-- DIM_GEO_LOCATIONS
--=================================
DROP TABLE sal_data.dim_geo_locations;
CREATE TABLE sal_data.dim_geo_locations (
   geo_id          NUMBER NOT NULL,
   group_id        NUMBER(22,0),
   group_desc      VARCHAR2(200),
   sub_group_id    NUMBER(22,0),
   sub_group_desc  VARCHAR2(200),
   system_code     VARCHAR2(30 CHAR),
   system_desc     VARCHAR2(200),
   region_desc     VARCHAR2(200),
   country_code_a2  VARCHAR2(30 CHAR),
   country_code_a3  VARCHAR2(30 CHAR),
   country_desc    VARCHAR2(200) NOT NULL,
   part_id         NUMBER(22,0),
   part_desc       VARCHAR2(200),
   CONSTRAINT PK_DIM_GEO_LOCATIONS PRIMARY KEY (geo_id)
) TABLESPACE ts_sal_dims_01;

--================================
-- DIM_PRODUCTS_SCD
--================================
DROP TABLE sal_data.dim_products_scd;
CREATE TABLE sal_data.dim_products_scd (
    product_id NUMBER NOT NULL,
    product_src_id VARCHAR2(50 CHAR) NOT NULL,
    price NUMBER(6, 2) NOT NULL,
    description VARCHAR2(100 CHAR) NOT NULL,
    type VARCHAR2(25 CHAR) NOT NULL,
    brand VARCHAR2(80 CHAR) NOT NULL,
    producer_country VARCHAR2(50 CHAR) NOT NULL,
    volume NUMBER(12) NOT NULL,
    shelf_width NUMBER(6, 2) NOT NULL,
    shelf_hight NUMBER(6, 2) NOT NULL,
    shelf_depth NUMBER(6, 2) NOT NULL,
    package VARCHAR2(50 CHAR) NOT NULL,
    package_color VARCHAR2(50 CHAR) NOT NULL,
    package_reusable VARCHAR2(50 CHAR) NOT NULL,
    taste VARCHAR2(80 CHAR) NOT NULL,
    alcohol NUMBER(6, 2) NOT NULL,
    start_dt DATE NOT NULL,
    end_dt DATE NOT NULL,
    CONSTRAINT PK_DIM_PRODUCTS PRIMARY KEY (product_id)
) TABLESPACE ts_sal_dims_01;

--===================================
-- FCT_SALES
--==================================
DROP TABLE sal_data.fct_sales;
CREATE TABLE sal_data.fct_sales
(
   sale_id            NUMBER,
   date_id            DATE,
   product_id         NUMBER,
   customer_id        NUMBER,
   store_id           NUMBER,
   geo_id             NUMBER,
   amount             NUMBER(5),
   sum                NUMBER(10,2),
   pos_transaction    VARCHAR2(20 CHAR),
   insert_dt          DATE,
   CONSTRAINT PK_FCT_SALES PRIMARY KEY (sale_id)
) TABLESPACE ts_sal_fcts_01;