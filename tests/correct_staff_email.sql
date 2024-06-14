SELECT email 
FROM {{ ref('stg_dbt_proyecto_final__staff') }}
WHERE email NOT LIKE '%@%.%'