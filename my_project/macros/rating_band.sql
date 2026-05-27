{% macro rating_band(rating_column) %}
    CASE
        WHEN {{ rating_column }} >= 4.5 THEN 'Excellent'
        WHEN {{ rating_column }} >= 3.5 THEN 'Good'
        WHEN {{ rating_column }} >= 2.5 THEN 'Average'
        WHEN {{ rating_column }} >= 1.5 THEN 'Poor'
        WHEN {{ rating_column }} > 0   THEN 'Very Poor'
        ELSE 'Not Rated'
    END
{% endmacro %}