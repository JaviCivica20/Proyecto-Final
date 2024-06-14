with base_payment as (
    select *
    from {{ref('base_dbt_proyecto_final__payment')}}
),

base_rental as (
    select *
    from {{ref('base_dbt_proyecto_final__rental')}}
),

final as (
    select 
        r.rental_id,
        r.rental_date,
        r.rental_time,
        r.staff_id as rental_staff_id,
        r.customer_id,
        r.film_id,
        r.return_date as target_return_date,
        p.staff_id as payment_staff_id,
        p.amount,
        p.payment_date,
        {{ add_returned_column('PAYMENT_DATE') }},
        r._fivetran_synced
    from base_rental r  
    left join base_payment p
    on p.rental_id = r.rental_id
)

select * from final 
