ALTER SESSION SET CURRENT_SCHEMA = dw_data;
CREATE OR REPLACE PACKAGE BODY dw_data.pkg_load_dates
IS
    PROCEDURE load_dates
    IS
        top_date_in_dw dw_data.dim_dates.date_id%TYPE;
        current_date DATE;
        date_diff NUMBER;

    BEGIN
        SELECT MAX(date_id)
        INTO top_date_in_dw
        FROM dw_data.dim_dates;

        IF top_date_in_dw IS NULL THEN
            top_date_in_dw := to_date('12/31/2020', 'MM/DD/YYYY');
        END IF;

        current_date := SYSDATE;

        IF current_date > top_date_in_dw THEN
        
            date_diff := current_date - top_date_in_dw;

            INSERT INTO dw_data.dim_dates (date_id,
                                              day_name,
                                              day_number_in_week,
                                              day_number_in_month,
                                              day_number_in_year,
                                              calendar_week_number,
                                              week_ending_date,
                                              calendar_month_number,
                                              days_in_cal_month,
                                              end_of_cal_month,
                                              calendar_month_name,
                                              days_in_cal_quarter,
                                              beg_of_cal_quarter,
                                              end_of_cal_quarter,
                                              calendar_quarter_number,
                                              calendar_year,
                                              days_in_cal_year,
                                              beg_of_cal_year,
                                              end_of_cal_year)
            SELECT 
            TRUNC( sd + rn ) time_id,
            TO_CHAR( sd + rn, 'fmDay' ) day_name,
            TO_CHAR( sd + rn, 'D' ) day_number_in_week,
            TO_CHAR( sd + rn, 'DD' ) day_number_in_month,
            TO_CHAR( sd + rn, 'DDD' ) day_number_in_year,
            TO_CHAR( sd + rn, 'W' ) calendar_week_number,
            ( CASE
                WHEN TO_CHAR( sd + rn, 'D' ) IN ( 1, 2, 3, 4, 5, 6 ) THEN
                    NEXT_DAY( sd + rn, 'Воскресенье' )
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
                top_date_in_dw sd,
                rownum rn
                FROM dual
                CONNECT BY level <= date_diff + 20 -- Just add 20 days ahead
            )

        -- Commit Data
        Commit;
        END IF;
    END load_dates;
END pkg_load_dates;