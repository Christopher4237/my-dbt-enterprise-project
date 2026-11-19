{{
    config(
        materialized='incremental',
        unique_key='exchange_id',
        incremental_strategy='delete+insert'
    )
}}


with exchanges as (
    select  
        id as exchange_id,
        type,
        asset_class,
        locale,
        name,
        acronym, 
        mic,
        operating_mic
    
    from {{ source('stocks_data', 'exchanges') }}
)

select * from exchanges

