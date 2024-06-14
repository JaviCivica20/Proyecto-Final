WITH special_features_cte AS (
    SELECT
        film_id,
        CASE WHEN special_features ILIKE '%trailers%' THEN TRUE ELSE FALSE END AS trailers,
        CASE WHEN special_features ILIKE '%commentaries%' THEN TRUE ELSE FALSE END AS commentaries,
        CASE WHEN special_features ILIKE '%behind the scenes%' THEN TRUE ELSE FALSE END AS behind_the_scenes,
        CASE WHEN special_features ILIKE '%deleted scenes%' THEN TRUE ELSE FALSE END AS deleted_scenes
    FROM {{ ref('stg_dbt_proyecto_final__film') }}
)

SELECT * FROM special_features_cte