
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
            film_id,
            rental_date,
            rental_time,
            target_return_date,
            rental_state,
            payment_id,
            payment_date,
            amount,
            returned,
            return_delay_days,
            data_load

        from {{ ref('stg_rental_payment_combined') }} 

    {% if is_incremental() %}

	where data_load > (select max(data_load) from {{ this }})

    {% endif %}
    
    )

    select * from rentals 

    
