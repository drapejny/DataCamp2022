BEGIN
    -- Cleansing Layer
    dw_cl.pkg_load_products.load_products;
    dw_cl.pkg_load_stores.load_stores;
    dw_cl.pkg_load_customers.load_customers;
    dw_cl.pkg_load_sales.load_sales;
    
    -- DW Layer
    dw_data.pkg_load_dates.load_dates;
    dw_data.pkg_load_geo_locations.load_geo_locations;
    dw_data.pkg_load_products.load_products;
    dw_data.pkg_load_stores.load_stores;
    dw_data.pkg_load_customers.load_customers;
    dw_data.pkg_load_sales.load_sales;
    
    -- SAL Layer
    sal_data.pkg_load_dates.load_dates;
    sal_data.pkg_load_geo_locations.load_geo_locations;
    sal_data.pkg_load_products.load_products;
    sal_data.pkg_load_stores.load_stores;
    sal_data.pkg_load_customers.load_customers;
    sal_data.pkg_load_sales.load_sales;
END;