{{
  config(
    materialized='incremental',
    unique_key='purchase_id',
  )
}}

with stg_purchases as (
    select * from {{ ref('stg_dbt_proyecto_final__purchases') }}

{% if is_incremental() %}

	where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

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
        _fivetran_synced
    from stg_purchases
)

select * from final


