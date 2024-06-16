with rentals as (
        select
            r.*,
            case
                when p.rental_id is not null then true
                else false
            end as returned,

            case when returned = false then
            datediff(day, rental_date, current_date) 
            else 0
            end as return_delay_days
        from {{ ref('base_dbt_proyecto_final__rental') }} r
        left join {{ ref('base_dbt_proyecto_final__payment') }} p
        on r.rental_id = p.rental_id
    )

    select * from rentals


