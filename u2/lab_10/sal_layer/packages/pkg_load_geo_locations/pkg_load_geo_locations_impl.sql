ALTER SESSION SET CURRENT_SCHEMA = sal_data;
--GRANT SELECT ON dw_data.dw_geo_locations TO sal_data;
CREATE OR REPLACE PACKAGE BODY pkg_load_geo_locations
IS
    PROCEDURE load_geo_locations
    IS
    BEGIN
        MERGE INTO sal_data.dim_geo_locations sal
            USING (SELECT  geo_id,     
                           group_id,    
                           group_desc,    
                           sub_group_id,
                           sub_group_desc,
                           system_code, 
                           system_desc,   
                           region_desc,   
                           country_code_a2,
                           country_code_a3,
                           country_desc,  
                           part_id,     
                          part_desc 
                    FROM dw_data.dw_geo_locations) dw
            ON (sal.geo_id = dw.geo_id)
            WHEN NOT MATCHED
                THEN
                    INSERT VALUES( dw.geo_id,     
                                   dw.group_id,    
                                   dw.group_desc,    
                                   dw.sub_group_id,
                                   dw.sub_group_desc,
                                   dw.system_code, 
                                   dw.system_desc,   
                                   dw.region_desc,   
                                   dw.country_code_a2,
                                   dw.country_code_a3,
                                   dw.country_desc,  
                                   dw.part_id,     
                                   dw.part_desc );
        
        COMMIT;
    END load_geo_locations;
END pkg_load_geo_locations;