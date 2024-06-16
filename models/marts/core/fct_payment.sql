with stg_payment as (
    select *
    from {{ref('stg_dbt_proyecto_final__payment')}}
),

int_returned_and_delays as (
    select
        rental_id,
        returned,
        return_delay_days
    from {{ref('int_returned_and_delays')}}
),

final as (
    select
        payment_id,
        payment_staff_id,
        customer_id,
        p.rental_id,
        amount,
        payment_date,
        return_delay_days,
        data_load
    from stg_payment p 
    left join int_returned_and_delays i 
    on p.rental_id = i.rental_id
)

select * from final 