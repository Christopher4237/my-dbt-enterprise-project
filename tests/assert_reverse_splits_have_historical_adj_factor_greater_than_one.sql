select 
    ticker,
    try_cast(historical_adjustment_factor as decimal(25,10)) as updated_datatype
from {{ ref('splits') }}
where adjustment_type = 'reverse_split'
and (try_cast(historical_adjustment_factor as decimal(25,10)) < 1 
or try_cast(historical_adjustment_factor as decimal(25,10)) is null)