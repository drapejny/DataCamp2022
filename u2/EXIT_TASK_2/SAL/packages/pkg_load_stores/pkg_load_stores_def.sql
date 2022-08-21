ALTER SESSION SET CURRENT_SCHEMA = sal_data;
CREATE OR REPLACE PACKAGE pkg_load_stores

AS
    PROCEDURE load_stores;
END pkg_load_stores;