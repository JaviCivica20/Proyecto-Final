/* Crea una columna nueva para poner un aviso en los usuarios
que no hayan devuelto más de 5 películas */

{% macro add_warning_column(no_returns) %}
    CASE 
        WHEN {{ no_returns }} > 5 THEN TRUE
        ELSE FALSE
    END AS user_warning
{% endmacro %}
