ALTER SESSION SET CURRENT_SCHEMA = sal_data;
--GRANT SELECT ON dw_data.dw_stores TO sal_data;
CREATE OR REPLACE PACKAGE BODY pkg_load_stores
IS
    PROCEDURE load_stores
    IS
    BEGIN
        MERGE INTO sal_data.dim_stores sal
            USING (SELECT store_id,
                          address,
                          country,
                          region,
                          city,
                          phone,
                          insert_dt,
                          update_dt
                    FROM dw_data.dw_stores) dw
            ON (sal.store_id = dw.store_id)
            WHEN MATCHED
                THEN
                    UPDATE SET  sal.address = dw.address,
                                sal.country = dw.country,
                                sal.region = dw.region,
                                sal.city = dw.city,
                                sal.phone = dw.phone,
                                sal.update_dt = dw.update_dt
            WHEN NOT MATCHED
                THEN
                    INSERT VALUES(dw.store_id,
                                  dw.address,
                                  dw.country,
                                  dw.region,
                                  dw.city,
                                  dw.phone,
                                  dw.insert_dt,
                                  dw.update_dt);
    END load_stores;
END pkg_load_stores;