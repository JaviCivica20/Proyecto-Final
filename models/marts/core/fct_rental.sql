with stg_payment as (
    select *,
    from {{ref('stg_dbt_proyecto_final__payment')}}
),

stg_rental as (
    select *
    from {{ref('stg_dbt_proyecto_final__rental')}}
),

final as (
    select 
        r.rental_id,
        r.rental_date,
        r.rental_time,
        r.staff_id as rental_staff_id,
        r.customer_id,
        r.film_id,
        r.return_date,
        p.staff_id as payment_staff_id,
        p.amount,
        p.payment_date,
        {{ add_returned_column('PAYMENT_DATE') }},
        r.last_update
    from stg_rental r  
    left join stg_payment p
    on p.rental_id = r.rental_id
)

select * from final 