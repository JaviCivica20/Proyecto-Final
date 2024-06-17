/*{{
  config(
    materialized='ephemeral'
  )
}}*/

with rentals as (
        select
            r.rental_id,
            r.customer_id,
            r.film_id,
            r.rental_date,
            r.rental_time,
            r.target_return_date,
            coalesce(p.payment_date, 'rented') as payment_date
            coalesce(p.amount, 'rented') as amount
            coalesce({{add_returned_column('payment_date')}}, 'rented') as returned,

            case when returned = false then
            datediff(day, target_return_date, current_date)    ------ Comprobar cuando Snowflake rule
            else datediff(day, target_return_date, payment_date)
            end as return_delay_days

        from {{ ref('stg_rental_snapshot') }} r
        left join {{ ref('stg_payment_snapshot') }} p
        on r.rental_id = p.rental_id
    )

    select * from rentals


