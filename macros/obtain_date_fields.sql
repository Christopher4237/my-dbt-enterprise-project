{% macro obtain_date_fields(database=target.database, schema=target.schema, table=None) %}
    {% if execute %}
        {% set sql %}
            select 
                column_name
            from {{ database }}.information_schema.columns
            where table_schema = '{{ schema }}'
            and table_name = '{{ table }}'
            and (column_name like '%_date%' or column_name like '%date_%')
        {% endset %}


        {% set result=run_query(sql) %}
        {% if result %}
            {% set rows = result.columns[0].values() %}
            {% for item in rows %}
                {% if loop.last %}
                    {{ item }}
                {% else %}
                    {{ item }},
                {% endif %}
            {% endfor %}
        {% endif %}
    {% endif %}
{% endmacro %}