ALTER SESSION SET CURRENT_SCHEMA = dw_data;
--GRANT SELECT ON dw_cl.dw_cl_store_data TO dw_data;
CREATE OR REPLACE PACKAGE BODY pkg_load_stores
IS
    PROCEDURE load_stores
    IS
        TYPE store_rows_t IS TABLE OF dw_data.dw_store_data%ROWTYPE;

        TYPE store_t IS REF CURSOR;

        c_store store_t;

        new_stores store_rows_t;
        update_stores store_rows_t;

        sql_insert_stmt VARCHAR2(500);
        sql_update_stmt VARCHAR2(500);

    BEGIN
        OPEN c_store FOR
            SELECT DISTINCT dw.store_id,
                            cl.address,
                            cl.country,
                            cl.region,
                            cl.city,
                            cl.phone
            FROM dw_cl.dw_cl_store_data cl
            LEFT JOIN dw_data.dw_store_data dw
            ON cl.address = dw.address;

        FETCH c_store

        BULK COLLECT INTO new_stores;

        CLOSE c_store;

        sql_insert_stmt := 'INSERT INTO dw_data.dw_store_data VALUES( :1, :2, :3, :4, :5, :6)';
        sql_update_stmt := 'UPDATE dw_data.dw_store_data SET address = :1, country = :2, region = :3, city = :4, phone = :5 WHERE store_id = :6';

        FOR i IN 1 .. new_stores.COUNT LOOP
            IF new_stores(i).store_id IS NULL THEN
                EXECUTE IMMEDIATE sql_insert_stmt
                USING dw_data.seq_stores.NEXTVAL, new_stores(i).address, new_stores(i).country, new_stores(i).region, new_stores(i).city, new_stores(i).phone;
            ELSE
                EXECUTE IMMEDIATE sql_update_stmt
                USING new_stores(i).address, new_stores(i).country, new_stores(i).region, new_stores(i).city, new_stores(i).phone, new_stores(i).store_id;
            END IF;
        END LOOP;
        
        COMMIT;
        
    END load_stores;
END pkg_load_stores;