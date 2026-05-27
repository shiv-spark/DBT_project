{{ config(materialized='view') }}

SELECT
    userid                              AS user_id,
    movieid                             AS movie_id,
    rating,
    {{ ts_to_date('timestamp') }}       AS rated_at
FROM {{ source('raw', 'tbl_ratings') }}