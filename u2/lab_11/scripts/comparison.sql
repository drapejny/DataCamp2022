--======================
-- Advancing Grouping
--======================
SELECT TRUNC(date_id, 'MM') AS month,
       DECODE(GROUPING(product_name), 1, 'All products', product_name) AS product_name,
       SUM(amount) AS amount,
       SUM(amount * price) AS revenue
FROM sa_customers.sa_sale_data s
JOIN sa_products.sa_product_data p
ON s.sku_num = p.sku_num
GROUP BY GROUPING SETS(
    (TRUNC(date_id, 'MM'), product_name),
    (TRUNC(date_id, 'MM')))
ORDER BY month, SUM(price) DESC;

select * from dbms_xplan.display(null);

--========================
-- Model Clause
--========================
WITH sales_by_month
AS
(
    SELECT TRUNC(date_id, 'MM') AS month,
            product_name AS product,
            SUM(amount * price) AS revenue,
            sum(amount) AS amount
             FROM sa_customers.sa_sale_data s
            JOIN sa_products.sa_product_data p
        ON s.sku_num = p.sku_num
        GROUP BY TRUNC(date_id, 'MM'), product_name
)

SELECT DISTINCT month, product, amount, revenue
FROM sales_by_month

MODEL
    PARTITION BY (month)
    DIMENSION BY (product)
    MEASURES (revenue, amount)
    RULES
        (
            revenue['All products'] = SUM(revenue)[any],
            amount['All products'] = SUM(amount)[any]
        )
ORDER BY month, revenue DESC;


--=======================
-- Using Star Scheme
--=======================
SELECT TRUNC(s.date_id, 'MM') AS month,
       DECODE(GROUPING(p.description), 1, 'All products', p.description) AS product_name,
       SUM(s.amount) AS amount,
       SUM(s.sum) AS revenue
FROM sal_data.fct_sales s
JOIN sal_data.dim_products_scd p
ON s.product_id = p.product_id
GROUP BY GROUPING SETS(
    (TRUNC(s.date_id, 'MM'), p.description),
    (TRUNC(s.date_id, 'MM')))
ORDER BY month, revenue DESC;