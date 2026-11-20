{% macro macro_to_check_no_null_strings(schema=None) %}
    select * from (
    {% set raw = obtain_all_fields_in_schema(schema=schema) %}
    {% set items = raw.split(',') | map('trim') | list %}
    {#% set table = items[0].split('.')[0] %#}
    {#% set column = items[0].split('.')[1] %#}
    {% set ns = namespace(
        table=items[0].split('.')[0],
        column=items[0].split('.')[1]
    ) %}

    select count(*) as abc
    from {{ target.database }}.{{ schema }}.{{ ns.table }} where




    {%- for item in items -%}
        {%- set ns.column = item.split('.')[1] -%}
        {%- if not loop.last -%}
            {% if item.split('.')[0] != ns.table %}
                {% set ns.table = item.split('.')[0] %}
                union all
                select count(*) 
                from {{ target.database }}.{{ schema }}.{{ ns.table }} where 
                {{ ns.column }} = 'null' or
            
            {% elif loop.nextitem.split('.')[0] != ns.table %}
                {{ ns.column }} = 'null'

            {% else %}
                {{ ns.column }}  = 'null' or

            {%- endif -%}
        {% else %}
            {{ ns.column }} = 'null'

        {% endif %}
        
    {% endfor %}
    ) a where abc != 0
{% endmacro %}