ALTER SESSION SET CURRENT_SCHEMA = sal_data;
CREATE OR REPLACE PACKAGE pkg_load_sales

AS
    PROCEDURE load_sales;
END pkg_load_sales;