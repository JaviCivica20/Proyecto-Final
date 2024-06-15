{{
  config(
    materialized='incremental',
    unique_key='rental_id',
  )
}}

with src_rental as (
    select * from {{ source('dbt_proyecto_final', 'rental') }}

{% if is_incremental() %}

	where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}


),

renamed_casted as (
    select
        rental_id::number(10) as rental_id,
        DATE(rental_date) as rental_date,
        DATE_TRUNC('seconds',TIME(rental_date)) as rental_time,
        customer_id::number(10) as customer_id,
        film_id::number(10) as film_id,
        return_date,
        staff_id::number(10) as staff_id,
        _fivetran_synced
    from src_rental
)

select * from renamed_casted ORDER BY rental_id DESC


