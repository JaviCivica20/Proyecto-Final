with fct_rentals_returns as (
    select 
        store_id,
        year(payment_date) as year,
        sum(amount) as total_earnings,
        count(rental_id) as total_rentals
    from {{ref('fct_rentals_returns')}} 
    group by 1, 2
    order by 1, 2

),

fct_purchases as (
    select
        store_id,
        year(purchase_date) as year,
        sum(amount) as total_expenses,
        count(purchase_id) as total_purchases
    from {{ref('fct_purchases')}} 
    group by 1, 2
    order by 1, 2
),

final as (
    select
        r.store_id,
        coalesce(r.year, p.year) as year,
        total_earnings,
        total_expenses,
        total_earnings - total_expenses as total_profits,
        total_rentals,
        total_purchases
    from fct_rentals_returns r 
    join fct_purchases p on r.store_id = p.store_id and r.year = p.year
)

select * from final order by 1, 2