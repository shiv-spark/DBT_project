{{ config(materialized='table') }}

SELECT
    r.user_id,
    COUNT(r.movie_id)                           AS total_movies_rated,
    ROUND(AVG(r.rating), 2)                     AS avg_rating_given,
    MAX(r.rating)                               AS highest_rating_given,
    MIN(r.rating)                               AS lowest_rating_given,
    COUNT(DISTINCT t.movie_id)                  AS total_movies_tagged,
    MIN(r.rated_at)                             AS first_rating_date,
    MAX(r.rated_at)                             AS last_rating_date,
    DATEDIFF('day', MIN(r.rated_at),
             MAX(r.rated_at))                   AS days_active
FROM {{ ref('stg_ratings') }} r
LEFT JOIN {{ ref('stg_tags') }} t
    ON r.user_id = t.user_id
GROUP BY 1