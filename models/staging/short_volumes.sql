select

    ticker,
    date,
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

from {{ source('stocks_data', 'short_volumes') }}

where ticker like 'A%'