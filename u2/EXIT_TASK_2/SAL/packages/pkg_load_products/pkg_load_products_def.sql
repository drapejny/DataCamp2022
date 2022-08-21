ALTER SESSION SET CURRENT_SCHEMA = sal_data;
CREATE OR REPLACE PACKAGE pkg_load_products

AS
    PROCEDURE load_products;
END pkg_load_products;