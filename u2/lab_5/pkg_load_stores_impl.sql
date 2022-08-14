ALTER SESSION SET CURRENT_SCHEMA = dw_data;
--GRANT SELECT ON dw_cl.dw_cl_store_data TO dw_data;
CREATE OR REPLACE PACKAGE BODY pkg_load_stores
IS
--====================================
-- Loading stores to DW layer
--====================================
 PROCEDURE load_stores
    IS
        TYPE store_rows_t IS TABLE OF dw_data.dw_store_data%ROWTYPE;

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
                            cl.phone
            FROM dw_cl.dw_cl_store_data cl
            LEFT JOIN dw_data.dw_store_data dw
            ON cl.address = dw.address
            WHERE dw.store_id IS NULL;

        FETCH c_store

        BULK COLLECT INTO new_stores;

        FORALL i IN 1 .. new_stores.COUNT()
                INSERT INTO dw_data.dw_store_data
                (   
                    store_id,
                    address,
                    country,
                    region,
                    city,
                    phone
                )
                VALUES
                (
                    dw_data.seq_stores.NEXTVAL,
                    new_stores(i).address,
                    new_stores(i).country,
                    new_stores(i).region,
                    new_stores(i).city,
                    new_stores(i).phone
                );
        COMMIT;

        CLOSE c_store;

        OPEN c_store FOR
            SELECT DISTINCT dw.store_id,
                            cl.address,
                            cl.country,
                            cl.region,
                            cl.city,
                            cl.phone
            FROM dw_cl.dw_cl_store_data cl
            LEFT JOIN dw_data.dw_store_data dw
            ON cl.address = dw.address
            WHERE dw.store_id IS NOT NULL;

        FETCH c_store
        BULK COLLECT INTO update_stores;

        FORALL i IN 1 .. update_stores.COUNT()
            UPDATE dw_data.dw_store_data
            SET address = update_stores(i).address,
                country = update_stores(i).country,
                region = update_stores(i).region,
                city = update_stores(i).city,
                phone = update_stores(i).phone
            WHERE store_id = update_stores(i).store_id;
        COMMIT;

        CLOSE c_store;

    END load_stores;
--====================================
-- Loading using EXECUTE IMMEDIATE
--====================================
 PROCEDURE load_stores_exec_immed
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

    END load_stores_exec_immed;

--====================================
-- Loading using TO_REFCURSOR function
--====================================

 PROCEDURE load_stores_to_refcursor_func
    IS
        cursor_id NUMBER;
        cur_count NUMBER;
        query_text VARCHAR2(500);
        TYPE ref_cursor_t IS REF CURSOR;
        ref_cursor ref_cursor_t;
        store_row dw_data.dw_store_data%ROWTYPE;

    BEGIN
        query_text := 'SELECT DISTINCT dw.store_id,
                            cl.address,
                            cl.country,
                            cl.region,
                            cl.city,
                            cl.phone
            FROM dw_cl.dw_cl_store_data cl
            LEFT JOIN dw_data.dw_store_data dw
            ON cl.address = dw.address';

        cursor_id := DBMS_SQL.open_cursor;

        DBMS_SQL.PARSE(cursor_id, query_text, DBMS_SQL.NATIVE);

        cur_count := DBMS_SQL.EXECUTE(cursor_id);

        ref_cursor := DBMS_SQL.TO_REFCURSOR(cursor_id);

        LOOP
        FETCH ref_cursor INTO store_row;
            EXIT WHEN ref_cursor%NOTFOUND;
            IF store_row.store_id IS NULL THEN
             INSERT INTO dw_data.dw_store_data
                    VALUES (
                            dw_data.seq_stores.NEXTVAL,
                            store_row.address,
                            store_row.country,
                            store_row.region,
                            store_row.city,
                            store_row.phone
                           );
            ELSE
                UPDATE dw_data.dw_store_data 
                SET address = store_row.address,
                    country = store_row.country,
                    region = store_row.region,
                    city = store_row.city,
                    phone = store_row.phone
                WHERE store_id = store_row.store_id;
            END IF;
        END LOOP;

        CLOSE ref_cursor;

        COMMIT;

    END load_stores_to_refcursor_func;

--====================================
-- Loading using TO_CURSOR_NUMBER function
--====================================
PROCEDURE load_stores_to_cursor_number
    IS
        curid NUMBER; 
        desctab DBMS_SQL.desc_tab;  
        colcnt NUMBER;
        store_row dw_data.dw_store_data%ROWTYPE;
        varchar2_val VARCHAR2(500);
        number_val NUMBER;
        query_text VARCHAR2(500);
        TYPE curtype IS REF CURSOR;
        src_cur curtype;
    BEGIN
        query_text := 'SELECT DISTINCT dw.store_id,
                            cl.address,
                            cl.country,
                            cl.region,
                            cl.city,
                            cl.phone
            FROM dw_cl.dw_cl_store_data cl
            LEFT JOIN dw_data.dw_store_data dw
            ON cl.address = dw.address';

        OPEN src_cur FOR query_text;

        curid := DBMS_SQL.TO_CURSOR_NUMBER(src_cur);

        DBMS_SQL.describe_columns(curid, colcnt, desctab);

        FOR i IN 1 .. colcnt
        LOOP
            CASE desctab(i).col_type
                WHEN 1 THEN DBMS_SQL.define_column (curid, i, varchar2_val, 4000);
                WHEN 2 THEN DBMS_SQL.define_column (curid, i, number_val);
                ELSE DBMS_SQL.define_column (curid, i, varchar2_val, 4000);
            END CASE;

        END LOOP;

        WHILE DBMS_SQL.FETCH_ROWS(curid) > 0
        LOOP
            FOR i IN 1 .. colcnt
            LOOP
                CASE desctab(i).col_type
                    WHEN 1 THEN
                        DBMS_SQL.COLUMN_VALUE (curid, i, varchar2_val);
                        CASE desctab(i).col_name
                            WHEN 'ADDRESS' THEN store_row.address := varchar2_val;
                            WHEN 'COUNTRY' THEN store_row.country := varchar2_val;
                            WHEN 'REGION' THEN store_row.region := varchar2_val;
                            WHEN 'CITY' THEN store_row.city := varchar2_val;
                            WHEN 'PHONE' THEN store_row.phone := varchar2_val;
                        END CASE;
                    WHEN 2 THEN
                        DBMS_SQL.COLUMN_VALUE (curid, i, number_val);
                        CASE desctab(i).col_name
                             WHEN 'STORE_ID' THEN store_row.store_id := number_val;
                        END CASE;
                END CASE;
            END LOOP;

            IF store_row.store_id IS NULL THEN
                INSERT INTO dw_data.dw_store_data
                    VALUES (
                            dw_data.seq_stores.NEXTVAL,
                            store_row.address,
                            store_row.country,
                            store_row.region,
                            store_row.city,
                            store_row.phone
                           );
            ELSE
                UPDATE dw_data.dw_store_data 
                SET address = store_row.address,
                    country = store_row.country,
                    region = store_row.region,
                    city = store_row.city,
                    phone = store_row.phone
                WHERE store_id = store_row.store_id;
            END IF;
        END LOOP;

        COMMIT;
        
    END load_stores_to_cursor_number;
END pkg_load_stores;