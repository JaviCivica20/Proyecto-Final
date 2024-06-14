/* Crea una columna nueva para saber si una película ha sido devuelta o no
a partir si el campo de pago */

{% macro add_returned_column(payment_date_column) %}
    CASE 
        WHEN {{ payment_date_column }} IS NOT NULL THEN TRUE
        ELSE FALSE
    END AS RETURNED
{% endmacro %}
