{{
    config(
        materialized = 'table'
    )
}}

SELECT
   refresh_date AS Day,
   term AS Top_Term,
   dma_name AS State,
       -- These search terms are in the top 25 in the US each day.
   rank,
FROM `bigquery-public-data.google_trends.top_terms`
WHERE
   rank = 1
       -- Choose only the top term each day.
   AND refresh_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 12 WEEK)
       -- Filter to the last 12 weeks.
GROUP BY Day, Top_Term, State, rank
ORDER BY Day DESC
   -- Show the days in reverse chronological order.