ALTER SESSION SET CURRENT_SCHEMA = sal_data;
--GRANT SELECT ON dw_data.dw_sales TO sal_data;
CREATE OR REPLACE PACKAGE BODY pkg_load_sales
IS
    PROCEDURE load_sales
    IS
        TYPE sales_rows_t IS TABLE OF sal_data.fct_sales%ROWTYPE;

        sales sales_rows_t;
        
        CURSOR c IS
            SELECT  dw.sale_id,
                    dw.date_id,
                    pr.product_id,
                    dw.customer_id,
                    dw.store_id,
                    dw.geo_id,
                    dw.amount,
                    dw.pos_transaction,
                    dw.insert_dt,
                    dw.amount * pr.price AS sum
            FROM dw_data.dw_sales dw
            LEFT JOIN sal_data.fct_sales sal
            ON dw.sale_id = sal.sale_id
            LEFT JOIN sal_data.dim_products_scd pr
            ON dw.product_src_id = pr.product_src_id AND dw.insert_dt BETWEEN pr.start_dt AND pr.end_dt
            WHERE sal.sale_id IS NULL;

    BEGIN
        OPEN c;
        LOOP
            FETCH c
            BULK COLLECT INTO sales;
            FORALL i in 1 .. sales.COUNT()
                INSERT INTO sal_data.fct_sales
                            (
                                sale_id,
                                date_id,
                                product_id,
                                customer_id,
                                store_id,
                                geo_id,
                                amount,
                                sum,
                                pos_transaction,
                                insert_dt
                            )
                    VALUES 
                        (
                            sales(i).sale_id,
                            sales(i).date_id,
                            sales(i).product_id,
                            sales(i).customer_id,
                            sales(i).store_id,
                            sales(i).geo_id,
                            sales(i).amount,
                            sales(i).sum,
                            sales(i).pos_transaction,
                            sales(i).insert_dt
                        );
            EXIT WHEN c%NOTFOUND;
        END LOOP;
        CLOSE c;

        COMMIT;

    END load_sales;
END pkg_load_sales;