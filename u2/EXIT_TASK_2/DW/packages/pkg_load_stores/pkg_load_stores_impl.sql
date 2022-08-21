ALTER SESSION SET CURRENT_SCHEMA = dw_data;
--GRANT SELECT ON dw_cl.dw_cl_store_data TO dw_data;
CREATE OR REPLACE PACKAGE BODY pkg_load_stores
IS
    PROCEDURE load_stores
    IS
        TYPE store_rows_t IS TABLE OF dw_data.dw_stores%ROWTYPE;

        TYPE store_t IS REF CURSOR;

        c_store store_t;

        new_stores store_rows_t;
        update_stores store_rows_t;

    BEGIN
        OPEN c_store FOR
            SELECT DISTINCT dw.store_id,
                            cl.address,
                            cl.country,
                            cl.region,
                            cl.city,
                            cl.phone,
                            dw.insert_dt,
                            dw.update_dt
            FROM dw_cl.dw_cl_store_data cl
            LEFT JOIN dw_data.dw_stores dw
            ON cl.address = dw.address
            WHERE dw.store_id IS NULL;

        FETCH c_store

        BULK COLLECT INTO new_stores;

        FORALL i IN 1 .. new_stores.COUNT()
                INSERT INTO dw_data.dw_stores
                (   
                    store_id,
                    address,
                    country,
                    region,
                    city,
                    phone,
                    insert_dt,
                    update_dt
                )
                VALUES
                (
                    dw_data.seq_stores.NEXTVAL,
                    new_stores(i).address,
                    new_stores(i).country,
                    new_stores(i).region,
                    new_stores(i).city,
                    new_stores(i).phone,
                    SYSDATE,
                    SYSDATE
                );
        COMMIT;
        
        CLOSE c_store;

        OPEN c_store FOR
            SELECT DISTINCT dw.store_id,
                            cl.address,
                            cl.country,
                            cl.region,
                            cl.city,
                            cl.phone,
                            dw.insert_dt,
                            dw.update_dt
            FROM dw_cl.dw_cl_store_data cl
            LEFT JOIN dw_data.dw_stores dw
            ON cl.address = dw.address
            WHERE dw.store_id IS NOT NULL;

        FETCH c_store
        BULK COLLECT INTO update_stores;

        FORALL i IN 1 .. update_stores.COUNT()
            UPDATE dw_data.dw_stores
            SET address = update_stores(i).address,
                country = update_stores(i).country,
                region = update_stores(i).region,
                city = update_stores(i).city,
                phone = update_stores(i).phone,
                update_dt = SYSDATE
            WHERE store_id = update_stores(i).store_id;
        COMMIT;
        
        CLOSE c_store;

    END load_stores;
END pkg_load_stores;