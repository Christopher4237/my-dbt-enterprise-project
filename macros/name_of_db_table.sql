{% macro count_of_records(database=target.database, schema=target.schema, table=None) %}
    select count(*) from {{ database }}.{{ schema }}.{{ table }}
{% endmacro %}