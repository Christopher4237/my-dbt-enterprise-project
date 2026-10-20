with split_data as (
    select
        ticker,
        execution_date, 
        split_from,
        split_to,
        adjustment_type, 
        round(historical_adjustment_factor, 3) as historical_adjustment_factor

    from {{ source('stocks_data', 'splits') }}

    where ticker like 'A%'

)

select * from split_data