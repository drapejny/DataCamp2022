ALTER SESSION SET CURRENT_SCHEMA = sal_data;
CREATE OR REPLACE PACKAGE pkg_load_dates

AS
    PROCEDURE load_dates;
END pkg_load_dates;