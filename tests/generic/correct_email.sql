{% test correct_email(model, column_name) %}


   select *
   from {{ model }}
   where {{ column_name }} NOT LIKE '%@%.%'

{% endtest %}