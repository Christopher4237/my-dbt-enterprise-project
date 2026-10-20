{% macro macro_to_check_date_field_format(table=None) %}
    {% set raw = obtain_date_fields(table=table) %}
    {% set items = raw.split(',') | map('trim') | list %}
    select * from (
    select 
    {% for item in items %}
        {{ item }},
        case when {{ item }} RLIKE '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' or {{ item }} is null
            then 'VALID'
            else 'INVALID'
        end as {{ item }}_valid_check
        {% if not loop.last %},{% endif %}
    {% endfor %}
    from {{ table }}
    ) a
    where

    {% for item in items %}
        {{ item }}_valid_check = 'INVALID'
        {% if not loop.last %} or {% endif %}
    {% endfor %}
{% endmacro %}

