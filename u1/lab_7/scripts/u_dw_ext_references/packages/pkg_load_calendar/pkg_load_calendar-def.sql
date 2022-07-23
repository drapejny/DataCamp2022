CREATE OR REPLACE PACKAGE u_dw_ext_references.pkg_load_calendar
-- Package Reload Data From Generating Data Script to Database
--
AS
   -- Generating Calendar Data
   PROCEDURE load_cls_calendar( start_date IN VARCHAR2 DEFAULT '12/31/2021',
                                date_format IN VARCHAR2 DEFAULT 'MM/DD/YYYY',
                                days_number IN NUMBER DEFAULT 500);
   PROCEDURE load_t_days;

   PROCEDURE load_t_weeks;

   PROCEDURE load_t_months;

   PROCEDURE load_t_quarters;

   PROCEDURE load_t_years;
   
END pkg_load_calendar;
/