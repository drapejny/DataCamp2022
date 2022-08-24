--================================
-- Calculating monthly sales using Model Clause
--=================================
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