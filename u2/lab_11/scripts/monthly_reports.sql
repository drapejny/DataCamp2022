-- Monthly sales and revenue for each country and store
SELECT TRUNC(sl.date_id, 'MM') AS month,
       DECODE(GROUPING(st.country), 1, 'All countries', st.country) AS country,
       DECODE(GROUPING(st.address), 1, 'All stores', st.address) AS store_address,
       COUNT(sl.amount) AS amount,
       SUM(sl.sum) AS revenue
FROM sal_data.fct_sales sl
LEFT JOIN sal_data.dim_stores st
ON sl.store_id = st.store_id
GROUP BY TRUNC(sl.date_id, 'MM'), GROUPING SETS(
    (st.country, st.address),
    (st.country),
    (TRUNC(sl.date_id, 'MM')))
ORDER BY month, st.country, SUM(sl.sum) DESC;


-- Monthly most popular product brands
SELECT TRUNC(s.date_id, 'MM') AS month,
       DECODE(GROUPING(p.brand), 1, 'All brands', p.brand) AS product_brand,
       COUNT(s.amount) AS amount,
       SUM(s.sum) AS revenue
FROM sal_data.fct_sales s
LEFT JOIN sal_data.dim_products_scd p
ON s.product_id = p.product_id
GROUP BY TRUNC(s.date_id, 'MM'), ROLLUP(p.brand)
ORDER BY month, SUM(s.sum) DESC;

-- Monthly most popular products
SELECT TRUNC(s.date_id, 'MM') AS month,
       DECODE(GROUPING(p.description), 1, 'All products', p.description) AS product_name,
       COUNT(s.amount) AS amount,
       SUM(s.sum) AS revenue
FROM sal_data.fct_sales s
LEFT JOIN sal_data.dim_products_scd p
ON s.product_id = p.product_id
GROUP BY GROUPING SETS(
    (TRUNC(s.date_id, 'MM'), p.description),
    (TRUNC(s.date_id, 'MM')))
ORDER BY month, SUM(s.sum) DESC;