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

	where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})
    or rental_synced > (select max(_fivetran_synced) from {{ this }})
    or payment_synced > (select max(_fivetran_synced) from {{ this }})

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
        payment_staff_id,
        amount,
        payment_date,
        returned,
        rental_synced,
        payment_synced,
        GREATEST(rental_synced, payment_synced) as _fivetran_synced
    from stg_rental 
)

select * from final order by rental_id desc


