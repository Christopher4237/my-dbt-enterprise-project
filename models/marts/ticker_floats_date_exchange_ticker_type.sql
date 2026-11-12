with ticker_data_w_types as (
    select * from {{ ref('ticker_data_w_types') }}
),

floats_int as (
    select * from {{ ref('floats_int') }}
)

select 
    a.ticker,
    a.name,
    a.market,
    a.locale,
    a.primary_exchange,
    a.exchange_name,
    a.exchange_type,
    a.exchange_acronym,
    a.exchange_operating_mic,
    a.type,
    a.description,
    a.active,
    a.currency_name,
    a.last_updated_utc_date,
    b.free_float,
    b.effective_date,
    b.free_float_percent,
    date_diff(day, b.effective_date, current_date()) as days_since_last_float


    from ticker_data_w_types a
    join floats_int b
    on a.ticker = b.ticker
    order by a.ticker