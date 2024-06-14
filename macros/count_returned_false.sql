{% macro count_returned_false(source_table, user_id_column, returned_column) %}
    SELECT 
        {{ user_id_column }} AS customer_id,
        COUNT(*) AS returned_false_count
    FROM {{ source_table }}
    WHERE {{ returned_column }} = FALSE
    GROUP BY {{ user_id_column }}
{% endmacro %}
