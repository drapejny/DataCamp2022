--drop view u_dw_references.w_years;

--==============================================================
-- View: w_years                                            
--==============================================================

CREATE OR REPLACE VIEW u_dw_references.w_years as
SELECT  time_id,
        calendar_year,
        days_in_cal_year,
        beg_of_cal_year,
        end_of_cal_year
  FROM u_dw_references.t_years;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_years to u_dw_ext_references;