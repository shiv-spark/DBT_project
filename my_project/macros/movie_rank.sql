{% macro movie_rank(order_by_col, partition_by_col=None) %}
    {% if partition_by_col %}
        RANK() OVER (PARTITION BY {{ partition_by_col }} ORDER BY {{ order_by_col }} DESC)
    {% else %}
        RANK() OVER (ORDER BY {{ order_by_col }} DESC)
    {% endif %}
{% endmacro %}