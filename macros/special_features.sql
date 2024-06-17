{% macro generate_special_features_conditions(column_name) %}
    {% set features = ['trailers', 'commentaries', 'behind the scenes', 'deleted scenes'] %}
    {% for feature in features %}
        CASE WHEN {{ column_name }} ILIKE '%{{ feature }}%' THEN TRUE ELSE FALSE END AS {{ feature | replace(' ', '_') }}{% if not loop.last %},{% endif %}
    {% endfor %}
{% endmacro %}
