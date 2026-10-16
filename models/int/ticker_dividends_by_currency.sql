with tickers as (
    select * from {{ ref('tickers') }}
),

dividends as (
    select ticker, 
        distribution_type, 
        count(*) as dividend_count
        from {{ ref('dividends') }}
        group by ticker, distribution_type
)

select 
    tickers.ticker,
    tickers.name,
    tickers.market,
    tickers.locale,
    tickers.primary_exchange,
    tickers.type,
    dividends.dividend_count,
    dividends.distribution_type,
    case 
        when tickers.active is True then 'active'
        else 'inactive'
    end as status
    from tickers
    left join dividends using (ticker)