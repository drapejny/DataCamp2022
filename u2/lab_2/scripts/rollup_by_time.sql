SELECT DECODE (GROUPING_ID(TRUNC(date_id, 'YYYY'),TRUNC(date_id, 'Q'), TRUNC(date_id, 'MM'), TRUNC(date_id, 'DD')), 15, 'GRAND TOTAL', TRUNC(date_id, 'YYYY') ) AS year
    , DECODE (GROUPING_ID(TRUNC(date_id, 'YYYY'),TRUNC(date_id, 'Q'), TRUNC(date_id, 'MM'), TRUNC(date_id, 'DD')), 7, 'TOTAL BY YEAR', TRUNC(date_id, 'Q') ) AS quarter
    , DECODE (GROUPING_ID(TRUNC(date_id, 'YYYY'),TRUNC(date_id, 'Q'), TRUNC(date_id, 'MM'), TRUNC(date_id, 'DD')), 3, 'TOTAL BY QUARTER', TRUNC(date_id, 'MM') ) AS month
    , DECODE (GROUPING_ID(TRUNC(date_id, 'YYYY'),TRUNC(date_id, 'Q'), TRUNC(date_id, 'MM'), TRUNC(date_id, 'DD')), 1, 'TOTAL BY MONTH', TRUNC(date_id, 'DD') ) AS day
    ,  SUM(price) AS revenue
FROM sa_customers.sa_sale_data
GROUP BY ROLLUP ( TRUNC ( date_id, 'YYYY' ), 
                  TRUNC ( date_id, 'Q' ), 
                  TRUNC ( date_id, 'MM' ), 
                  TRUNC ( date_id, 'DD' ) )
ORDER BY year, quarter, month, day;