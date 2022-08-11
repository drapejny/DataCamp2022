ALTER SESSION SET current_schema = sa_products;

drop table sa_product_data;
drop table sa_store_data;

-- Create sa_product_data
CREATE TABLE sa_product_data
(
    sku_num VARCHAR2(50 CHAR),
    price NUMBER(6, 2),
    description VARCHAR2(100 CHAR),
    type VARCHAR2(25 CHAR),
    brand VARCHAR2(80 CHAR),
    producer_country VARCHAR2(50 CHAR),
    volume NUMBER(12),
    shelf_width NUMBER(6, 2),
    shelf_hight NUMBER(6, 2),
    shelf_depth NUMBER(6, 2),
    package VARCHAR2(50 CHAR),
    package_color VARCHAR2(50 CHAR),
    package_reusable VARCHAR2(50 CHAR),
    taste VARCHAR2(80 CHAR),
    alcohol NUMBER(6, 2)
) TABLESPACE ts_sa_products_data_01;

-- Create sa_store_data
CREATE TABLE sa_store_data
(
    address VARCHAR2(50 CHAR),
    country VARCHAR2(50 CHAR),
    region VARCHAR2(50 CHAR),
    city VARCHAR2(50 CHAR),
    phone VARCHAR2(20 CHAR)
) TABLESPACE ts_sa_products_data_01;

ALTER SESSION SET current_schema = sa_customers;

DROP TABLE sa_customer_data;
DROP TABLE sa_sale_data;

-- Create sa_customer_data
CREATE TABLE sa_customer_data
(
    first_name VARCHAR2(50 CHAR),
    last_name VARCHAR2(50 CHAR),
    phone VARCHAR2(50 CHAR),
    country VARCHAR2(200 CHAR),
    email VARCHAR2(100 CHAR),
    birthday DATE
) TABLESPACE ts_sa_customers_data_01;


-- Create sa_sale_data
CREATE TABLE sa_sale_data
(
    date_id DATE NOT NULL,
    first_name VARCHAR2(50 CHAR),
    last_name VARCHAR2(50 CHAR),
    phone VARCHAR2(50 CHAR),
    product_name VARCHAR2(100 CHAR),
    product_type VARCHAR2(25 CHAR),
    product_brand VARCHAR2(80 CHAR),
    sku_num VARCHAR2(50 CHAR),
    store_address VARCHAR2(50 CHAR),
    country VARCHAR2(50 CHAR),
    amount NUMBER(5),
    pos_transaction VARCHAR2(20 CHAR)
) TABLESPACE ts_sa_customers_data_01;
