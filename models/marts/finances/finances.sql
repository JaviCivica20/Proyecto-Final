with fct_rentals_returns as (
    select 
        store_id,
        year_number,
        sum(amount) as total_earnings
    from {{ref('fct_rentals_returns')}} r
    join {{ref('dim_date')}} d on year(r.payment_date) = d.year_number
    group by 1, 2
    order by 1, 2

),

fct_purchases as (
    select
        store_id,
        year_number,
        sum(amount) as total_expenses
    from {{ref('fct_purchases')}} p
    join {{ref('dim_date')}} d on year(p.purchase_date) = d.year_number
    group by 1, 2
    order by 1, 2
),

final as (
    select
        r.store_id,
        r.year_number,
        total_earnings,
        total_expenses,
        total_earnings - total_expenses as total_profits
    from fct_rentals_returns r 
    join fct_purchases p on r.store_id = p.store_id and r.year_number = p.year_number
)

select * from final order by 1, 2