CREATE OR REPLACE PACKAGE BODY u_dw_ext_references.pkg_load_calendar
-- Package Reload Data From Generating Data Script to Database
--
AS
    -- Generating Calendar Data
    PROCEDURE load_cls_calendar(start_date IN VARCHAR2 DEFAULT '12/31/2021',
                                date_format IN VARCHAR2 DEFAULT 'MM/DD/YYYY',
                                days_number IN NUMBER DEFAULT 500)
    AS
    BEGIN
        -- truncate cls_calendar table
        EXECUTE IMMEDIATE 'TRUNCATE TABLE u_dw_ext_references.cls_calendar';

        -- Generate Calendar Data
        INSERT INTO u_dw_ext_references.cls_calendar (time_id,
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
                    NEXT_DAY( sd + rn, 'ВОСКРЕСЕНЬЕ' )
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
                TO_DATE( start_date, date_format ) sd,
                rownum rn
                FROM dual
                CONNECT BY level <= days_number
            )

        -- Commit Data
        Commit;
    END load_cls_calendar;

    -- Loading t_days data
    PROCEDURE load_t_days
    AS
    BEGIN

        -- truncate t_days table
        --EXECUTE IMMEDIATE 'TRUNCATE TABLE u_dw_references.t_days';
        --DELETE FROM u_dw_references.w_days;

        -- Loading t_days data
        INSERT INTO u_dw_references.w_days (time_id,
                                         day_name,
                                         day_number_in_week,
                                         day_number_in_month,
                                         day_number_in_year)
            SELECT time_id,
                   day_name,
                   day_number_in_week,
                   day_number_in_month,
                    day_number_in_year
         FROM u_dw_ext_references.cls_calendar;
    
        -- Commit Data
        Commit;
    END load_t_days;

    -- Loading t_weeks data
    PROCEDURE load_t_weeks
    AS
    BEGIN

        -- truncate t_weeks table
        --EXECUTE IMMEDIATE 'TRUNCATE TABLE u_dw_references.t_weeks';
        --DELETE FROM u_dw_references.w_weeks;

        -- Loading t_weeks data
        INSERT INTO u_dw_references.w_weeks (time_id,
                                            calendar_week_number,
                                            week_ending_date)
            SELECT  time_id,
                    calendar_week_number,
                    week_ending_date
         FROM u_dw_ext_references.cls_calendar;
    
        -- Commit Data
        Commit;
    END load_t_weeks;

    -- Loading t_months data
    PROCEDURE load_t_months
    AS
    BEGIN

        -- truncate t_months table
        --EXECUTE IMMEDIATE 'TRUNCATE TABLE u_dw_references.t_months';
        --DELETE FROM u_dw_references.w_months;

        -- Loading t_months data
        INSERT INTO u_dw_references.w_months (time_id,
                                            calendar_month_number,
                                            days_in_cal_month,
                                            end_of_cal_month,
                                            calendar_month_name)
            SELECT  time_id,
                    calendar_month_number,
                    days_in_cal_month,
                    end_of_cal_month,
                    calendar_month_name
         FROM u_dw_ext_references.cls_calendar;
    
        -- Commit Data
        Commit;
    END load_t_months;

    -- Loading t_quarters data
    PROCEDURE load_t_quarters
    AS
    BEGIN

        -- truncate t_quarters table
       -- EXECUTE IMMEDIATE 'TRUNCATE TABLE u_dw_references.t_quarters';
        --DELETE FROM u_dw_references.w_quarters;

        -- Loading t_quarters data
        INSERT INTO u_dw_references.w_quarters (time_id,
                                                days_in_cal_quarter,
                                                beg_of_cal_quarter,
                                                end_of_cal_quarter,
                                                calendar_quarter_number)
            SELECT  time_id,
                    days_in_cal_quarter,
                    beg_of_cal_quarter,
                    end_of_cal_quarter,
                    calendar_quarter_number
         FROM u_dw_ext_references.cls_calendar;
    
        -- Commit Data
        Commit;
    END load_t_quarters;

    -- Loading t_years data
    PROCEDURE load_t_years
    AS
    BEGIN

        -- truncate t_years table
        --EXECUTE IMMEDIATE 'TRUNCATE TABLE u_dw_references.t_years';
        --DELETE FROM u_dw_references.w_years;

        -- Loading t_years data
        INSERT INTO u_dw_references.w_years (time_id,
                                            calendar_year,
                                            days_in_cal_year,
                                            beg_of_cal_year,
                                            end_of_cal_year)
            SELECT  time_id,
                    calendar_year,
                    days_in_cal_year,
                    beg_of_cal_year,
                    end_of_cal_year
         FROM u_dw_ext_references.cls_calendar;
    
        -- Commit Data
        Commit;
    END load_t_years;
END;
/