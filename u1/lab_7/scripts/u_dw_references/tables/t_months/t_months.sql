-- drop table u_dw_references.t_months cascade constraints;

--==============================================================
-- Table: t_months                       
--==============================================================
CREATE TABLE u_dw_references.t_months(
    time_id DATE,
    calendar_month_number VARCHAR2(2),
    days_in_cal_month VARCHAR2(2),
    end_of_cal_month DATE,
    calendar_month_name VARCHAR2(32),
    CONSTRAINT pk_t_months PRIMARY KEY (time_id)
)
TABLESPACE TS_REFERENCES_DATA_01;
