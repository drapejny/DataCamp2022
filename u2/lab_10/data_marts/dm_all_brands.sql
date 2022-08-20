CREATE OR REPLACE VIEW sal_data.all_brands
AS
    SELECT  s.date_id,
            p.brand,
            COUNT(s.amount) AS amount,
            SUM(s.sum) AS sum
    FROM sal_data.fct_sales s
    LEFT JOIN sal_data.dim_products_scd p
    ON s.product_id = p.product_id
    GROUP BY s.date_id, p.brand
    ORDER BY date_id, sum DESC;
