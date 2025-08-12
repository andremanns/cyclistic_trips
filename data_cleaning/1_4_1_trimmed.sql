-- Cleaning Step: E-F
-- Input Table Name: 1_3_1_filtered
-- Input Table Revision: E
-- Output Table Name: 1_4_1_trimmed
-- Output Table Revision: F

============================================================

-- 1. Typos in 'rideable_type' column
SELECT
  DISTINCT rideable_type,
FROM 
`sacred-atom-456611-t6.cyclistic_trips.1_3_1_filtered`

------------------------------------------------------------

-- 2. Typos in 'member_casual' column
SELECT
  DISTINCT member_casual
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_3_1_filtered`

------------------------------------------------------------

    -- 3. Trimming Data. Backup table created.
  CREATE TABLE IF NOT EXISTS
`sacred-atom-456611-t6.cyclistic_trips.1_4_1_trimmed` AS
SELECT
  TRIM(ride_id) AS ride_id,
  TRIM(rideable_type) AS rideable_type,
  TRIM(member_casual) AS member_casual,
  TRIM(start_location) AS start_location,
  TRIM(end_location) AS end_location,
  TRIM(end_location_id) AS end_location_id,
  TRIM(start_location_id) AS start_location_id,
  started_at,
  ended_at,
  cast_start_lng, 
  cast_start_lat,
  cast_end_lng,
  cast_end_lat
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_3_1_filtered`