-- Cleaning Step: D-E
-- Input Table Name: 1_2_2_nulls_name_id_removed
-- Input Table Revision: D
-- Output Table Name: 1_3_1_filtered
-- Output Table Revision: E

============================================================

-- Filtering data to comply with project constraints and creating backup table
CREATE TABLE IF NOT EXISTS
`sacred-atom-456611-t6.cyclistic_trips.1_3_1_filtered` AS

WITH coordinates AS 
(
  SELECT
    *EXCEPT(start_lng, start_lat, end_lng, end_lat),
    CAST(start_lng AS FLOAT64) AS cast_start_lng,
    CAST(start_lat AS FLOAT64) AS cast_start_lat,
    CAST(end_lng AS FLOAT64) AS cast_end_lng,
    CAST(end_lat AS FLOAT64) AS cast_end_lat
FROM
  `sacred-atom-456611-t6.cyclistic_trips.1_2_2_nulls_name_id_removed`
),

city_boundaries AS (
SELECT
  name,
  ST_BUFFER(ST_SIMPLIFY(urban_area_geom,300),1000) AS chicago_polygon -- 300 tolerance to improve processing speed
FROM
  `bigquery-public-data.geo_us_boundaries.urban_areas`
WHERE
  SUBSTR(name,1,7) = 'Chicago'
)

SELECT
  coordinates.*
FROM
  city_boundaries
INNER JOIN
  coordinates
ON ST_CONTAINS(city_boundaries.chicago_polygon, ST_GEOGPOINT(coordinates.cast_start_lng, coordinates.cast_start_lat)) AND ST_CONTAINS(city_boundaries.chicago_polygon, ST_GEOGPOINT(coordinates.cast_end_lng, coordinates.cast_end_lat))
WHERE
  rideable_type <> 'electric_scooter' AND
  DATE(started_at, 'America/Chicago') BETWEEN '2024-05-01' AND '2025-04-30' AND
  DATE(ended_at, 'America/Chicago') BETWEEN '2024-05-01' AND '2025-04-30'
