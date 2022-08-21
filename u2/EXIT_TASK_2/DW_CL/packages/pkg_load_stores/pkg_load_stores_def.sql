ALTER SESSION SET CURRENT_SCHEMA = dw_cl;
CREATE OR REPLACE PACKAGE pkg_load_stores

AS
    PROCEDURE load_stores;
END pkg_load_stores;