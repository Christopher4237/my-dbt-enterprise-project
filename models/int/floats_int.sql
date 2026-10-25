with floats as (
    select * from {{ ref('floats') }}
)

select
    ticker,
    free_float,
    effective_date,
    free_float_percent

from floats;