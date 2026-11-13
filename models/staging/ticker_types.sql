{{
    config(
        materialized='incremental',
        unique_key='code'
    )
}}


with ticker_types as (
    select * from {{ source('stocks_data', 'ticker_types') }}
)

select 
    code,
    description,
    asset_class,
    locale
from ticker_types