ALTER SESSION SET CURRENT_SCHEMA = dw_cl;
CREATE OR REPLACE PACKAGE BODY pkg_load_stores
IS
    PROCEDURE load_stores
    IS
        CURSOR c IS
            SELECT DISTINCT address,
                            country,
                            region,
                            city,
                            phone
            FROM sa_products.sa_store_data;
    BEGIN
        FOR i IN c LOOP
            INSERT INTO dw_cl_store_data(
                            address,
                            country,
                            region,
                            city,
                            phone)
                    VALUES (i.address,
                            i.country,
                            i.region,
                            i.city,
                            i.phone);
            EXIT WHEN c%NOTFOUND;
        END LOOP;
        COMMIT;
    END load_stores;
END pkg_load_stores;