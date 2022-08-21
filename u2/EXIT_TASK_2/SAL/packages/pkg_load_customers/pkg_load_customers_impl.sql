ALTER SESSION SET CURRENT_SCHEMA = sal_data;
--GRANT SELECT ON dw_data.dw_customers TO sal_data;
CREATE OR REPLACE PACKAGE BODY pkg_load_customers
IS
    PROCEDURE load_customers
    IS
    BEGIN
        MERGE INTO sal_data.dim_customers sal
            USING (SELECT  customer_id,
                           first_name,
                           last_name,
                           phone,
                           country,
                           email,
                           birthday,
                           insert_dt,
                           update_dt
                    FROM dw_data.dw_customers) dw
            ON (sal.customer_id = dw.customer_id)
            WHEN MATCHED
                THEN
                    UPDATE SET sal.first_name = dw.first_name,
                               sal.last_name = dw.last_name,
                               sal.phone = dw.phone,
                               sal.country = dw.country,
                               sal.email = dw.email,
                               sal.birthday = dw.birthday,
                               sal.update_dt = dw.update_dt
            WHEN NOT MATCHED
                THEN
                    INSERT VALUES(dw.customer_id,
                                  dw.first_name,
                                  dw.last_name,
                                  dw.phone,
                                  dw.country,
                                  dw.email,
                                  dw.birthday,
                                  dw.insert_dt,
                                  dw.update_dt);
        COMMIT;
    END load_customers;
END pkg_load_customers;