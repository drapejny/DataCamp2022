--drop view u_dw_references.w_weeks;

--==============================================================
-- View: w_weeks                                            
--==============================================================

CREATE OR REPLACE VIEW u_dw_references.w_weeks as
SELECT  time_id,
        calendar_week_number,
        week_ending_date
  FROM u_dw_references.t_weeks;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_weeks to u_dw_ext_references;
