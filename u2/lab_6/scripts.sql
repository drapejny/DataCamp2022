--======================================
-- FIRST_VALUE and LAST_VALUE functions
--======================================
SELECT  sl.country,
        sl.store_address,
        FIRST_VALUE(sl.store_address)
            OVER(PARTITION BY sl.country ORDER BY sl.country, SUM(sl.amount * pr.price) DESC) AS first_store,
        LAST_VALUE(sl.store_address)
            OVER(PARTITION BY sl.country ORDER BY sl.country, SUM(sl.amount * pr.price) DESC
                 RANGE BETWEEN UNBOUNDED PRECEDING AND 
                 UNBOUNDED FOLLOWING) AS last_store,
        SUM(sl.amount * pr.price) AS revenue
FROM dw_cl.dw_cl_sale_data sl
JOIN dw_cl.dw_cl_product_data pr
ON sl.sku_num = pr.sku_num
GROUP BY sl.country, sl.store_address
ORDER BY sl.country, revenue DESC;

--======================================
-- RANK, DENSE_RANK, ROW_NUM functions
--======================================
SELECT  date_id, 
        store_address,
        product_brand,
        product_name,
        RANK() OVER (PARTITION BY date_id, store_address, product_brand ORDER BY product_name) AS rank,
        DENSE_RANK() OVER (PARTITION BY date_id, store_address, product_brand ORDER BY product_name) AS dense_rank,
        ROW_NUMBER() OVER (PARTITION BY date_id, store_address, product_brand ORDER BY product_name) AS row_number
FROM dw_cl.dw_cl_sale_data
ORDER BY date_id, store_address,product_brand, product_name;

--======================================
-- MAX, MIN, AVG functions
--======================================
SELECT date_id,
       store_address,
       SUM(amount * price) AS revenue,
       MAX(SUM(amount * price)) OVER (PARTITION BY date_id) maximum,
       MIN(SUM(amount * price)) OVER (PARTITION BY date_id) minimum,
       AVG(SUM(amount * price)) OVER (PARTITION BY date_id) average
FROM dw_cl.dw_cl_sale_data sl
JOIN dw_cl.dw_cl_product_data pr
ON sl.sku_num = pr.sku_num
GROUP BY date_id, store_address
ORDER BY date_id, revenue DESC;
   