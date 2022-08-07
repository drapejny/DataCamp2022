-- Creating tablespace
CREATE TABLESPACE ts_geo_backup
DATAFILE '/oracle/u02/oradata/ASlizhdb/ts_geo_backup.dat'
SIZE 150M
AUTOEXTEND ON NEXT 50M
SEGMENT SPACE MANAGEMENT AUTO;

-- Creating user
CREATE USER u_geo_backup
IDENTIFIED BY "%PWD%"
DEFAULT TABLESPACE ts_geo_backup;

-- Assigning privileges
GRANT CONNECT, RESOURCE, SELECT ANY TABLE TO u_geo_backup;
ALTER USER u_geo_backup QUOTA UNLIMITED ON ts_geo_backup;

DROP TABLE u_geo_backup.t_geo_denorm;

-- Creating denormalized table
CREATE TABLE u_geo_backup.t_geo_denorm
AS        
    SELECT LPAD(' ', 2 * lvl, ' ') || geos.geo_id AS geo_id,
       parent_geo_id,
       DECODE(( SELECT COUNT(*)
                    FROM u_dw_references.t_geo_object_links links
                    WHERE links.parent_geo_id = geos.geo_id),
                  0,
                  NULL,
                  ( SELECT COUNT(*)
                    FROM u_dw_references.t_geo_object_links links
                   WHERE links.parent_geo_id = geos.geo_id
                   )
                  ) AS child_count,
       lvl,
       id_type,
       path,
       syst.geo_system_code,
       prt.part_desc,
       rg.region_desc,
       cnt.country_desc
    FROM (
        SELECT geo_id,
                parent_geo_id,
                LEVEL AS lvl,
                DECODE(LEVEL, 1, 'ROOT', 4, 'LEAF', 'BRANCH') AS id_type,
                SYS_CONNECT_BY_PATH(geo_id, '->') AS path,
                REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(geo_id, '->'), '->(\d+)', 1, 1, NULL, 1) AS geo_sys_id,
                REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(geo_id, '->'), '->(\d+)', 1, 2, NULL, 1) AS geo_part_id,
                REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(geo_id, '->'), '->(\d+)', 1, 3, NULL, 1) AS geo_reg_id,
                REGEXP_SUBSTR(SYS_CONNECT_BY_PATH(geo_id, '->'), '->(\d+)', 1, 4, NULL, 1) AS geo_country_id
         FROM (
                  SELECT *
                  FROM u_dw_references.t_geo_objects
                           LEFT OUTER JOIN u_dw_references.t_geo_object_links ON child_geo_id = geo_id
              )
         START WITH parent_geo_id IS NULL
         CONNECT BY PRIOR geo_id = parent_geo_id
         ORDER SIBLINGS BY geo_id
     )  geos
         LEFT OUTER JOIN u_dw_references.lc_geo_systems syst ON syst.geo_id = geo_sys_id
         LEFT OUTER JOIN u_dw_references.lc_geo_parts prt on prt.geo_id = geo_part_id
         LEFT OUTER JOIN u_dw_references.lc_geo_regions rg on rg.geo_id = geo_reg_id
         LEFT OUTER JOIN u_dw_references.lc_countries cnt on cnt.geo_id = geo_country_id;
     
-- Showing results
SELECT * FROM u_geo_backup.t_geo_denorm;