{{
    config(
        enabled = false
    )
}}

with condition_codes as (
    select 
        * 
    from {{ source('stocks_data', 'condition_codes') }}
)

select 
    name, 
    asset_class,
    data_types
from condition_codes