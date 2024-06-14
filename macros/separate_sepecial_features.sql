{% set special_features = ['trailers', 'commentaries', 'behind_the_scenes','deleted_scenes'] %}
WITH stg_film AS (
    SELECT * 
    FROM {{ ref('stg_dbt_proyecto_final__film') }}
),

final AS (
    SELECT
        film_id,
        {%- for fea in special_features   %}
        case when '{{fea}}' ilike '%{{fea}}%' then true else false end as {{fea}}
        {%- if not loop.last %},{% endif -%}
        {% endfor %}
    FROM stg_film
    GROUP BY 1
    )

SELECT * FROM final