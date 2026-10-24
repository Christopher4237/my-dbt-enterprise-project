with tickers as (
    select * from {{ ref('tickers') }}
),

dividends_date_info as (
    select * from {{ ref('dividends_date_info') }}
),

dividend_date_summary as (
    select 
        ticker,

        round(min(days_to_pay_dividend_after_cutoff), 2) as min_days_to_pay_dividend_after_cutoff,
        round(avg(days_to_pay_dividend_after_cutoff), 2) as avg_days_to_pay_dividend_after_cutoff,
        round(max(days_to_pay_dividend_after_cutoff), 2) as max_days_to_pay_dividend_after_cutoff,

        round(min(days_to_pay_dividend_after_eligibility_identification), 2) as min_days_to_pay_dividend_after_eligibility_identification,
        round(avg(days_to_pay_dividend_after_eligibility_identification), 2) as avg_days_to_pay_dividend_after_eligibility_identification,
        round(max(days_to_pay_dividend_after_eligibility_identification), 2) as max_days_to_pay_dividend_after_eligibility_identification,

        round(min(days_since_last_dividend_paid), 2) as min_days_since_last_dividend_paid,
        round(avg(days_since_last_dividend_paid), 2) as avg_days_since_last_dividend_paid,
        round(max(days_since_last_dividend_paid), 2) as max_days_since_last_dividend_paid,

        round(min(cash_amount), 2) as min_cash_amount,
        round(avg(cash_amount), 2) as avg_cash_amount,
        round(max(cash_amount), 2) as max_cash_amount

        from dividends_date_info

        where

        days_since_last_dividend_paid is not null

        group by ticker

),

dividend_date_start as (

select distinct
    ticker, 

    first(record_date) over (partition by ticker order by record_date asc) as first_record_date,

    first(pay_date) over (partition by ticker order by pay_date asc) as first_pay_date,

    first(ex_dividend_date) over (partition by ticker order by ex_dividend_date asc) as first_ex_dividend_date

    from dividends_date_info

),

dividend_date_finish as (

select distinct
    ticker, 

    last(record_date) over (partition by ticker order by record_date asc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_record_date ,

    last(pay_date) over (partition by ticker order by pay_date asc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_pay_date,

    last(ex_dividend_date) over (partition by ticker order by ex_dividend_date asc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_ex_dividend_date

    from dividends_date_info

) 


select 
    tickers.ticker,

    dividend_date_summary.min_days_to_pay_dividend_after_cutoff,
    dividend_date_summary.avg_days_to_pay_dividend_after_cutoff,
    dividend_date_summary.max_days_to_pay_dividend_after_cutoff,

    dividend_date_summary.min_days_to_pay_dividend_after_eligibility_identification,
    dividend_date_summary.avg_days_to_pay_dividend_after_eligibility_identification,
    dividend_date_summary.max_days_to_pay_dividend_after_eligibility_identification,

    dividend_date_summary.min_days_since_last_dividend_paid,
    dividend_date_summary.avg_days_since_last_dividend_paid,
    dividend_date_summary.max_days_since_last_dividend_paid,

    dividend_date_start.first_record_date,
    dividend_date_finish.last_record_date,

    dividend_date_start.first_pay_date,
    dividend_date_finish.last_pay_date,

    dividend_date_start.first_ex_dividend_date,
    dividend_date_finish.last_ex_dividend_date


    from tickers
    
    left join dividend_date_summary using (ticker)

    left join dividend_date_start using (ticker)

    left join dividend_date_finish using (ticker)