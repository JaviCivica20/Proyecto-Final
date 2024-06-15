{% snapshot fact_order_items_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='rental_id',
      strategy='timestamp',
      updated_at='_fivetran_synced'
    )
}}

with base_rental as (
    select *
    from {{ ref("base_dbt_proyecto_final__rental") }}
    where _fivetran_synced = (select max(_fivetran_synced) from {{ ref('base_dbt_proyecto_final__rental') }})   
),

base_payment as (
    select *,
    from {{ref('base_dbt_proyecto_final__payment')}}
    where _fivetran_synced = (select max(_fivetran_synced) from {{ ref('base_dbt_proyecto_final__payment') }}) 
),

final as (
    select 
        rental_id,
        rental_date,
        rental_time,
        staff_id as rental_staff_id,
        customer_id,
        film_id,
        return_date as target_return_date,
        staff_id as payment_staff_id,
        amount,
        payment_date,
        {{ add_returned_column('PAYMENT_DATE') }},
        _fivetran_synced
    from base_rental 
    left join base_payment 
    using(rental_id)
)

select * from final order by rental_id DESC


{% endsnapshot %}