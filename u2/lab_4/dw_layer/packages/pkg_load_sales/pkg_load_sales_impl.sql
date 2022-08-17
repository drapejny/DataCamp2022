ALTER SESSION SET CURRENT_SCHEMA = dw_data;
--GRANT SELECT ON dw_cl.dw_cl_sale_data TO dw_data;
CREATE OR REPLACE PACKAGE BODY pkg_load_sales
IS
    PROCEDURE load_sales
    IS
        TYPE sales_rows_t IS TABLE OF dw_data.fct_sales%ROWTYPE;

        sales sales_rows_t;

        CURSOR c IS
            SELECT  1,
                    cl.date_id,
                    pr.product_id,
                    cu.customer_id,
                    st.store_id,
                    geo.geo_id,
                    cl.amount,
                    cl.pos_transaction
            FROM dw_cl.dw_cl_sale_data cl
            JOIN dw_data.dim_products_scd  pr
            ON cl.sku_num = pr.sku_num AND pr.exp_time IS NULL
            JOIN dw_data.dim_customers cu
            ON cl.phone = cu.phone
            JOIN dw_data.dim_stores st
            ON cl.store_address = st.address
            JOIN dw_data.dim_geo_locations geo
            ON cl.country = geo.country_desc;

    BEGIN
        OPEN c;
        LOOP
            FETCH c
            BULK COLLECT INTO sales;
            FORALL i in 1 .. sales.COUNT()
                INSERT INTO dw_data.fct_sales
                            (
                                sale_id,
                                date_id,
                                product_id,
                                customer_id,
                                store_id,
                                geo_id,
                                amount,
                                pos_transaction
                            )
                    VALUES 
                        (
                            seq_sales.NEXTVAL,
                            sales(i).date_id,
                            sales(i).product_id,
                            sales(i).customer_id,
                            sales(i).store_id,
                            sales(i).geo_id,
                            sales(i).amount,
                            sales(i).pos_transaction
                        );
            EXIT WHEN c%NOTFOUND;
        END LOOP;
        CLOSE c;

        COMMIT;

    END load_sales;
END pkg_load_sales;