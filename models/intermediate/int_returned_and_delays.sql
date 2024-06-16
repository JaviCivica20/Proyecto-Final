{{
  config(
    materialized='ephemeral'
  )
}}


with rentals as (
        select
            r.rental_id,
            r.customer_id,
            r.rental_date,
            r.rental_time,
            r.return_date,

            case
                when p.rental_id is not null then true
                else false
            end as returned,

            p.payment_date,

            case when returned = false then
            datediff(day, return_date, current_date) 
            else 0
            end as return_delay_days
        from {{ ref('stg_dbt_proyecto_final__rental') }} r
        left join {{ ref('stg_dbt_proyecto_final__payment') }} p
        on r.rental_id = p.rental_id
    )

    select * from rentals


