-- macros.sql

{% macro calculate_rental_state(payment_date) %}
    case 
        when {{ payment_date }} is null then 'Rented'
        else 'Returned'
    end
{% endmacro %}
