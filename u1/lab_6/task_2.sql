-- Executing all necessary scripts to create database objects

-- Selecting all created objects
SELECT * FROM all_objects
WHERE owner IN ('U_DW_REFERENCES', 'U_DW_EXT_REFERENCES')
    AND (object_name LIKE '%CNTR_GROUP%'
            OR object_name LIKE '%CNTR_SUB_GROUP%'
            OR object_name LIKE '%GEO%'
            OR object_name LIKE '%COUNTRIES%'
            OR object_name LIKE '%ADDRESS%')
ORDER BY object_type, object_name;

-- Selecting data from main tables
SELECT * FROM u_dw_references.t_geo_objects;

SELECT * FROM u_dw_references.t_geo_types;

SELECT * FROM u_dw_references.t_cntr_group_systems;

SELECT * FROM u_dw_references.t_cntr_groups;

SELECT * FROM u_dw_references.t_geo_systems;

SELECT * FROM u_dw_references.t_geo_parts;

SELECT * FROM u_dw_references.t_countries;

SELECT * FROM u_dw_references.t_geo_object_links;