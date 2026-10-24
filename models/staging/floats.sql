select 
    ticker,
    free_float,
    effective_date,
    free_float_percent

from {{ source('stocks_data', 'floats') }}

where ticker like 'A%'