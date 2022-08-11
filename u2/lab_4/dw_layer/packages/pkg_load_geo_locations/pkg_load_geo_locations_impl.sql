ALTER SESSION SET CURRENT_SCHEMA = dw_data;
CREATE OR REPLACE PACKAGE BODY pkg_load_geo_locations
IS
    PROCEDURE load_geo_locations
    IS
        TYPE location_t IS TABLE OF dw_data.dw_geo_location%ROWTYPE;

        CURSOR c IS
             SELECT geo.country_geo_id AS geo_id,
                    cnt_gr.group_id,
                    cnt_gr.group_desc,
                    cnt_sub_gr.sub_group_id,
                    cnt_sub_gr.sub_group_desc,
                    gs.geo_system_code,
                    gs.geo_system_desc,
                    reg.region_id,
                    reg.region_desc
                    cnt.country_code_a2,
                    cnt.country_code_a3,
                    cnt.region_desc AS country_desc,
                    prt.part_id,
                    prt.part_desc
            FROM (SELECT country_geo_id,
                        SUM(region) AS region_geo_id,
                        SUM(part) AS part_geo_id,
                        SUM (country_group) AS country_group_geo_id,
                        SUM (country_sub_group) AS country_sub_group_geo_id,
                        SUM (geo_system) AS system_geo_id
                  FROM (SELECT CONNECT_BY_ROOT(child_geo_id) AS country_geo_id,
                                parent_geo_id,
                                link_type_id,
                                DECODE (link_type_id, 1, parent_geo_id ) AS geo_system,
                                DECODE(link_type_id, 2, parent_geo_id) AS part,
                                DECODE(link_type_id, 3, parent_geo_id) AS region,
                                DECODE (link_type_id, 5, parent_geo_id ) AS country_group,
                                DECODE (link_type_id, 6, parent_geo_id ) AS country_sub_group
                        FROM u_dw_references.w_geo_object_links
                        CONNECT BY PRIOR parent_geo_id = child_geo_id
                        START WITH child_geo_id IN (SELECT DISTINCT geo_id FROM u_dw_references.cu_countries))
                  GROUP BY country_geo_id) geo
            LEFT JOIN u_dw_references.cu_countries cnt
            ON (geo.country_geo_id = cnt.geo_id)
            LEFT JOIN u_dw_references.cu_geo_regions reg
            ON (geo.region_geo_id = reg.geo_id)
            LEFT JOIN u_dw_references.cu_geo_parts prt
            ON (geo.part_geo_id = prt.geo_id)
            LEFT JOIN u_dw_references.cu_cntr_groups cnt_gr
            ON (geo.country_group_geo_id = cnt_gr.geo_id )
            LEFT JOIN u_dw_references.cu_cntr_sub_groups cnt_sub_gr
            ON (geo.country_sub_group_geo_id = cnt_sub_gr.geo_id )
            LEFT JOIN u_dw_references.cu_geo_systems gs
            ON (geo.system_geo_id = gs.geo_id);

    BEGIN
        FOR i IN c LOOP
            IF i.geo_id NOT IN (SELECT geo_id FROM dw_data.dw_geo_location) THEN
                INSERT INTO dw_data.dw_geo_location
                                (   
                                    geo_id,     
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
                                )
                        VALUES
                            (
                                i.geo_id,        
                                i.group_id,    
                                i.group_desc,    
                                i.sub_group_id,
                                i.sub_group_desc,
                                i.system_code, 
                                i.system_desc,   
                                i.region_desc,   
                                i.country_code_a2,
                                i.country_code_a3,
                                i.country_desc,  
                                i.part_id,    
                                i.part_desc
                            );
            END IF;
            EXIT WHEN c%NOTFOUND;
        END LOOP;
        COMMIT;
    END load_stores;
END pkg_load_stores;