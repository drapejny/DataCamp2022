-- Examples of base group by operations on sales table

-- Selecting most popular brands by counties
SELECT country, product_brand, COUNT(*) AS sales
FROM sa_customers.sa_sale_data
GROUP BY country, product_brand
ORDER BY country, count(*) DESC;

-- Selecting most popular stores
SELECT store_address, COUNT(*) AS sales
FROM sa_customers.sa_sale_data
GROUP BY store_address
ORDER BY count(*) DESC;
