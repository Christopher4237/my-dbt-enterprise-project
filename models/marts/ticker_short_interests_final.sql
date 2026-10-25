with short_interests_date_info as (
    select * from {{ ref('short_interests_date_info') }}
)

select 
    ticker,
    short_interest,
    avg_daily_volume,
    case 
        when avg_daily_volume = 0 then null
        when avg_daily_volume != 0 and 
        round( 
            try_cast(short_interest as bigint) / try_cast(avg_daily_volume as bigint),
        2)
             is not null 
        then round( 
            try_cast(short_interest as bigint) / try_cast(avg_daily_volume as bigint),
        2)
        else 0 
        end as days_to_cover_fixed,
    settlement_date,
    first_settlement_date,
    last_settlement_date,
    date_diff(day, lag(settlement_date) over (partition by ticker order by settlement_date), settlement_date) as days_since_last_cadence
    --,
    --sum(case when avg_daily_volume != 0 then short_interest else 0 end) over (partition by ticker order by settlement_date) 
    --as sum_short_interest,
    --sum(case when avg_daily_volume != 0 then avg_daily_volume else 0 end) over (partition by ticker order by settlement_date) 
    --as sum_avg_daily_volume



    from short_interests_date_info