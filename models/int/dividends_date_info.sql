with dividends as (
    select * from {{ ref('dividends') }}
)

select 
    ticker,
    record_date, 
    pay_date, 
    ex_dividend_date,
    declaration_date,
    date_diff(day, ex_dividend_date, pay_date) as days_to_pay_dividend_after_cutoff,
    date_diff(day, record_date, pay_date) as days_to_pay_dividend_after_eligibility_identification,
    date_diff(day, lag(pay_date) over (partition by ticker order by pay_date), pay_date) as days_since_last_dividend_paid,
    cash_amount

    from dividends
