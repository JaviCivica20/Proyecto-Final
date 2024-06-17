

with rentals as (
        select
            r.rental_id,
            r.customer_id,
            r.film_id,
            rental_staff_id,
            r.rental_date,
            r.rental_time,
            r.target_return_date,
            {{ calculate_rental_state('p.payment_date') }} as rental_state,

            /*case when p.payment_date is null then 'Rented'
            else 'Returned'
            end as rental_state,*/

            p.payment_id,
            payment_staff_id,
            p.payment_date,
            p.amount,
            {{add_returned_column('payment_date')}},
            {{ calculate_return_delay_days('returned', 'target_return_date', 'payment_date') }} as return_delay_days,
            
            greatest(r.date_load, coalesce(p.date_load, '1970-01-01')) as date_load
        from {{ ref('base_dbt_proyecto_final__rental') }} r
        left join {{ ref('base_dbt_proyecto_final__payment') }} p
        on r.rental_id = p.rental_id

    
    )

    select * from rentals 

