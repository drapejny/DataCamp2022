ALTER SESSION SET CURRENT_SCHEMA = dw_data;
CREATE OR REPLACE PACKAGE pkg_load_geo_locations

AS
    PROCEDURE load_geo_locations;
END pkg_load_geo_locations;