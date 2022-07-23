-- drop table u_dw_references.t_years cascade constraints;

--==============================================================
-- Table: t_years                           
--==============================================================
CREATE TABLE u_dw_references.t_years(
    time_id DATE,
    calendar_year VARCHAR2(4),
    days_in_cal_year NUMBER,
    beg_of_cal_year DATE,
    end_of_cal_year DATE,
    CONSTRAINT pk_t_years PRIMARY KEY (time_id)
)
TABLESPACE TS_REFERENCES_DATA_01;
