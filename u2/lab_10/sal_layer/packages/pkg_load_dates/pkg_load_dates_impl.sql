ALTER SESSION SET CURRENT_SCHEMA = sal_data;
--GRANT SELECT ON dw_data.dw_dates TO sal_data;
CREATE OR REPLACE PACKAGE BODY pkg_load_dates
IS
    PROCEDURE load_dates
    IS
    BEGIN
        MERGE INTO sal_data.dim_dates sal
            USING (SELECT  date_id,
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
                           end_of_cal_year
                    FROM dw_data.dw_dates) dw
            ON (sal.date_id = dw.date_id)
            WHEN NOT MATCHED
                THEN
                    INSERT VALUES( dw.date_id,
                                   dw.day_name,
                                   dw.day_number_in_week,
                                   dw.day_number_in_month,
                                   dw.day_number_in_year,
                                   dw.calendar_week_number,
                                   dw.week_ending_date,
                                   dw.calendar_month_number,
                                   dw.days_in_cal_month,
                                   dw.end_of_cal_month,
                                   dw.calendar_month_name,
                                   dw.days_in_cal_quarter,
                                   dw.beg_of_cal_quarter,
                                   dw.end_of_cal_quarter,
                                   dw.calendar_quarter_number,
                                   dw.calendar_year,
                                   dw.days_in_cal_year,
                                   dw.beg_of_cal_year,
                                   dw.end_of_cal_year);
        
        COMMIT;
    END load_dates;
END pkg_load_dates;