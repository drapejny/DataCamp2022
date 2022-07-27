-- Create test table using script
-- for creating Calendar from previous tasks
DROP TABLE CALENDAR;
PURGE RECYCLEBIN;

CREATE TABLE CALENDAR
AS SELECT * FROM 
    (SELECT 
        TRUNC( sd + rn ) time_id,
        TO_CHAR( sd + rn, 'fmDay' ) day_name,
        TO_CHAR( sd + rn, 'D' ) day_number_in_week,
        TO_CHAR( sd + rn, 'DD' ) day_number_in_month,
        TO_CHAR( sd + rn, 'DDD' ) day_number_in_year,
        TO_CHAR( sd + rn, 'W' ) calendar_week_number,
        ( CASE
            WHEN TO_CHAR( sd + rn, 'D' ) IN ( 1, 2, 3, 4, 5, 7 ) THEN
             NEXT_DAY( sd + rn, '�������' )
              ELSE
               ( sd + rn )
         END ) week_ending_date,
         TO_CHAR( sd + rn, 'MM' ) calendar_month_number,
         TO_CHAR( LAST_DAY( sd + rn ), 'DD' ) days_in_cal_month,
         LAST_DAY( sd + rn ) end_of_cal_month,
         TO_CHAR( sd + rn, 'FMMonth' ) calendar_month_name,
        ( ( CASE
            WHEN TO_CHAR( sd + rn, 'Q' ) = 1 THEN
              TO_DATE( '03/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
            WHEN TO_CHAR( sd + rn, 'Q' ) = 2 THEN
              TO_DATE( '06/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
            WHEN TO_CHAR( sd + rn, 'Q' ) = 3 THEN
             TO_DATE( '09/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
           WHEN TO_CHAR( sd + rn, 'Q' ) = 4 THEN
              TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
         END ) - TRUNC( sd + rn, 'Q' ) + 1 ) days_in_cal_quarter,
         TRUNC( sd + rn, 'Q' ) beg_of_cal_quarter,
         ( CASE
            WHEN TO_CHAR( sd + rn, 'Q' ) = 1 THEN
               TO_DATE( '03/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
            WHEN TO_CHAR( sd + rn, 'Q' ) = 2 THEN
              TO_DATE( '06/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
           WHEN TO_CHAR( sd + rn, 'Q' ) = 3 THEN
              TO_DATE( '09/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
            WHEN TO_CHAR( sd + rn, 'Q' ) = 4 THEN
             TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
          END ) end_of_cal_quarter,
         TO_CHAR( sd + rn, 'Q' ) calendar_quarter_number,
         TO_CHAR( sd + rn, 'YYYY' ) calendar_year,
         ( TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
          - TRUNC( sd + rn, 'YEAR' ) ) days_in_cal_year,
         TRUNC( sd + rn, 'YEAR' ) beg_of_cal_year,
         TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' ) end_of_cal_year
        FROM
         ( 
          SELECT 
            TO_DATE( '12/31/2002', 'MM/DD/YYYY' ) sd,
            rownum rn
          FROM dual
            CONNECT BY level <= 200000
         )
    );
    commit;

-- Select non parallel
SELECT COUNT(*) FROM CALENDAR WHERE day_name = '�������' 
AND calendar_quarter_number in (1,2,3) 
AND calendar_month_number BETWEEN 1 AND 11;

-- Select parallel
SELECT /*+ parallel(CALENDAR, 4) */ COUNT(*) FROM CALENDAR WHERE day_name = '�������' 
AND calendar_quarter_number in (1,2,3) 
AND calendar_month_number BETWEEN 1 AND 11;

-- Delete non parallel
DELETE FROM CALENDAR
WHERE day_name IN ('�����������', '�������');

-- Delete parallel
DELETE /*+ parallel enable_parallel_dml */ FROM CALENDAR
WHERE day_name IN ('�����������', '�������');

-- Create table non parallel
CREATE TABLE CALENDAR
AS SELECT * FROM 
    (SELECT 
        TRUNC( sd + rn ) time_id,
        TO_CHAR( sd + rn, 'fmDay' ) day_name,
        TO_CHAR( sd + rn, 'D' ) day_number_in_week,
        TO_CHAR( sd + rn, 'DD' ) day_number_in_month,
        TO_CHAR( sd + rn, 'DDD' ) day_number_in_year,
        TO_CHAR( sd + rn, 'W' ) calendar_week_number,
        ( CASE
            WHEN TO_CHAR( sd + rn, 'D' ) IN ( 1, 2, 3, 4, 5, 7 ) THEN
             NEXT_DAY( sd + rn, '�������' )
              ELSE
               ( sd + rn )
         END ) week_ending_date,
         TO_CHAR( sd + rn, 'MM' ) calendar_month_number,
         TO_CHAR( LAST_DAY( sd + rn ), 'DD' ) days_in_cal_month,
         LAST_DAY( sd + rn ) end_of_cal_month,
         TO_CHAR( sd + rn, 'FMMonth' ) calendar_month_name,
        ( ( CASE
            WHEN TO_CHAR( sd + rn, 'Q' ) = 1 THEN
              TO_DATE( '03/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
            WHEN TO_CHAR( sd + rn, 'Q' ) = 2 THEN
              TO_DATE( '06/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
            WHEN TO_CHAR( sd + rn, 'Q' ) = 3 THEN
             TO_DATE( '09/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
           WHEN TO_CHAR( sd + rn, 'Q' ) = 4 THEN
              TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
         END ) - TRUNC( sd + rn, 'Q' ) + 1 ) days_in_cal_quarter,
         TRUNC( sd + rn, 'Q' ) beg_of_cal_quarter,
         ( CASE
            WHEN TO_CHAR( sd + rn, 'Q' ) = 1 THEN
               TO_DATE( '03/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
            WHEN TO_CHAR( sd + rn, 'Q' ) = 2 THEN
              TO_DATE( '06/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
           WHEN TO_CHAR( sd + rn, 'Q' ) = 3 THEN
              TO_DATE( '09/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
            WHEN TO_CHAR( sd + rn, 'Q' ) = 4 THEN
             TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
          END ) end_of_cal_quarter,
         TO_CHAR( sd + rn, 'Q' ) calendar_quarter_number,
         TO_CHAR( sd + rn, 'YYYY' ) calendar_year,
         ( TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
          - TRUNC( sd + rn, 'YEAR' ) ) days_in_cal_year,
         TRUNC( sd + rn, 'YEAR' ) beg_of_cal_year,
         TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' ) end_of_cal_year
        FROM
         ( 
          SELECT 
            TO_DATE( '12/31/2002', 'MM/DD/YYYY' ) sd,
            rownum rn
          FROM dual
            CONNECT BY level <= 200000
         )
    );
commit;

DROP TABLE CALENDAR;

-- Create table parallel
CREATE TABLE CALENDAR PARALLEL 8 
AS SELECT * FROM 
    (SELECT 
        TRUNC( sd + rn ) time_id,
        TO_CHAR( sd + rn, 'fmDay' ) day_name,
        TO_CHAR( sd + rn, 'D' ) day_number_in_week,
        TO_CHAR( sd + rn, 'DD' ) day_number_in_month,
        TO_CHAR( sd + rn, 'DDD' ) day_number_in_year,
        TO_CHAR( sd + rn, 'W' ) calendar_week_number,
        ( CASE
            WHEN TO_CHAR( sd + rn, 'D' ) IN ( 1, 2, 3, 4, 5, 7 ) THEN
             NEXT_DAY( sd + rn, '�������' )
              ELSE
               ( sd + rn )
         END ) week_ending_date,
         TO_CHAR( sd + rn, 'MM' ) calendar_month_number,
         TO_CHAR( LAST_DAY( sd + rn ), 'DD' ) days_in_cal_month,
         LAST_DAY( sd + rn ) end_of_cal_month,
         TO_CHAR( sd + rn, 'FMMonth' ) calendar_month_name,
        ( ( CASE
            WHEN TO_CHAR( sd + rn, 'Q' ) = 1 THEN
              TO_DATE( '03/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
            WHEN TO_CHAR( sd + rn, 'Q' ) = 2 THEN
              TO_DATE( '06/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
            WHEN TO_CHAR( sd + rn, 'Q' ) = 3 THEN
             TO_DATE( '09/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
           WHEN TO_CHAR( sd + rn, 'Q' ) = 4 THEN
              TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
         END ) - TRUNC( sd + rn, 'Q' ) + 1 ) days_in_cal_quarter,
         TRUNC( sd + rn, 'Q' ) beg_of_cal_quarter,
         ( CASE
            WHEN TO_CHAR( sd + rn, 'Q' ) = 1 THEN
               TO_DATE( '03/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
            WHEN TO_CHAR( sd + rn, 'Q' ) = 2 THEN
              TO_DATE( '06/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
           WHEN TO_CHAR( sd + rn, 'Q' ) = 3 THEN
              TO_DATE( '09/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
            WHEN TO_CHAR( sd + rn, 'Q' ) = 4 THEN
             TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
          END ) end_of_cal_quarter,
         TO_CHAR( sd + rn, 'Q' ) calendar_quarter_number,
         TO_CHAR( sd + rn, 'YYYY' ) calendar_year,
         ( TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
          - TRUNC( sd + rn, 'YEAR' ) ) days_in_cal_year,
         TRUNC( sd + rn, 'YEAR' ) beg_of_cal_year,
         TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' ) end_of_cal_year
        FROM
         ( 
          SELECT 
            TO_DATE( '12/31/2002', 'MM/DD/YYYY' ) sd,
            rownum rn
          FROM dual
            CONNECT BY level <= 200000
         )
    );
    commit;
