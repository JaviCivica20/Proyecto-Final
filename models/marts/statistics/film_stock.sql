with fct_purchase as (
    select * 
    from {{ref('fct_purchases')}}
),

final as (
    select
        store_id,
        film_id,
        count(film_id) as film_stock
    from fct_purchase
    group by 1, 2
    order by 1, 2
)

select * from final 