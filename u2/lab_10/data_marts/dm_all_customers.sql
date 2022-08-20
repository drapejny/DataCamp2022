CREATE OR REPLACE VIEW sal_data.all_customers
AS
    SELECT c.customer_id,
           first_name,
           last_name,
           phone,
           country,
           email,
           birthday,
           amount,
           sum
    FROM sal_data.dim_customers c
    JOIN (SELECT customer_id,
                 count(amount) AS amount,
                 sum(sum) AS sum
          FROM sal_data.fct_sales
          GROUP BY customer_id) s
    ON s.customer_id = c.customer_id
    ORDER BY sum DESC;
    