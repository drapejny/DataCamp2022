ALTER SESSION SET CURRENT_SCHEMA = dw_cl;
CREATE OR REPLACE PACKAGE pkg_load_customers

AS
    PROCEDURE load_customers;
END pkg_load_customers;