CREATE OR REPLACE VIEW sal_data.stores_sales
AS
    SELECT date_id,
           country,
           address,
           COUNT(amount) AS amount,
           SUM(sum) AS sum
    FROM sal_data.fct_sales sl
    LEFT JOIN sal_data.dim_stores st
    ON sl.store_id = st.store_id
    GROUP BY date_id, country, address
    ORDER BY date_id, country, sum DESC;