{{
  config(
    materialized='incremental',
    unique_key='rental_id',
  )
}}

with stg_rental as (
    select *
    from {{ref('stg_dbt_proyecto_final__rental')}}

{% if is_incremental() %}

	where data_load > (select max(data_load) from {{ this }})

{% endif %}
),

final as (
    select 
        rental_id,
        rental_date,
        rental_time,
        rental_staff_id,
        customer_id,
        film_id,
        target_return_date,
        data_load
    from stg_rental 
    
)

select * from final order by rental_id desc


