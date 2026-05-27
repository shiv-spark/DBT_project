{% macro drop_schema(schema) %}
    {% set drop_query %}
        DROP SCHEMA IF EXISTS {{ target.database }}.{{ schema }} CASCADE
    {% endset %}
    {% do run_query(drop_query) %}
    {{ log("Dropped schema: " ~ schema, info=True) }}
{% endmacro %}