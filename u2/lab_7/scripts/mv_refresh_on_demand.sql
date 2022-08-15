-- Droping mat view
drop materialized view mv_refresh_on_demand;

-- Creating mat view
CREATE MATERIALIZED VIEW mv_refresh_on_demand
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND
AS
    SELECT *
    FROM ( SELECT TRUNC(date_id, 'MM') AS month,
                   DECODE(GROUPING(country), 1, 'All countries', country) AS country,
                   DECODE(GROUPING(store_address), 1, 'All stores', store_address) AS store_address,
                   COUNT(*) AS sales,
                   SUM(price) AS revenue
            FROM sa_customers.sa_sale_data s
            JOIN sa_products.sa_product_data p
            ON s.sku_num = p.sku_num
            GROUP BY TRUNC(date_id, 'MM'), GROUPING SETS(
                         (country, store_address),
                         (country),
                         (TRUNC(date_id, 'MM')))
            ORDER BY month, country, SUM(price) DESC);
    
EXECUTE DBMS_MVIEW.REFRESH('mv_refresh_on_demand');

select * from mv_refresh_on_demand;
