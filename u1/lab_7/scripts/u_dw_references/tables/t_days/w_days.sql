--drop view u_dw_references.w_days;

--==============================================================
-- View: w_days                                            
--==============================================================

CREATE OR REPLACE VIEW u_dw_references.w_days as
SELECT  time_id,
        day_name,
        day_number_in_week,
        day_number_in_month,
        day_number_in_year
  FROM u_dw_references.t_days;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_days to u_dw_ext_references;
