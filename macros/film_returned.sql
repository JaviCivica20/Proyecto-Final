{% macro add_returned_status(rental_table, payment_table) %}
    {{ log("Adding returned status column", info=True) }}
    
    with rentals as (
        select
            r.*,
            case
                when p.rental_id is not null then true
                else false
            end as returned
        from {{ rental_table }} r
        left join {{ payment_table }} p
        on r.rental_id = p.rental_id
    )

    select * from rentals
{% endmacro %}
