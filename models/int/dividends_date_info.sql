with dividends as (
    select * from {{ ref('dividends') }}
)

SELECT
    ticker,
    record_date,
    pay_date,
    ex_dividend_date,
    declaration_date,

    CAST(
        date_diff(
            day,
            try_cast(nullif(ex_dividend_date, 'null') AS DATE),
            try_cast(nullif(pay_date, 'null') AS DATE)
        ) AS STRING
    ) AS days_to_pay_dividend_after_cutoff,

    CAST(
        date_diff(
            day,
            try_cast(nullif(record_date, 'null') AS DATE),
            try_cast(nullif(pay_date, 'null') AS DATE)
        ) AS STRING
    ) AS days_to_pay_dividend_after_eligibility_identification,

    CAST(
        date_diff(
            day,
            try_cast(nullif(
                lag(pay_date) OVER (
                    PARTITION BY ticker
                    ORDER BY pay_date
                ), 'null'
            ) AS DATE),
            try_cast(nullif(pay_date, 'null') AS DATE)
        ) AS STRING
    ) AS days_since_last_dividend_paid,

    cash_amount

FROM stocks_data.staging.dividends;
