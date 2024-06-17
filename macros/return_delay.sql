-- macros.sql

{% macro calculate_return_delay_days(returned, target_return_date, payment_date) %}
    case 
        when {{ returned }} = false then datediff(day, {{ target_return_date }}, current_date)   
        else datediff(day, {{ target_return_date }}, {{ payment_date }})
    end
{% endmacro %}
