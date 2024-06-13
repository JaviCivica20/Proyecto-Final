with stg_customer as (
    select *
    from {{ref('stg_dbt_proyecto_final__customer')}}
),

final as (
    select
        customer_id,
        first_name,
        last_name,
        concat(first_name,' ',last_name) as full_name,
        address_id,
        email,
        active,
        create_date,
        create_time,
        last_update
    from stg_customer
)

select * from final