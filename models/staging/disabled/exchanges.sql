{{
    config(
        enabled=false
    )
}}

select 
    id as exhange_id,
    type,
    asset_class,
    locale,
    name,
    acronym, 
    mic,
    operating_mic
from {{ source('stocks_data', 'exchanges') }}

