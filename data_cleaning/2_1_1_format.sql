-- Cleaning Step: L-M
-- Input Table Name: 1_6_1_quality_check
-- Input Table Revision: L
-- Output Table Name: 2_1_1_format
-- Output Table Revision: M

============================================================

CREATE TABLE IF NOT EXISTS 
`sacred-atom-456611-t6.cyclistic_trips.2_1_1_format` AS 
(SELECT
  ride_id,
  DATETIME(started_at, 'America/Chicago') AS started_local,
  DATETIME(ended_at, 'America/Chicago') AS ended_local,
  start_location,
  end_location,
  trip_duration AS ride_duration_seconds,
  member_casual AS member_type,
  rideable_type,
  cast_start_lng AS start_lng,
  cast_start_lat AS start_lat,
  cast_end_lng AS end_lng,
  cast_end_lat AS end_lat,
  start_location_id,
  end_location_id
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_6_1_quality_check`)