-- Executing all necessary scripts to create database objects

-- Selecting all created objects
SELECT * FROM all_objects
WHERE owner IN ('U_DW_REFERENCES',
                'U_DW_EXT_REFERENCES')
ORDER BY object_type, object_name;

-- Selecting data from specified objects

-- t_localizations
SELECT * FROM u_dw_references.t_localizations;

-- cu_languages
SELECT * FROM u_dw_references.cu_languages;

-- w_lng_links
SELECT * FROM u_dw_references.w_lng_links;

-- cu_lng_scopes
SELECT * FROM u_dw_references.cu_lng_scopes;

-- cu_lng_types
SELECT * FROM u_dw_references.cu_lng_types;