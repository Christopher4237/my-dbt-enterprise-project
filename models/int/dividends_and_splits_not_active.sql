with dividends as (
    select * from {{ ref('dividends') }}
),

splits as (
    select * from {{ ref('splits') }}
),

tickers as (
    select * from {{ ref('tickers') }}
)

select distinct
    dividends.ticker,
    'dividend tickers not in splits or tickers' as missing_status
from dividends
left join splits
on dividends.ticker = splits.ticker
left join tickers
on dividends.ticker = tickers.ticker
where splits.ticker is null 
and tickers.ticker is null 

union

select distinct
    splits.ticker,
    'split tickers not in dividends or tickers' as missing_status
from splits
left join dividends
on splits.ticker = dividends.ticker
left join tickers
on splits.ticker = tickers.ticker
where dividends.ticker is null 
and tickers.ticker is null 

union

select distinct
    splits.ticker,
    'dividends and split tickers not in tickers' as missing_status
from splits
left join dividends
on splits.ticker = dividends.ticker
left join tickers
on splits.ticker = tickers.ticker
where dividends.ticker is not null 
and tickers.ticker is null 