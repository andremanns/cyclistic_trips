-- Cleaning Step: H-I
-- Input Table Name: 1_4_3_typos_sp_characters_removed
-- Input Table Revision: H
-- Output Table Name: 1_5_1_outliers_lwr_removed
-- Output Table Revision: I

============================================================

-- 1. Determine if outliers exist
SELECT
  max(timestamp_diff(ended_at, started_at, second)) AS max_duration_seconds,
  max(timestamp_diff(ended_at, started_at, second)/3600) AS max_duration_hrs,
  min(timestamp_diff(ended_at, started_at, second)) AS min_duration_seconds,
  min(timestamp_diff(ended_at, started_at, second)/3600) AS min_duration_hrs,
FROM
  `sacred-atom-456611-t6.cyclistic_trips.1_4_3_typos_sp_characters_removed`

----------------------------------------------------------------------------

-- 2. Investigating ride durations less than or equal to 0 seconds
SELECT
  timestamp_diff(ended_at, started_at, second) AS duration_seconds,
  timestamp_diff(ended_at, started_at, second)/3600 AS duration_hrs,
  *
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_4_3_typos_sp_characters_removed`
WHERE 
  timestamp_diff(ended_at, started_at, second) <= 0
ORDER BY duration_seconds

---------------------------------------------------------------------------

-- 3. When do negative duration rides occur?
SELECT
  DATE(started_at) AS start_date,
  COUNT(*) AS no_of_errors
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_4_3_typos_sp_characters_removed`
WHERE 
  timestamp_diff(ended_at, started_at, second) <= 0
GROUP BY start_date
ORDER BY no_of_errors DESC

--------------------------------------------------------------------------

-- 4. Removal of negative duration rides and rides logged due to incorrect coupling
CREATE TABLE IF NOT EXISTS
  `sacred-atom-456611-t6.cyclistic_trips.1_5_1_outliers_lwr_removed` AS
(SELECT
  *,
  ROUND(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000) AS trip_duration
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_4_3_typos_sp_characters_removed`
WHERE NOT
  TIMESTAMP_DIFF(ended_at, started_at, second) < 30)