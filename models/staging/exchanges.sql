{{
    config(
        materialized='incremental',
        unique_key='exchange_id'
    )
}}


with exchanges as (
    select * from {{ source('stocks_data', 'exchanges') }}
)

select 
    id as exchange_id,
    type,
    asset_class,
    locale,
    name,
    acronym, 
    mic,
    operating_mic
from exchanges

