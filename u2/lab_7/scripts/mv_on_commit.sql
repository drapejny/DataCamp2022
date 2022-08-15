-- Creating mat view
CREATE MATERIALIZED VIEW mv_on_commit
BUILD IMMEDIATE
REFRESH ON COMMIT
AS
   SELECT TRUNC(date_id, 'MM') AS month,
                   country,
                   store_address,
                   SUM(amount) AS sales
            FROM sa_customers.sa_sale_data s
            GROUP BY TRUNC(date_id, 'MM'), country, store_address
            ORDER BY month, country, SUM(amount) DESC;
            
select * from mv_on_commit;

DELETE FROM sa_customers.sa_sale_data
WHERE date_id < to_date('01/02/2021', 'dd/mm/yyyy');
commit;

select * from mv_on_commit order by month, country, sales;