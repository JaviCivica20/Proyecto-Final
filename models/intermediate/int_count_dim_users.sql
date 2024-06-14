{{ config(materialized='ephemeral') }}


WITH user_returned_counts AS (
    {{ count_returned_false(
        source_table=ref('fct_rental'),  
        user_id_column='customer_id',      
        returned_column='RETURNED'      
    ) }}
)

SELECT
    * from user_returned_counts
