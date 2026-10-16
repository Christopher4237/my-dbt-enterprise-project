with splits as (
    select * from {{ ref('splits') }}
)

select 
    ticker, 
    execution_date,
    date_diff(day, execution_date, lag(execution_date) over (partition by ticker order by execution_date)) as days_since_last_split

    from splits
