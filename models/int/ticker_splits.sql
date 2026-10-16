with tickers as (
    select * from {{ ref('tickers') }}
),

splits as (
    select ticker, 
        adjustment_type, 
        count(*) as split_count
        from {{ ref('splits') }}
        group by ticker, adjustment_type
)

select 
    tickers.ticker,
    tickers.name,
    tickers.market,
    tickers.locale,
    tickers.primary_exchange,
    tickers.type,
    splits.split_count,
    splits.adjustment_type,
    case 
        when tickers.active is True then 'active'
        else 'inactive'
    end as status
    from tickers
    left join splits using (ticker)