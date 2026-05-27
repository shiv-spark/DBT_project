{{ config(materialized='table') }}

SELECT
    m.movie_id,
    m.title,
    m.genres,
    LISTAGG(DISTINCT t.tag, ', ')
        WITHIN GROUP (ORDER BY t.tag)   AS all_tags,
    COUNT(DISTINCT t.user_id)           AS tagged_by_users
FROM {{ ref('stg_movies') }} m
LEFT JOIN {{ ref('stg_tags') }} t
    ON m.movie_id = t.movie_id
GROUP BY 1, 2, 3