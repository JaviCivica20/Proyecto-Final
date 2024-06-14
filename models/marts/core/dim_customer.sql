with stg_customer as (
    select *
    from {{ref('stg_dbt_proyecto_final__customer')}}
),

user_returned_counts AS (
    
    {{ count_returned_false(
        source_table=ref('fct_rental'),  
        user_id_column='customer_id',      
        returned_column='RETURNED'      
    ) }}
),

final as (
    select
        c.customer_id,
        first_name,
        last_name,
        concat(first_name,' ',last_name) as full_name,
        address_id,
        email,
        active,
        coalesce(returned_false_count,0) as no_returns,
        {{add_warning_column('no_returns')}},
        create_date,
        create_time,
        last_update
    from stg_customer c
    LEFT JOIN user_returned_counts u ON c.customer_id = u.customer_id
)

select * from final