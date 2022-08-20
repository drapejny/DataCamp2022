ALTER SESSION SET CURRENT_SCHEMA = sal_data;
BEGIN
    pkg_load_dates.load_dates;
    pkg_load_geo_locations.load_geo_locations;
    pkg_load_products.load_products;
    pkg_load_stores.load_stores;
    pkg_load_customers.load_customers;
    pkg_load_sales.load_sales;
END;