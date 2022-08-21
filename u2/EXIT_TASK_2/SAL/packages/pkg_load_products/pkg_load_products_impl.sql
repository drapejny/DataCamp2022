ALTER SESSION SET CURRENT_SCHEMA = sal_data;
--GRANT SELECT ON dw_data.dw_products TO sal_data;
CREATE OR REPLACE PACKAGE BODY pkg_load_products
IS
    PROCEDURE load_products
    IS
        CURSOR c IS
            SELECT
                    dw.product_id,
                    dw.product_src_id,
                    dw.price,
                    dw.description,
                    dw.type,
                    dw.brand,
                    dw.producer_country,
                    dw.volume,
                    dw.shelf_width,
                    dw.shelf_hight,
                    dw.shelf_depth,
                    dw.package,
                    dw.package_color,
                    dw.package_reusable,
                    dw.taste,
                    dw.alcohol,
                    dw.insert_dt
            FROM dw_data.dw_products dw
            LEFT JOIN sal_data.dim_products_scd sal
            ON dw.product_id = sal.product_id
            WHERE sal.product_id IS NULL
            ORDER BY dw.product_id, dw.insert_dt;
    BEGIN
        FOR i in c LOOP
            UPDATE sal_data.dim_products_scd
                SET end_dt = i.insert_dt
                WHERE product_src_id = i.product_src_id AND 
                      end_dt = TO_DATE('31.12.9999', 'dd.MM.yyyy');
            INSERT INTO sal_data.dim_products_scd
                VALUES (
                        i.product_id,
                        i.product_src_id,
                        i.price,
                        i.description,
                        i.type,
                        i.brand,
                        i.producer_country,
                        i.volume,
                        i.shelf_width,
                        i.shelf_hight,
                        i.shelf_depth,
                        i.package,
                        i.package_color,
                        i.package_reusable,
                        i.taste,
                        i.alcohol,
                        i.insert_dt,
                        TO_DATE('31.12.9999', 'dd.MM.yyyy')
                        );
            EXIT WHEN c%NOTFOUND;
        END LOOP;
        COMMIT;
    END load_products;
END pkg_load_products;