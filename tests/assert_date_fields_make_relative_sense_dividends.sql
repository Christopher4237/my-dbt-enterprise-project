{{
    config(
        materialized='table',
        warn_if = "> 0",
        error_if = "= (" ~ count_of_records("stocks_data", "int", "dividends_date_info") ~ ")"
    )
}}

select 
    ticker,
    record_date,
    pay_date,
    ex_dividend_date,
    declaration_date,
    days_to_pay_dividend_after_cutoff,
    days_to_pay_dividend_after_eligibility_identification,
    days_since_last_dividend_paid

from {{ ref('dividends_date_info') }}

where

    days_to_pay_dividend_after_cutoff < 0 or
    days_to_pay_dividend_after_eligibility_identification < 0 or 
    days_since_last_dividend_paid < 0