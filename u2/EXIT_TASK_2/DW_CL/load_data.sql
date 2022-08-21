ALTER SESSION SET CURRENT_SCHEMA = dw_cl;
BEGIN
    pkg_load_products.load_products;
    pkg_load_stores.load_stores;
    pkg_load_customers.load_customers;
    pkg_load_sales.load_sales;
END;