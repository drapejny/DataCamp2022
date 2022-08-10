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