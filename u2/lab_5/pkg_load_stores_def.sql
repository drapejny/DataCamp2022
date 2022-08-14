ALTER SESSION SET CURRENT_SCHEMA = dw_data;
CREATE OR REPLACE PACKAGE pkg_load_stores

AS
    PROCEDURE load_stores;
    PROCEDURE load_stores_exec_immed;
    PROCEDURE load_stores_to_refcursor_func;
    PROCEDURE load_stores_to_cursor_number;
END pkg_load_stores;