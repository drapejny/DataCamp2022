-- drop table u_dw_references.t_quarters cascade constraints;

--==============================================================
-- Table: t_quarters                       
--==============================================================
CREATE TABLE u_dw_references.t_quarters(
    time_id DATE,
    days_in_cal_quarter NUMBER,
    beg_of_cal_quarter DATE,
    end_of_cal_quarter DATE,
    calendar_quarter_number VARCHAR2(1),
    CONSTRAINT pk_t_quarters PRIMARY KEY (time_id)
)
TABLESPACE TS_REFERENCES_DATA_01;
