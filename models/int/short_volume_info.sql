with short_volumes as (
    select * from {{ ref('short_volumes') }}
)

select 
    ticker,
    date,
    first(date) over (partition by ticker order by date) 
    as first_short_volume_date_for_ticker,
    last(date) over (partition by ticker order by date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) 
    as most_recent_short_volume_date_for_ticker,
    total_volume,
    short_volume,
    exempt_volume,
    non_exempt_volume,
    short_volume_ratio,
    nyse_short_volume,
    nyse_short_volume_exempt,
    nasdaq_carteret_short_volume,
    nasdaq_carteret_short_volume_exempt,
    nasdaq_chicago_short_volume,
    nasdaq_chicago_short_volume_exempt,
    adf_short_volume,
    adf_short_volume_exempt

from short_volumes
order by ticker, date