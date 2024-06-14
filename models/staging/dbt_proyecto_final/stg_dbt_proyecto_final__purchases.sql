{{
  config(
    materialized='incremental',
    unique_key='purchase_id',
  )
}}

with src_purchases as (
    select * from {{ source('dbt_proyecto_final', 'purchases') }}
),

renamed_casted as (
    select
        purchase_id::number(10) as purchase_id,
        film_id::number(10) as film_id,
        store_id::number(10) as store_id,
        quantity::number(10) as quantity,
        amount::number(10,2) as amount,
        purchase_date,
        _fivetran_synced
    from src_purchases
)

select * from renamed_casted
 

 {% if is_incremental() %}

	where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}
