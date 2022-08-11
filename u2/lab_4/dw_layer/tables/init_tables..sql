--================================
-- DW_PRODUCT_DATA
--================================
DROP TABLE dw_data.dw_product_data;
CREATE TABLE dw_data.dw_product_data
(
    product_id NUMBER NOT NULL,
    sku_num VARCHAR2(50 CHAR) NOT NULL,
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
    CONSTRAINT PK_DW_PRODUCT_DATA PRIMARY KEY (product_id)
) TABLESPACE ts_dw_data_01;

DROP SEQUENCE dw_data.seq_products;
CREATE SEQUENCE dw_data.seq_products
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

--================================
-- DW_STORE_DATA
--================================
DROP TABLE dw_data.dw_store_data;
CREATE TABLE dw_data.dw_store_data
(
    store_id NUMBER NOT NULL,
    address VARCHAR2(50 CHAR) NOT NULL,
    country VARCHAR2(50 CHAR) NOT NULL,
    region VARCHAR2(50 CHAR) NOT NULL,
    city VARCHAR2(50 CHAR) NOT NULL,
    phone VARCHAR2(20 CHAR) NOT NULL,
    CONSTRAINT PK_DW_STORE_DATA PRIMARY KEY (store_id)
) TABLESPACE ts_dw_data_01;

DROP SEQUENCE dw_data.seq_stores;
CREATE SEQUENCE dw_data.seq_stores
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

--================================
-- DW_CUSTOMER_DATA
--================================
DROP TABLE dw_data.dw_customer_data;
CREATE TABLE dw_data.dw_customer_data
(
    customer_id NUMBER NOT NULL,
    first_name VARCHAR2(50 CHAR) NOT NULL,
    last_name VARCHAR2(50 CHAR) NOT NULL,
    phone VARCHAR2(50 CHAR) NOT NULL,
    country VARCHAR2(200 CHAR) NOT NULL,
    email VARCHAR2(100 CHAR) NOT NULL,
    birthday DATE NOT NULL,
    CONSTRAINT PK_DW_CUSTOMER_DATA PRIMARY KEY (customer_id)
) TABLESPACE ts_dw_data_01;

DROP SEQUENCE dw_data.seq_customers;
CREATE SEQUENCE dw_data.seq_customers
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

--================================
-- DW_DATE_DATA
--================================
DROP TABLE dw_data.dw_date_data;
CREATE TABLE dw_data.dw_date_data
(
    date_id DATE,
    day_name VARCHAR2(44),
    day_number_in_week VARCHAR2(1 BYTE),
    day_number_in_month VARCHAR2(2 BYTE),
    day_number_in_year VARCHAR2(3 BYTE),
    calendar_week_number VARCHAR2(1 BYTE),  
    week_ending_date DATE,
    calendar_month_number VARCHAR2(2 BYTE),
    days_in_cal_month VARCHAR2(2 BYTE),
    end_of_cal_month DATE,
    calendar_month_name VARCHAR2(32 BYTE), 
    days_in_cal_quarter NUMBER,
    beg_of_cal_quarter DATE, 
    end_of_cal_quarter DATE,
    calendar_quarter_number VARCHAR2(1 BYTE),
    calendar_year VARCHAR2(4 BYTE),
    days_in_cal_year NUMBER,
    beg_of_cal_year DATE,
    end_of_cal_year DATE,
    CONSTRAINT PK_DW_DATE_DATA PRIMARY KEY (date_id)
) TABLESPACE ts_dw_data_01;