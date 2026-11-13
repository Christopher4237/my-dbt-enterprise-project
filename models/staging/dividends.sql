with dividend_data as (
    select 
        ticker, 
        record_date, 
        pay_date,
        ex_dividend_date, 
        frequency,
        cash_amount,
        currency,
        distribution_type,
        declaration_date, 
        historical_adjustment_factor,
        split_adjusted_cash_amount

    from {{ source('stocks_data', 'dividends') }}

    where ticker like 'A%'
)

select * from dividend_data