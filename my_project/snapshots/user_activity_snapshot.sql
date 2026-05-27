{% snapshot user_activity_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='user_id',
        strategy='check',
        check_cols=['total_movies_rated', 'avg_rating_given', 'last_rating_date']
    )
}}

SELECT
    user_id,
    total_movies_rated,
    avg_rating_given,
    highest_rating_given,
    lowest_rating_given,
    total_movies_tagged,
    first_rating_date,
    last_rating_date,
    days_active
FROM {{ ref('user_activity_summary') }}

{% endsnapshot %}