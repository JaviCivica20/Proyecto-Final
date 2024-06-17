with fct_purchase as (
    select * 
    from {{ref('stg_dbt_proyecto_final__purchases')}}
),

final as (
    select
        store_id,
        film_id,
        current_date as stock_today,
        count(film_id) as film_stock
    from fct_purchase
    group by 1, 2, 3
    order by 1, 2, 3
)

select * from final 