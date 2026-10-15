{{
    config(
        materialized='table',
        warn_if="> 0",
        error_if="= (" ~ count_of_records("stocks_data", "staging", "dividends") ~ ")"
    )
}}

select 
    count(*)
    from {{ source('stocks_data', 'dividends') }}
    where declaration_date is not null