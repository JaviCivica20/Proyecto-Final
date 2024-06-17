

with rentals as (
        select
            r.rental_id,
            r.customer_id,
            r.film_id,
            r.rental_date,
            r.rental_time,
            r.target_return_date,

            case when p.payment_date is null then 'Rented'
            else 'Returned'
            end as rental_state,

            p.payment_id,
            p.payment_date,
            p.amount,
            {{add_returned_column('payment_date')}},

            case when returned = false then
            datediff(day, target_return_date, current_date)   
            else datediff(day, target_return_date, payment_date)
            end as return_delay_days,

            greatest(r.data_load, coalesce(p.data_load, '1970-01-01')) as data_load

        from {{ ref('stg_dbt_proyecto_final__rental') }} r
        left join {{ ref('stg_dbt_proyecto_final__payment') }} p
        on r.rental_id = p.rental_id

    
    )

    select * from rentals 

