{{ config(materialized='table') }}

SELECT
    FLOOR(m.release_year / 10) * 10             AS decade,
    COUNT(DISTINCT m.movie_id)                  AS total_movies,
    COUNT(r.user_id)                            AS total_ratings,
    ROUND(AVG(r.rating), 2)                     AS avg_rating,
    MAX(mrs.avg_rating)                         AS best_rated_movie_score,
    MIN(mrs.avg_rating)                         AS worst_rated_movie_score
FROM {{ ref('stg_movies') }} m
LEFT JOIN {{ ref('stg_ratings') }} r
    ON m.movie_id = r.movie_id
LEFT JOIN {{ ref('movie_rating_summary') }} mrs
    ON m.movie_id = mrs.movie_id
WHERE m.release_year IS NOT NULL
GROUP BY 1
ORDER BY 1