CREATE MATERIALIZED VIEW mv_def_time
BUILD IMMEDIATE
REFRESH COMPLETE NEXT SYSDATE + 1/1440
AS
   SELECT TRUNC(date_id, 'MM') AS month,
                   country,
                   store_address,
                   SUM(amount) AS sales
            FROM sa_customers.sa_sale_data s
            GROUP BY TRUNC(date_id, 'MM'), country, store_address
            ORDER BY month, country, SUM(amount) DESC;
            
SELECT * FROM mv_def_time order by month, country, sales desc;

DELETE FROM sa_customers.sa_sale_data
WHERE date_id < to_date('01/04/2021', 'dd/mm/yyyy');
commit;

SELECT * FROM mv_def_time order by month, country, sales desc;

