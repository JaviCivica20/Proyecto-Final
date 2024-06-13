with stg_customer as (
    select *
    from {{ref('stg_dbt_proyecto_final__customer')}}
),

stg_address as (
    select *
    from {{ref('stg_dbt_proyecto_final__address')}}
),

final as (
    select
        c.customer_id,
        c.first_name,
        c.last_name,
        concat(c.first_name,' ',c.last_name) as full_name,
        c.email,
        c.active,
        c.create_date,
        c.create_time,
        a.address,
        a.city,
        a.country,
        a.postal_code,
        c.last_update
    from stg_customer c 
    join stg_address a 
    on c.address_id = a.address_id
    order by 1
)

select * from final