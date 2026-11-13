{{
    config(
        materialized='incremental',
        unique_key='ticker'
    )
}}

with floats as (
    select 
        ticker,
        free_float,
        effective_date,
        free_float_percent

    from {{ source('stocks_data', 'floats') }}

    where ticker like 'A%'

)

select * from floats