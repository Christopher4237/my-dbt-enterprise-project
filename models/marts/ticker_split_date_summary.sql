with splits_date_info as (
    select * from {{ ref('splits_date_info') }}
),

splits_date_info_similar_type as (
    select * from {{ ref('splits_date_info_similar_type') }}
)

select 

    splits_date_info.ticker,
    splits_date_info.execution_date,
    splits_date_info.days_since_last_split,
    splits_date_info_similar_type.days_since_last_similar_type_of_split,
    splits_date_info.type_of_split,
    splits_date_info.split_from,
    splits_date_info.split_to,
    splits_date_info.historical_adjustment_factor_makes_sense,
    splits_date_info.historical_adjustment_factor


from splits_date_info
join splits_date_info_similar_type
on splits_date_info.ticker = splits_date_info_similar_type.ticker
and splits_date_info.execution_date = splits_date_info_similar_type.execution_date
and splits_date_info.type_of_split = splits_date_info_similar_type.type_of_split
and splits_date_info.historical_adjustment_factor = splits_date_info_similar_type.historical_adjustment_factor