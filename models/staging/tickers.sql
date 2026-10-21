with tickers as (
    select
        ticker, 
        name,
        market,
        locale,
        primary_exchange,
        type,
        active, 
        currency_name,
        substring(last_updated_utc, 0, 10) as last_updated_utc_date

        from {{ source('stocks_data', 'tickers') }}

        where ticker like 'A%'
)

select * from tickers