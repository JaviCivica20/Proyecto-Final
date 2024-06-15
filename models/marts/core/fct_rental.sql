/*{{
  config(
    materialized='incremental',
    unique_key='rental_key',
  )
}}*/

with stg_rental as (
    select *
    from {{ref('stg_dbt_proyecto_final__rental')}}
),

final as (
    select 
        {{dbt_utils.generate_surrogate_key(['rental_id'])}} as rental_key,
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
        _fivetran_synced
    from stg_rental 
)

select * from final order by rental_id desc


/*{% if is_incremental() %}

	where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}*/