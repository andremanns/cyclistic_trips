-- Cleaning Step: F-G
-- Input Table Name: 1_4_1_trimmed
-- Input Table Revision: F
-- Output Table Name: 1_4_2_double_spaces_removed
-- Output Table Revision: G

============================================================

-- 1. Looking for consecutive spaces
SELECT
  *
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_4_1_trimmed`
WHERE
REGEXP_CONTAINS(ride_id, r' {2,}') OR
REGEXP_CONTAINS(rideable_type, r' {2,}') OR
REGEXP_CONTAINS(member_casual, r' {2,}') OR
REGEXP_CONTAINS(start_location, r' {2,}') OR
REGEXP_CONTAINS(end_location, r' {2,}') OR
REGEXP_CONTAINS(start_location_id, r' {2,}') OR
REGEXP_CONTAINS(end_location_id, r' {2,}')

------------------------------------------------------------

-- 2. Replacing consecutive spaces with single space. Backup table created.
CREATE TABLE IF NOT EXISTS
  `sacred-atom-456611-t6.cyclistic_trips.1_4_2_double_spaces_removed` AS
SELECT
  REGEXP_REPLACE(ride_id, r' {2,}', ' ') AS ride_id,
  REGEXP_REPLACE(rideable_type, r' {2,}', ' ') AS rideable_type,
  REGEXP_REPLACE(member_casual, r' {2,}', ' ') AS member_casual,
  REGEXP_REPLACE(start_location, r' {2,}', ' ') AS start_location,
  REGEXP_REPLACE(end_location, r' {2,}', ' ') AS end_location,
  REGEXP_REPLACE(start_location_id, r' {2,}', ' ') AS start_location_id,
  REGEXP_REPLACE(end_location_id, r' {2,}', ' ') AS end_location_id,
  started_at,
  ended_at,
  cast_start_lng,
  cast_start_lat,
  cast_end_lng,
  cast_end_lat
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_4_1_trimmed`
  