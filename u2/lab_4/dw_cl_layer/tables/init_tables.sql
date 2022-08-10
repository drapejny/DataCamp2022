--================================
-- DW_CL_PRODUCT_DATA
--================================
DROP TABLE dw_cl.dw_cl_product_data;
CREATE TABLE dw_cl.dw_cl_product_data
(
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
    alcohol NUMBER(6, 2) NOT NULL
) TABLESPACE ts_dw_cl_01;

--================================
-- DW_CL_STORE_DATA
--================================
DROP TABLE dw_cl.dw_cl_store_data;
CREATE TABLE dw_cl.dw_cl_store_data
(
    address VARCHAR2(50 CHAR) NOT NULL,
    country VARCHAR2(50 CHAR) NOT NULL,
    region VARCHAR2(50 CHAR) NOT NULL,
    city VARCHAR2(50 CHAR) NOT NULL,
    phone VARCHAR2(20 CHAR) NOT NULL
) TABLESPACE ts_dw_cl_01;

--================================
-- DW_CL_CUSTOMER_DATA
--================================
DROP TABLE dw_cl.dw_cl_customer_data;
CREATE TABLE dw_cl.dw_cl_customer_data
(
    first_name VARCHAR2(50 CHAR) NOT NULL,
    last_name VARCHAR2(50 CHAR) NOT NULL,
    phone VARCHAR2(50 CHAR) NOT NULL,
    country VARCHAR2(200 CHAR) NOT NULL,
    email VARCHAR2(100 CHAR) NOT NULL,
    birthday DATE NOT NULL
) TABLESPACE ts_dw_cl_01;

--=================================
-- DW_CL_SALE_DATA
--=================================
DROP TABLE dw_cl.dw_cl_sale_data;
CREATE TABLE dw_cl.dw_cl_sale_data
(
    date_id DATE NOT NULL,
    first_name VARCHAR2(50 CHAR) NOT NULL,
    last_name VARCHAR2(50 CHAR) NOT NULL,
    phone VARCHAR2(50 CHAR) NOT NULL,
    product_name VARCHAR2(100 CHAR) NOT NULL,
    product_type VARCHAR2(25 CHAR) NOT NULL,
    product_brand VARCHAR2(80 CHAR) NOT NULL,
    sku_num VARCHAR2(50 CHAR) NOT NULL,
    store_address VARCHAR2(50 CHAR) NOT NULL,
    country VARCHAR2(50 CHAR) NOT NULL,
    price NUMBER(12) NOT NULL,
    pos_transaction VARCHAR2(20 CHAR) NOT NULL
) TABLESPACE ts_dw_cl_01;