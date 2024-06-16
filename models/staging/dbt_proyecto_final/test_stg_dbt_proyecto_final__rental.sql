{{
  config(
    materialized='incremental',
    unique_key='rental_id',
  )
}}

with base_payment as (
    select *,
           _fivetran_synced as payment_synced
    from {{ ref('base_dbt_proyecto_final__payment') }}
),

base_rental as (
    select *,
           _fivetran_synced as rental_synced
    from {{ ref('base_dbt_proyecto_final__rental') }}
),

final as (
    select 
        r.rental_id,
        r.rental_date,
        r.rental_time,
        r.staff_id as rental_staff_id,
        r.customer_id,
        r.film_id,
        r.return_date as target_return_date,
        p.staff_id as payment_staff_id,
        p.amount,
        p.payment_date,
        {{ add_returned_column('PAYMENT_DATE') }},
        greatest(r.rental_synced, p.payment_synced) as _fivetran_synced,
    from base_rental r  
    left join base_payment p
    on p.rental_id = r.rental_id
    {% if is_incremental() %}
    where greatest(r.rental_synced, p.payment_synced) > (select max(_fivetran_synced) from {{ this }})
    {% endif %}
)

select * from final
order by rental_id desc
