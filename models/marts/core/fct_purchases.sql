{{
  config(
    materialized='incremental',
    unique_key='purchase_id',
  )
}}

with stg_purchases as (
    select * from {{ ref('stg_dbt_proyecto_final__purchases') }}

{% if is_incremental() %}

	where data_load > (select max(data_load) from {{ this }})

{% endif %}

),

final as (
    select
        purchase_id,
        film_id,
        store_id,
        quantity,
        amount,
        purchase_date,
        data_load
    from stg_purchases
)

select * from final


