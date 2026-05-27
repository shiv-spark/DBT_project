{% snapshot genre_popularity_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='genre',
        strategy='check',
        check_cols=['total_ratings', 'avg_rating', 'popularity_rank']
    )
}}

SELECT
    genre,
    total_movies,
    total_ratings,
    avg_rating,
    popularity_rank
FROM {{ ref('genre_popularity') }}

{% endsnapshot %}