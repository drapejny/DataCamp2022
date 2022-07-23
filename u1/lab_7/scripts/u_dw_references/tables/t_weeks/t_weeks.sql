-- drop table u_dw_references.t_weeks cascade constraints;

--==============================================================
-- Table: t_weeks                       
--==============================================================
CREATE TABLE u_dw_references.t_weeks(
    time_id DATE,
    calendar_week_number VARCHAR2(1),
    week_ending_date DATE,
    CONSTRAINT pk_t_weeks PRIMARY KEY (time_id)
)
TABLESPACE TS_REFERENCES_DATA_01;
