ALTER SESSION SET CURRENT_SCHEMA = dw_cl;
CREATE OR REPLACE PACKAGE BODY pkg_load_sales
AS
    PROCEDURE load_sales
    AS 
        TYPE sales_t IS TABLE OF dw_cl.dw_cl_sale_data%ROWTYPE;
        sales sales_t;
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
        OPEN c;
        LOOP
            FETCH c
            BULK COLLECT INTO sales;
            FORALL i IN 1 .. sales.COUNT()
                INSERT INTO dw_cl_sale_data VALUES sales(i);
EXIT WHEN c%NOTFOUND;
END LOOP;
CLOSE c;
COMMIT;
    END load_sales;
END pkg_load_sales;