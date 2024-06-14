with stg_store as (
    select *
    from {{ref('stg_dbt_proyecto_final__store')}}
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
        concat(st.first_name,' ',st.last_name) as full_name,
        s.address_id,
        s.last_update
    from stg_store s
    join stg_staff st on s.manager_staff_id = st.staff_id
     
)

select * from final 