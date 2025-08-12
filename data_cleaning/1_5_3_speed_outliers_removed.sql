-- Cleaning Step: J-K
-- Input Table Name: 1_5_2_outliers_upr_removed
-- Input Table Revision: J
-- Output Table Name: 1_5_3_speed_outliers_removed
-- Output Table Revision: K

============================================================

-- Removal of outliers with 'unrealistic' avg speeds
CREATE TABLE IF NOT EXISTS 
  `sacred-atom-456611-t6.cyclistic_trips.1_5_3_speed_outliers_removed` AS
(SELECT
  *
FROM
  `sacred-atom-456611-t6.cyclistic_trips.1_5_2_outliers_upr_removed`
WHERE ride_id NOT IN
(SELECT 
  ride_id
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_5_2_outliers_upr_removed`
WHERE
  ST_DISTANCE(ST_GEOGPOINT(cast_start_lng, cast_start_lat), ST_GEOGPOINT(cast_end_lng, cast_end_lat))/(1000*(trip_duration/3600)) > 35)) -- removes rides exceeding 35 km/h