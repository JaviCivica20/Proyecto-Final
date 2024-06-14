{% macro add_returned_column(payment_date_column) %}
    CASE 
        WHEN {{ payment_date_column }} IS NOT NULL THEN TRUE
        ELSE FALSE
    END AS RETURNED
{% endmacro %}
