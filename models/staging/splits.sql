{{
    config(
        materialized='incremental',
        unique_key=['ticker', 'execution_date', 'adjustment_type', 'split_to'],
        on_schema_change='append_new_columns'
    )
}}


with split_data as (
    select
        ticker,
        execution_date, 
        split_from,
        split_to,
        adjustment_type, 
        try_cast(round(try_cast(historical_adjustment_factor as double), 3) as string) as historical_adjustment_factor

    from {{ source('stocks_data', 'splits') }}

    where ticker like 'A%'

)

select * from split_data