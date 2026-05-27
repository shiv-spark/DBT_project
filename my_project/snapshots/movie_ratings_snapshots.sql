{% snapshot movie_ratings_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='movie_id',
        strategy='check',
        check_cols=['avg_rating', 'total_ratings', 'max_rating', 'min_rating']
    )
}}

SELECT
    movie_id,
    title,
    genres,
    release_year,
    total_ratings,
    avg_rating,
    max_rating,
    min_rating
FROM {{ ref('movie_rating_summary') }}

{% endsnapshot %}