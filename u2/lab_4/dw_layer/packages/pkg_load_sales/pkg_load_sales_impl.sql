ALTER SESSION SET CURRENT_SCHEMA = dw_data;
--GRANT SELECT ON dw_cl.dw_cl_sale_data TO dw_data;
CREATE OR REPLACE PACKAGE BODY pkg_load_sales
IS
    PROCEDURE load_sales
    IS
        TYPE sales_rows_t IS TABLE OF dw_data.dw_sales%ROWTYPE;

        sales sales_rows_t;

        CURSOR c IS
            SELECT  1,
                    cl.date_id,
                    cl.sku_num AS product_src_id,
                    cu.customer_id,
                    st.store_id,
                    geo.geo_id,
                    cl.amount,
                    cl.pos_transaction,
                    SYSDATE AS insert_dt
            FROM dw_cl.dw_cl_sale_data cl
            LEFT JOIN dw_data.dw_customers cu
            ON cl.phone = cu.phone
            LEFT JOIN dw_data.dw_stores st
            ON cl.store_address = st.address
            LEFT JOIN dw_data.dw_geo_locations geo
            ON cl.country = geo.country_desc;

    BEGIN
        OPEN c;
        LOOP
            FETCH c
            BULK COLLECT INTO sales;
            FORALL i in 1 .. sales.COUNT()
                INSERT INTO dw_data.dw_sales
                            (
                                sale_id,
                                date_id,
                                product_src_id,
                                customer_id,
                                store_id,
                                geo_id,
                                amount,
                                pos_transaction,
                                insert_dt
                            )
                    VALUES 
                        (
                            seq_sales.NEXTVAL,
                            sales(i).date_id,
                            sales(i).product_src_id,
                            sales(i).customer_id,
                            sales(i).store_id,
                            sales(i).geo_id,
                            sales(i).amount,
                            sales(i).pos_transaction,
                            sales(i).insert_dt
                        );
            EXIT WHEN c%NOTFOUND;
        END LOOP;
        CLOSE c;

        COMMIT;

    END load_sales;
END pkg_load_sales;