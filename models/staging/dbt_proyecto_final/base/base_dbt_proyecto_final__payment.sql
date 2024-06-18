{{
  config(
    materialized='incremental',
    unique_key='payment_id',
  )
}}

with src_payment as (
    select * from {{ source('dbt_proyecto_final', 'payment') }}

{% if is_incremental() %}

	where _fivetran_synced > (select max(date_load) from {{ this }})

{% endif %}    

),

renamed_casted as (
    select
        payment_id::number(10) as payment_id,
        customer_id::number(10) as customer_id,
        staff_id::number(10) as payment_staff_id,
        rental_id::number(10) as rental_id,
        
        case when datediff(day, rental_date, payment_date) < 1 then rental_rate_price ----- Cambiamos las cantidades de pago en relación a los días de alquiler por el precio diario
        else datediff(day, rental_date, payment_date) * rental_rate_price 
        end as amount,

        amount::number(10,2) as bad_amount,
        payment_date,
        _fivetran_synced as date_load
    from src_payment
    join {{ref('base_dbt_proyecto_final__rental')}} using(rental_id)
    join {{ref('stg_dbt_proyecto_final__film')}} using(film_id)
)

select * from renamed_casted order by payment_id desc



