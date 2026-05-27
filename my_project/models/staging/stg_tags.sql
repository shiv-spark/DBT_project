{{ config(materialized='view') }}

SELECT
    userid                              AS user_id,
    movieid                             AS movie_id,
    {{ clean_genre('tag') }}            AS tag,
    {{ ts_to_date('timestamp') }}       AS tagged_at
FROM {{ source('raw', 'tbl_tags') }}