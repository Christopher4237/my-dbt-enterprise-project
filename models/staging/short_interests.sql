{{
    config(
        materialized='incremental',
        unique_key=['ticker', 'settlement_date']
    )
}}

with short_interests as (

    select
        ticker,
        short_interest,
        avg_daily_volume,
        days_to_cover, 
        settlement_date

    from {{ source('stocks_data', 'short_interest') }}

    where ticker like 'A%'

)
select * from short_interests