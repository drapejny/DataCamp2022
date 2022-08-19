ALTER SESSION SET CURRENT_SCHEMA = dw_data;
--GRANT SELECT ON dw_cl.dw_cl_customer_data TO dw_data;
CREATE OR REPLACE PACKAGE BODY pkg_load_customers
IS
    PROCEDURE load_customers
    IS
        TYPE customer_rows_t IS TABLE OF dw_data.dw_customers%ROWTYPE;

        TYPE customer_t IS REF CURSOR;

        c_customer customer_t;

        new_customers customer_rows_t;
        update_customers customer_rows_t;

    BEGIN
        OPEN c_customer FOR
            SELECT DISTINCT dw.customer_id,
                            cl.first_name,
                            cl.last_name,
                            cl.phone,
                            cl.country,
                            cl.email,
                            cl.birthday,
                            dw.insert_dt,
                            dw.update_dt
            FROM dw_cl.dw_cl_customer_data cl
            LEFT JOIN dw_data.dw_customers dw
            ON cl.phone = dw.phone
            WHERE dw.customer_id IS NULL;

        FETCH c_customer

        BULK COLLECT INTO new_customers;

        FORALL i IN 1 .. new_customers.COUNT()
                INSERT INTO dw_data.dw_customers
                (   
                    customer_id,
                    first_name,
                    last_name,
                    phone,
                    country,
                    email,
                    birthday,
                    insert_dt,
                    update_dt
                )
                VALUES
                (
                    dw_data.seq_customers.NEXTVAL,
                    new_customers(i).first_name,
                    new_customers(i).last_name,
                    new_customers(i).phone,
                    new_customers(i).country,
                    new_customers(i).email,
                    new_customers(i).birthday,
                    SYSDATE,
                    SYSDATE
                );
        COMMIT;
        
        CLOSE c_customer;

        OPEN c_customer FOR
            SELECT DISTINCT dw.customer_id,
                            cl.first_name,
                            cl.last_name,
                            cl.phone,
                            cl.country,
                            cl.email,
                            cl.birthday,
                            dw.insert_dt,
                            dw.update_dt
            FROM dw_cl.dw_cl_customer_data cl
            LEFT JOIN dw_data.dw_customers dw
            ON cl.phone = dw.phone
            WHERE dw.customer_id IS NOT NULL;

        FETCH c_customer
        BULK COLLECT INTO update_customers;

        FORALL i IN 1 .. update_customers.COUNT()
            UPDATE dw_data.dw_customers
            SET first_name = update_customers(i).first_name,
                last_name = update_customers(i).last_name,
                phone = update_customers(i).phone,
                country = update_customers(i).country,
                email = update_customers(i).email,
                birthday = update_customers(i).birthday,
                update_dt = SYSDATE
            WHERE customer_id = update_customers(i).customer_id;
        COMMIT;
        
        CLOSE c_customer;

    END load_customers;
END pkg_load_customers;