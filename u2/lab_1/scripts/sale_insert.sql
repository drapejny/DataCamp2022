 INSERT INTO sa_customers.sa_sale_data
 SELECT a.date_id AS date_id,
                c.first_name AS first_name,
                c.last_name AS last_name,
                c.phone AS phone,
                p.description AS product_name,
                p.type AS product_type,
                p.brand AS product_brand,
                p.sku_num AS sku_num,
                s.address AS store_address,
                s.country AS country,
                TRUNC(dbms_random.value(1,4)) AS amount,
                to_char(a.date_id, 'YYYY') || to_char(a.date_id, 'MM') || to_char(a.date_id, 'DD') || to_char(a.customer_id, 'fm0000') || to_char(a.store_id, 'fm00') AS pos_transaction
         FROM
            (SELECT (to_date('12/31/2020', 'MM/DD/YYYY') + TRUNC(dbms_random.value(1, 575))) AS date_id,
                    TRUNC(dbms_random.value(1, 81)) AS product_id,
                    TRUNC(dbms_random.value(1, 17)) AS store_id,
                    TRUNC(dbms_random.value(1, 6401)) AS customer_id
             FROM dual
             CONNECT BY LEVEL <= 500000) a
         INNER JOIN (SELECT sa_products.sa_product_data.*, rownum AS id FROM sa_products.sa_product_data) p
         ON a.product_id = p.id
         INNER JOIN (SELECT sa_products.sa_store_data.*, rownum AS id FROM sa_products.sa_store_data) s
         ON a.store_id = s.id
         INNER JOIN (SELECT sa_customers.sa_customer_data.*, rownum AS id FROM sa_customers.sa_customer_data) c
         ON a.store_id = c.id;
         
COMMIT;