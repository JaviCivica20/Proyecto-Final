with stg_rental as (
    select *
    from {{ref('stg_dbt_proyecto_final__rental')}}
),

final as (
    select 
        rental_id,
        rental_date,
        rental_time,
        rental_staff_id,
        customer_id,
        film_id,
        target_return_date,
        payment_staff_id,
        amount,
        payment_date,
        returned,
        last_update
    from stg_rental 
)

select * from final 