with splits as (
    select * from {{ ref('splits') }}
)

select 
    ticker, 
    execution_date,
    date_diff(day, lag(execution_date) over (partition by ticker, adjustment_type order by execution_date), execution_date) as days_since_last_similar_type_of_split,
    adjustment_type as type_of_split,
    historical_adjustment_factor

    from splits
    order by ticker, execution_date
