with stg_staff as (
    select *
    from {{ref('stg_dbt_proyecto_final__staff')}}
),

stg_address as (
    select *
    from {{ref('stg_dbt_proyecto_final__address')}}
),

final as (
    select
        s.staff_id,
        s.first_name,
        s.last_name,
        s.email,
        s.active,
        s.username,
        s.password,
        a.address,
        a.city,
        a.country,
        a.postal_code,
        s.last_update
    from stg_staff s 
    join stg_address a 
    on s.address_id = a.address_id
    order by 1
)

select * from final