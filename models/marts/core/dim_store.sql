with stg_store as (
    select *
    from {{ref('stg_dbt_proyecto_final__store')}}
),

stg_address as (
    select * 
    from {{ref('stg_dbt_proyecto_final__address')}}
),

stg_staff as (
    select 
        staff_id,
        first_name,
        last_name
    from {{ref('stg_dbt_proyecto_final__staff')}}
),

final as (
    select  
        s.store_id,
        st.first_name,
        st.last_name,
        a.address,
        a.city,
        a.country,
        a.postal_code,
        s.last_update
    from stg_address a 
    join stg_store s on s.address_id = a.address_id
    join stg_staff st on s.manager_staff_id = st.staff_id 
)

select * from final 