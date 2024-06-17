with stg_staff as (
    select *
    from {{ref('stg_dbt_proyecto_final__staff')}}
),

final as (
    select
        staff_id,
        first_name,
        last_name,
        concat(first_name,' ',last_name) as full_name,
        address_id,
        email,
        active,
        username,
        password,
        date_load
    from stg_staff s 
)

select * from final