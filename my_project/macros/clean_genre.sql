{% macro clean_genre(column_name) %}
    TRIM(UPPER({{ column_name }}))
{% endmacro %}