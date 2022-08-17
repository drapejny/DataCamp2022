ALTER SESSION SET CURRENT_SCHEMA = dw_data;
--GRANT SELECT ON dw_cl.dw_cl_product_data TO dw_data;
CREATE OR REPLACE PACKAGE BODY pkg_load_products
IS
    PROCEDURE load_products
    IS
        old_product_row dw_data.dim_products_scd%ROWTYPE;

        CURSOR c IS
            SELECT  dw.product_id,
                    cl.sku_num,
                    dw.eff_time,
                    dw.exp_time,
                    cl.price,
                    cl.description,
                    cl.type,
                    cl.brand,
                    cl.producer_country,
                    cl.volume,
                    cl.shelf_width,
                    cl.shelf_hight,
                    cl.shelf_depth,
                    cl.package,
                    cl.package_color,
                    cl.package_reusable,
                    cl.taste,
                    cl.alcohol
            FROM dw_cl.dw_cl_product_data cl
            LEFT JOIN dw_data.dim_products_scd dw
            ON cl.sku_num = dw.sku_num
            WHERE dw.exp_time IS NULL;

    BEGIN
        FOR i in c LOOP
            IF i.product_id IS NULL THEN
                INSERT INTO dw_data.dim_products_scd
                            (
                            product_id,
                            sku_num,
                            eff_time,
                            exp_time,
                            price,
                            description,
                            type,
                            brand,
                            producer_country,
                            volume,
                            shelf_width,
                            shelf_hight,
                            shelf_depth,
                            package,
                            package_color,
                            package_reusable,
                            taste,
                            alcohol
                            )
                    VALUES
                        (
                            dw_data.seq_products.NEXTVAL,
                            i.sku_num,
                            SYSDATE,
                            NULL,
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
                            i.alcohol
                        );
            ELSE

                SELECT *
                INTO old_product_row
                FROM dw_data.dim_products_scd
                WHERE product_id = i.product_id;

                UPDATE dw_data.dim_products_scd
                SET 
                    eff_time = SYSDATE,
                    exp_time = NULL,
                    price = i.price,
                    description = i.description,
                    type = i.type,
                    brand = i.brand,
                    producer_country = i.producer_country,
                    volume = i.volume,
                    shelf_width = i.shelf_width,
                    shelf_hight = i.shelf_hight,
                    shelf_depth = i.shelf_depth,
                    package = i.package,
                    package_color = i.package_color,
                    package_reusable = i.package_reusable,
                    taste = i.taste,
                    alcohol = i.alcohol
                WHERE product_id = i.product_id;

                INSERT INTO dw_data.dim_products_scd
                        (
                            product_id,
                            sku_num,
                            eff_time,
                            exp_time,
                            price,
                            description,
                            type,
                            brand,
                            producer_country,
                            volume,
                            shelf_width,
                            shelf_hight,
                            shelf_depth,
                            package,
                            package_color,
                            package_reusable,
                            taste,
                            alcohol
                        )
                    VALUES
                        (
                            dw_data.seq_products.NEXTVAL,
                            old_product_row.sku_num,
                            old_product_row.eff_time,
                            SYSDATE,
                            old_product_row.price,
                            old_product_row.description,
                            old_product_row.type,
                            old_product_row.brand,
                            old_product_row.producer_country,
                            old_product_row.volume,
                            old_product_row.shelf_width,
                            old_product_row.shelf_hight,
                            old_product_row.shelf_depth,
                            old_product_row.package,
                            old_product_row.package_color,
                            old_product_row.package_reusable,
                            old_product_row.taste,
                            old_product_row.alcohol
                        );
            END IF;
            EXIT WHEN c%NOTFOUND;
        END LOOP;
        
        COMMIT;

    END load_products;
END pkg_load_products;