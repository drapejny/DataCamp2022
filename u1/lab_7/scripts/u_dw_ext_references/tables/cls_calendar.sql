-- drop table u_dw_references.cls_calendar cascade constraints;

--==============================================================
-- Table: cls_calendar                             
--==============================================================
CREATE TABLE u_dw_ext_references.cls_calendar
    (time_id DATE,
    day_name VARCHAR2(44),
    day_number_in_week VARCHAR2(1 BYTE),
    day_number_in_month VARCHAR2(2 BYTE),
    day_number_in_year VARCHAR2(3 BYTE),
    calendar_week_number VARCHAR2(1 BYTE),  
    week_ending_date DATE,
    calendar_month_number VARCHAR2(2 BYTE),
    days_in_cal_month VARCHAR2(2 BYTE),
    end_of_cal_month DATE,
    calendar_month_name VARCHAR2(32 BYTE), 
    days_in_cal_quarter NUMBER,
    beg_of_cal_quarter DATE, 
    end_of_cal_quarter DATE,
    calendar_quarter_number VARCHAR2(1 BYTE),
    calendar_year VARCHAR2(4 BYTE),
    days_in_cal_year NUMBER,
    beg_of_cal_year DATE,
    end_of_cal_year DATE) 

    TABLESPACE TS_REFERENCES_EXT_DATA_01;