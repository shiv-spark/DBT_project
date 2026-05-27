{% macro ts_to_date(column_name) %}
    TO_TIMESTAMP({{ column_name }})::DATE
{% endmacro %}