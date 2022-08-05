-- Daily sales and revenue for each country and store
SELECT date_id,
       DECODE(GROUPING(country), 1, 'All countries', country) AS country,
       DECODE(GROUPING(store_address), 1, 'All stores', store_address) AS store_address,
       COUNT(*) AS sales,
       SUM(price) AS revenue
FROM sa_customers.sa_sale_data
GROUP BY CUBE(date_id, country, store_address)
HAVING GROUPING_ID(date_id) = 0 AND (GROUPING_ID(country) = 0 OR (GROUPING_ID(country) = 1 AND GROUPING_ID(store_address) = 1))
ORDER BY date_id, country, SUM(price) DESC;

-- Daily most popular product brands
SELECT date_id,
       DECODE(GROUPING(product_brand), 1, 'All brands', product_brand) AS product_brand,
       COUNT(*) AS sales,
       SUM(price) AS revenue
FROM sa_customers.sa_sale_data
GROUP BY CUBE(date_id, product_brand)
HAVING GROUPING_ID(date_id) = 0
ORDER BY date_id, SUM(price) DESC;

-- Daily most popular products
SELECT date_id,
       DECODE(GROUPING(product_name), 1, 'All products', product_name) AS product_name,
       COUNT(*) AS sales,
       SUM(price) AS revenue
FROM sa_customers.sa_sale_data
GROUP BY CUBE(date_id, product_name)
ORDER BY date_id, SUM(price) DESC;
       