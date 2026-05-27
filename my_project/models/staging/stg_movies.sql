{{ config(materialized='view') }}

SELECT
    movieid                                                     AS movie_id,
    title,
    genres,
    TRY_CAST(
        REGEXP_SUBSTR(title, '\\((\\d{4})\\)', 1, 1, 'e', 1)
        AS INT
    )                                                           AS release_year
FROM {{ source('raw', 'tbl_movies') }}