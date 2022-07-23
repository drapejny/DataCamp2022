-- drop table u_dw_references.t_days cascade constraints;

--==============================================================
-- Table: t_days                           
--==============================================================
CREATE TABLE u_dw_references.t_days(
    time_id DATE,
    day_name VARCHAR2(44),
    day_number_in_week VARCHAR2(1),
    day_number_in_month VARCHAR2(2),
    day_number_in_year VARCHAR2(3),
    CONSTRAINT pk_t_days PRIMARY KEY (time_id)
)
TABLESPACE TS_REFERENCES_DATA_01;
