-- Creating product objects links table
CREATE TABLE product_objects
(
    object_desc VARCHAR2(100),
    parent_object_desc VARCHAR2(100)
) TABLESPACE ts_geo_backup;

-- Inserting links
INSERT INTO product_objects(object_desc, parent_object_desc)
    SELECT description,
       taste || ' Taste'
    FROM sa_products.sa_product_data;
    
COMMIT;

INSERT INTO product_objects(object_desc, parent_object_desc)
    SELECT taste || ' Taste',
           type || ' Type'
       
    FROM sa_products.sa_product_data 
    GROUP BY taste || ' Taste', type || ' Type';
    
COMMIT;

INSERT INTO product_objects(object_desc, parent_object_desc)
    SELECT type || ' Type', 
           brand
    FROM sa_products.sa_product_data
    GROUP BY type || ' Type', brand;
    
COMMIT;

INSERT INTO product_objects(object_desc, parent_object_desc)
    SELECT brand,
    null
FROM sa_products.sa_product_data
GROUP BY brand;

COMMIT;

-- Creating denormalized table for analyzing hierarchy of products
-- Brand -> Type -> Taste -> Product
CREATE TABLE t_products_denorm
AS
    SELECT LPAD(' ', 2 * LEVEL, ' ') || object_desc AS object,
       DECODE(( SELECT COUNT(*)
                    FROM product_objects links
                    WHERE links.parent_object_desc = objects.object_desc),
                  0,
                  NULL,
                  ( SELECT COUNT(*)
                    FROM product_objects links
                   WHERE links.parent_object_desc = objects.object_desc
                   )
                  ) AS child_count,
       DECODE(LEVEL, 1, 'ROOT', 4, 'LEAF', 'BRANCH') AS id_type,
       LEVEL as lvl,
       CONNECT_BY_ROOT(object_desc) AS root,
       SYS_CONNECT_BY_PATH(object_desc, '->') AS path,
       REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(object_desc, '->'), '->([^(->)]+)', 1, 1, NULL, 1) AS brand,
       REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(object_desc, '->'), '->([^(->)]+)', 1, 2, NULL, 1) AS type,
       REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(object_desc, '->'), '->([^(->)]+)', 1, 3, NULL, 1) AS taste,
       REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(object_desc, '->'), '->([^(->)]+)', 1, 4, NULL, 1) AS product
    FROM product_objects objects
    START WITH parent_object_desc IS NULL
    CONNECT BY PRIOR object_desc = parent_object_desc
    ORDER SIBLINGS BY object_desc;

-- Showing result
SELECT * FROM t_products_denorm;