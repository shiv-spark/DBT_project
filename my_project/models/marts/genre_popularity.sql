{{ config(materialized='table') }}

WITH genre_exploded AS (
    SELECT
        m.movie_id,
        {{ clean_genre('TRIM(g.value)') }}  AS genre
    FROM {{ ref('stg_movies') }} m,
    LATERAL FLATTEN(INPUT => SPLIT(m.genres, '|')) g
),

genre_ratings AS (
    SELECT
        ge.genre,
        COUNT(r.user_id)                AS total_ratings,
        ROUND(AVG(r.rating), 2)         AS avg_rating,
        COUNT(DISTINCT ge.movie_id)     AS total_movies
    FROM genre_exploded ge
    LEFT JOIN {{ ref('stg_ratings') }} r
        ON ge.movie_id = r.movie_id
    GROUP BY 1
)

SELECT
    genre,
    total_movies,
    total_ratings,
    avg_rating,
    {{ rating_band('avg_rating') }}                     AS rating_band,
    {{ movie_rank('total_ratings') }}                   AS popularity_rank
FROM genre_ratings
ORDER BY popularity_rank