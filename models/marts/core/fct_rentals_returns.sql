
{{
  config(
    materialized='incremental',
    unique_key='rental_id',
  )
}}

with rentals as (
        select
            rental_id,
            customer_id,
            store_id,
            film_id,
            rental_staff_id,
            rental_date,
            rental_time,
            target_return_date,
            payment_id,
            payment_staff_id,
            payment_date, 
            correct_amount as amount,
            returned,
            return_delay_days,
            date_load

        from {{ ref('int_rental_payment_combined') }} 

    {% if is_incremental() %}

	where date_load > (select max(date_load) from {{ this }})

    {% endif %}
    
    )

    select * from rentals 

    
