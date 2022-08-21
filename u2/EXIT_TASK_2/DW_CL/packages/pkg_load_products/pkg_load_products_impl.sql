ALTER SESSION SET CURRENT_SCHEMA = dw_cl;
CREATE OR REPLACE PACKAGE BODY pkg_load_products
IS
    PROCEDURE load_products
    IS
        CURSOR c IS
            SELECT DISTINCT sku_num,
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
            FROM sa_products.sa_product_data;
    BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE dw_cl_product_data';
        FOR i IN c LOOP
            INSERT INTO dw_cl_product_data(
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
                            alcohol)
                    VALUES (i.sku_num,
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
                            i.alcohol);
            EXIT WHEN c%NOTFOUND;
        END LOOP;
        COMMIT;
    END load_products;
END pkg_load_products;