with tickers as (
    select * from {{ ref('tickers') }}
),

ticker_types as (
    select * from {{ ref('ticker_types') }}
),

exchanges as (
    select * from {{ ref('exchanges') }}
)


select 
    t.ticker,
    t.name,
    t.market,
    t.locale,
    t.primary_exchange,
    e.name as exchange_name,
    e.type as exchange_type,
    e.acronym as exchange_acronym,
    e.operating_mic as exchange_operating_mic,
    t.type,
    tt.description,
    t.active,
    t.currency_name,
    t.last_updated_utc_date

from tickers t
left join ticker_types tt
on t.type = tt.code
left join exchanges e
on t.primary_exchange = e.mic

