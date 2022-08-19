ALTER SESSION SET CURRENT_SCHEMA = dw_data;
--GRANT SELECT ON dw_cl.dw_cl_product_data TO dw_data;
CREATE OR REPLACE PACKAGE BODY pkg_load_products
IS
    PROCEDURE load_products
    IS
        old_product_row dw_data.dw_products%ROWTYPE;

        CURSOR c IS
            SELECT
                    sku_num,
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
            FROM dw_cl.dw_cl_product_data;

    BEGIN
        FOR i in c LOOP
             INSERT INTO dw_data.dw_products
                        (
                        product_id,
                        product_src_id,
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
                        alcohol,
                        insert_dt
                        )
                    VALUES
                        (
                            dw_data.seq_products.NEXTVAL,
                            i.sku_num,
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
                            SYSDATE
                        );
            EXIT WHEN c%NOTFOUND;
        END LOOP;
        
        COMMIT;

    END load_products;
END pkg_load_products;