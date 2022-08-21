ALTER SESSION SET CURRENT_SCHEMA = dw_cl;
CREATE OR REPLACE PACKAGE BODY pkg_load_customers
IS
    PROCEDURE load_customers
    IS
        CURSOR c IS
            SELECT DISTINCT first_name,
                            last_name,
                            phone,
                            country,
                            email,
                            birthday
            FROM sa_customers.sa_customer_data;
    BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE dw_cl_customer_data';
        FOR i IN c LOOP
            INSERT INTO dw_cl_customer_data(
                            first_name,
                            last_name,
                            phone,
                            country,
                            email,
                            birthday)
                    VALUES (i.first_name,
                            i.last_name,
                            i.phone,
                            i.country,
                            i.email,
                            i.birthday);
            EXIT WHEN c%NOTFOUND;
        END LOOP;
        COMMIT;
    END load_customers;
END pkg_load_customers;