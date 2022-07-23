--drop view u_dw_references.w_months;

--==============================================================
-- View: w_months                                            
--==============================================================

CREATE OR REPLACE VIEW u_dw_references.w_months as
SELECT  time_id,
        calendar_month_number,
        days_in_cal_month,
        end_of_cal_month,
        calendar_month_name
  FROM u_dw_references.t_months;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_months to u_dw_ext_references;
