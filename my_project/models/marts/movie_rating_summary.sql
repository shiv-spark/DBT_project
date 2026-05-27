{{ config(materialized='table') }}

SELECT
    m.movie_id,
    m.title,
    m.genres,
    m.release_year,
    COUNT(r.user_id)                        AS total_ratings,
    ROUND(COALESCE(AVG(r.rating), 0), 2)    AS avg_rating,
    COALESCE(MAX(r.rating), 0)              AS max_rating,
    COALESCE(MIN(r.rating), 0)              AS min_rating,
    {{ rating_band('COALESCE(AVG(r.rating), 0)') }}  AS rating_band,
    {{ movie_rank('AVG(r.rating)') }}                AS overall_rank
FROM {{ ref('stg_movies') }} m
LEFT JOIN {{ ref('stg_ratings') }} r
    ON m.movie_id = r.movie_id
GROUP BY 1, 2, 3, 4