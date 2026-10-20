with tickers as (
    select * from {{ ref('tickers') }}
),

ticker_dividends as (
    select * from {{ ref('ticker_dividends_by_currency') }}
),

ticker_splits as (
    select * from {{ ref('ticker_splits') }}
),

dividend_count as (
    select 
        ticker,
        nvl(sum(dividend_count), 0) as count_dividends
    from ticker_dividends
    group by ticker
),

split_count as (
    select 
        ticker,
        nvl(sum(split_count), 0) as count_splits
    from ticker_splits
    group by ticker
)

select 
    tickers.ticker,
    tickers.name,
    tickers.market,
    tickers.locale,
    tickers.primary_exchange,
    tickers.type,
    dividend_count.count_dividends,
    split_count.count_splits

    from tickers

    left join dividend_count using (ticker)

    left join split_count using (ticker)