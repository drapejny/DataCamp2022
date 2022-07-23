--drop view u_dw_references.w_quarters;

--==============================================================
-- View: w_quarters                                            
--==============================================================

CREATE OR REPLACE VIEW u_dw_references.w_quarters as
SELECT  time_id,
        days_in_cal_quarter,
        beg_of_cal_quarter,
        end_of_cal_quarter,
    calendar_quarter_number
  FROM u_dw_references.t_quarters;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_quarters to u_dw_ext_references;