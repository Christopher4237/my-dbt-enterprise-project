with short_volumes as (
    select * from {{ ref('short_volumes') }}
)

select 
    ticker,
    date,
    total_volume,
    short_volume,
    short_volume_ratio,
    sum(total_volume) over (partition by ticker order by date) as running_total_volume,
    sum(short_volume) over (partition by ticker order by date) as running_short_volume,
    round(running_short_volume / running_total_volume, 3) as running_short_volume_ratio,

    sum(nyse_short_volume) over (partition by ticker order by date) as running_total_nyse_short_volume,
    round(running_total_nyse_short_volume / running_short_volume, 3) as running_short_volume_that_is_nyse_ratio,

    sum(nasdaq_carteret_short_volume) over (partition by ticker order by date) as running_total_nasdaq_carteret_short_volume,
    round(running_total_nasdaq_carteret_short_volume / running_short_volume, 3) as running_short_volume_that_is_nasdaq_carteret_ratio,

    sum(nasdaq_chicago_short_volume) over (partition by ticker order by date) as running_total_nasdaq_chicago_short_volume,
    round(running_total_nasdaq_chicago_short_volume / running_short_volume, 3) as running_short_volume_that_is_nasdaq_chicago_ratio,

    sum(adf_short_volume) over (partition by ticker order by date) as running_total_adf_short_volume,
    round(running_total_adf_short_volume / running_short_volume, 3) as running_short_volume_that_is_adf_ratio

from short_volumes