with short_interests as (
    select * from {{ ref('short_interests') }}
)

select 
    ticker,
    short_interest,
    avg_daily_volume,
    settlement_date,
    first(settlement_date) over (partition by ticker order by settlement_date) 
    as first_settlement_date,
    last(settlement_date) over (partition by ticker order by settlement_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) 
    as last_settlement_date



    from short_interests