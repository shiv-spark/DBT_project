{{ config(materialized='table') }}

SELECT
    m.movie_id,
    m.title,
    m.genres,
    m.release_year,
    mrs.total_ratings,
    mrs.avg_rating,
    RANK() OVER (ORDER BY mrs.avg_rating DESC, mrs.total_ratings DESC)  AS overall_rank,
    RANK() OVER (ORDER BY mrs.total_ratings DESC)                        AS popularity_rank
FROM {{ ref('stg_movies') }} m
INNER JOIN {{ ref('movie_rating_summary') }} mrs
    ON m.movie_id = mrs.movie_id
WHERE mrs.total_ratings >= 50        -- only movies with enough ratings
ORDER BY overall_rank