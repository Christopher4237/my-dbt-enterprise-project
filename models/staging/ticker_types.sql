{{
    config(
        materialized='incremental',
        unique_key='code'
    )
}}


with ticker_types as (
    
    select 
        code,
        description,
        asset_class,
        locale
    
    from {{ source('stocks_data', 'ticker_types') }}
)

select * from ticker_types