--================================
-- DIM_STORES
--================================
DROP TABLE dw_data.dim_stores;
DROP TABLE dw_data.dim_stores;
CREATE TABLE dw_data.dim_stores
(
    store_id NUMBER NOT NULL,
    address VARCHAR2(50 CHAR) NOT NULL,
    country VARCHAR2(50 CHAR) NOT NULL,
    region VARCHAR2(50 CHAR) NOT NULL,
    city VARCHAR2(50 CHAR) NOT NULL,
    phone VARCHAR2(20 CHAR) NOT NULL,
    CONSTRAINT PK_DIM_STORES PRIMARY KEY (store_id)
) TABLESPACE ts_dw_data_01;

DROP SEQUENCE dw_data.seq_stores;
CREATE SEQUENCE dw_data.seq_stores
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

--================================
-- DIM_CUSTOMERS
--================================
DROP TABLE dw_data.dim_customers;
CREATE TABLE dw_data.dim_customers
(
    customer_id NUMBER NOT NULL,
    first_name VARCHAR2(50 CHAR) NOT NULL,
    last_name VARCHAR2(50 CHAR) NOT NULL,
    phone VARCHAR2(50 CHAR) NOT NULL,
    country VARCHAR2(200 CHAR) NOT NULL,
    email VARCHAR2(100 CHAR) NOT NULL,
    birthday DATE NOT NULL,
    CONSTRAINT PK_DIM_CUSTOMERS PRIMARY KEY (customer_id)
) TABLESPACE ts_dw_data_01;

DROP SEQUENCE dw_data.seq_customers;
CREATE SEQUENCE dw_data.seq_customers
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

--================================
-- DIM_DATES
--================================
DROP TABLE dw_data.dim_dates;
CREATE TABLE dw_data.dim_dates
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
) TABLESPACE ts_dw_data_01;

--=================================
-- DIM_GEO_LOCATIONS
--=================================
DROP TABLE dw_data.dim_geo_locations;
CREATE TABLE dw_data.dim_geo_locations (
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
) TABLESPACE ts_dw_data_01;

--================================
-- DIM_PRODUCTS_SCD
--================================
DROP TABLE dw_data.dim_products_scd;
CREATE TABLE dw_data.dim_products_scd (
    product_id NUMBER NOT NULL,
    sku_num VARCHAR2(50 CHAR) NOT NULL,
    eff_time DATE,
    exp_time DATE,
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
    CONSTRAINT PK_DIM_PRODUCTS_SCD PRIMARY KEY (product_id)
) TABLESPACE ts_dw_data_01;

DROP SEQUENCE dw_data.seq_products;
CREATE SEQUENCE dw_data.seq_products
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

--===================================
-- FCT_SALES
--==================================
CREATE TABLE dw_data.fct_sales
(
   sale_id            NUMBER,
   date_id            DATE,
   product_id         NUMBER,
   customer_id        NUMBER,
   store_id           NUMBER,
   geo_id             NUMBER,
   amount             NUMBER(5),
   pos_transaction    VARCHAR2(20 CHAR),
   CONSTRAINT PK_FCT_SALES PRIMARY KEY (sale_id)
);

DROP SEQUENCE dw_data.seq_sales;
CREATE SEQUENCE dw_data.seq_sales
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

ALTER TABLE dw_data.fct_sales
   ADD CONSTRAINT FK_DIM_DATES foreign key (date_id)
      REFERENCES dw_data.dim_dates (date_id);

ALTER TABLE dw_data.fct_sales
   ADD CONSTRAINT FK_DIM_PRODUCTS_SCD foreign key (product_id)
      REFERENCES dw_data.dim_products_scd (product_id);

ALTER TABLE dw_data.fct_sales
   ADD CONSTRAINT FK_DIM_CUSTOMERS foreign key (customer_id)
      REFERENCES dw_data.dim_customers (customer_id);

ALTER TABLE dw_data.fct_sales
   ADD CONSTRAINT FK_DIM_STORES foreign key (store_id)
      REFERENCES dw_data.dim_stores (store_id);

ALTER TABLE dw_data.fct_sales
   ADD CONSTRAINT FK_DW_DIM_GEO_LOCATIONSforeign key (geo_id)
      REFERENCES dw_data.dim_geo_locations (geo_id);