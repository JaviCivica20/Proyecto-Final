{{
  config(
    materialized='ephemeral'
  )
}}

with rentals as (
        select
            r.rental_id,
            r.customer_id,
            r.film_id,
            r.rental_date,
            r.rental_time,
            r.target_return_date,
            p.payment_date,
            p.amount,
            {{add_returned_column('payment_date')}},

            case when returned = false then
            datediff(day, target_return_date, payment_date) 
            else 0
            end as return_delay_days

        from {{ ref('stg_dbt_proyecto_final__rental') }} r
        left join {{ ref('stg_dbt_proyecto_final__payment') }} p
        on r.rental_id = p.rental_id
    )

    select * from rentals


