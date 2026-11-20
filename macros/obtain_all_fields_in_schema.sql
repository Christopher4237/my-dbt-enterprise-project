{% macro obtain_all_fields_in_schema(database=target.database, schema=None) %}
    {% if execute %}
        {% set sql %}
            select 
                concat(table_name, '.', column_name)
            from {{ database }}.information_schema.columns
            where table_schema = '{{ schema }}'
            order by concat(table_name, '.', column_name)
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