ALTER SESSION SET CURRENT_SCHEMA = dw_cl;
CREATE OR REPLACE PACKAGE BODY pkg_load_sales
IS
    PROCEDURE load_sales
    IS
        CURSOR c IS
            SELECT DISTINCT date_id,
                            first_name,
                            last_name,
                            phone,
                            product_name,
                            product_type,
                            product_brand,
                            sku_num,
                            store_address,
                            country,
                            price,
                            pos_transaction
            FROM sa_customers.sa_sale_data;
    BEGIN
        FOR i IN c LOOP
            INSERT INTO dw_cl_sale_data(
                            date_id,
                            first_name,
                            last_name,
                            phone,
                            product_name,
                            product_type,
                            product_brand,
                            sku_num,
                            store_address,
                            country,
                            price,
                            pos_transaction)
                    VALUES (i.date_id,
                            i.first_name,
                            i.last_name,
                            i.phone,
                            i.product_name,
                            i.product_type,
                            i.product_brand,
                            i.sku_num,
                            i.store_address,
                            i.country,
                            i.price,
                            i.pos_transaction);
            EXIT WHEN c%NOTFOUND;
        END LOOP;
        COMMIT;
    END load_sales;
END pkg_load_sales;