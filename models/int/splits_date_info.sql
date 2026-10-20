with splits as (
    select * from {{ ref('splits') }}
)

select 
    ticker, 
    execution_date,
    date_diff(day, lag(execution_date) over (partition by ticker order by execution_date), execution_date) as days_since_last_split,
    adjustment_type as type_of_split,
    historical_adjustment_factor,
    split_from,
    split_to,
    case 
        when try_cast(split_from as decimal(25,10)) is null then 0
        when try_cast(split_to as decimal(25,10)) is null then 0
        when try_cast(historical_adjustment_factor as decimal(25,10)) is null then 0
        when round( try_cast(split_from as decimal(25,10)) / try_cast(split_to as decimal(25,10)) , 3) 
        = round( try_cast(historical_adjustment_factor as decimal(25,10)) , 3) then 1
        else 0 
    end as historical_adjustment_factor_makes_sense 

    from splits
