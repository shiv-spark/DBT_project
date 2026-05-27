<!-- End-to-end data engineering pipeline using Snowflake and dbt, including S3-based ingestion via storage integration and external stages, layered transformations (staging, marts), reusable macros, snapshot-based historical tracking, and automated data lineage documentation using dbt docs for BI consumption.      -->
     
     
     
                ┌────────────────────────────────────┐
                │          DATA SOURCES             │
                │------------------------------------│
                │  • S3 (Large files)               │
                │  • Local CSV (Small files)        │
                └──────────────┬─────────────────────┘
                               │
                               ▼
        ┌────────────────────────────────────────────┐
        │     SNOWFLAKE INGESTION LAYER             │
        │--------------------------------------------│
        │  1. Storage Integration (S3 ↔ Snowflake)  │
        │  2. External Stage (S3 bucket mapping)     │
        │  3. Manual Upload (small CSV files)       │
        │  4. Tables created from loaded data       │
        └──────────────┬────────────────────────────┘
                       │
                       ▼
        ┌────────────────────────────────────────────┐
        │        RAW TABLE LAYER (Snowflake)        │
        │  tbl_movies                               │
        │  tbl_ratings                              │
        │  tbl_tags                                 │
        │  tbl_links                                │
        └──────────────┬────────────────────────────┘
                       │
                       ▼
        ┌────────────────────────────────────────────┐
        │        DBT STAGING LAYER                  │
        │  stg_movies                               │
        │  stg_ratings                              │
        │  stg_tags                                 │
        │  stg_links                                │
        └──────────────┬────────────────────────────┘
                       │
                       ▼
        ┌────────────────────────────────────────────┐
        │          DBT MACROS LAYER                 │
        │  clean_genre()                            │
        │  rating_band()                            │
        │  ts_to_date()                             │
        │  movie_rank()                             │
        └──────────────┬────────────────────────────┘
                       │
                       ▼
        ┌────────────────────────────────────────────┐
        │          DBT MARTS LAYER                  │
        │  movie_rating_summary                     │
        │  genre_popularity                         │
        │  user_activity_summary                    │
        │  top_rated_movies                         │
        │  movie_with_tags                          │
        └──────────────┬────────────────────────────┘
                       │
                       ▼
        ┌────────────────────────────────────────────┐
        │        CONSUMPTION LAYER                  │
        │  MicroStrategy Dashboards                │
        │  BI Reports / KPIs                        │
        └────────────────────────────────────────────┘

                       ▲
                       │
        ┌────────────────────────────────────────────┐
        │         SNAPSHOTS LAYER                   │
        │  historical tracking (SCD type 2)         │
        └────────────────────────────────────────────┘

                       │
                       ▼
        ┌────────────────────────────────────────────┐
        │           DBT DOCS LAYER                  │
        │  Lineage Graph                           │
        │  Metadata Catalog                        │
        │  Tests + Documentation                   │
        └────────────────────────────────────────────┘