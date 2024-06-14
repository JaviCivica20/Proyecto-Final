-- macros/split_special_features.sql

{% macro split_special_features() %}
{% set features = ['trailers', 'commentaries', 'behind the scenes', 'deleted scenes'] %}

with special_features_cte as (
    select
        film_id,
        {% for feature in features %}
            case when feature like '%{{ feature }}%' then true else false end as {{ feature | replace(' ', '_') }}{% if not loop.last %},{% endif %}
        {% endfor %}
    from {{ this }}
)
select * from special_features_cte
{% endmacro %}
