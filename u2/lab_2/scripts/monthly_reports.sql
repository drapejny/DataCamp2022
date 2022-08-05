-- Monthly sales and revenue for each country and store
SELECT TRUNC(date_id, 'MM') AS month,
       DECODE(GROUPING(country), 1, 'All countries', country) AS country,
       DECODE(GROUPING(store_address), 1, 'All stores', store_address) AS store_address,
       COUNT(*) AS sales,
       SUM(price) AS revenue
FROM sa_customers.sa_sale_data
GROUP BY TRUNC(date_id, 'MM'), GROUPING SETS(
    (country, store_address),
    (country),
    (TRUNC(date_id, 'MM')))
ORDER BY month, country, SUM(price) DESC;

-- Monthly most popular product brands
SELECT TRUNC(date_id, 'MM') AS month,
       DECODE(GROUPING(product_brand), 1, 'All brands', product_brand) AS product_brand,
       COUNT(*) AS sales,
       SUM(price) AS revenue
FROM sa_customers.sa_sale_data
GROUP BY TRUNC(date_id, 'MM'), ROLLUP(product_brand)
ORDER BY month, SUM(price) DESC;

-- Monthly most popular products
SELECT TRUNC(date_id, 'MM') AS month,
       DECODE(GROUPING(product_name), 1, 'All products', product_name) AS product_name,
       COUNT(*) AS sales,
       SUM(price) AS revenue
FROM sa_customers.sa_sale_data
GROUP BY GROUPING SETS(
    (TRUNC(date_id, 'MM'), product_name),
    (TRUNC(date_id, 'MM')))
ORDER BY month, SUM(price) DESC;