-- Cleaning Step: B-C
-- Input Table Name: 1_1_1_duplicates_removed
-- Input Table Revision: B
-- Output Table Name: 1_2_1_nulls_lat_lng_removed
-- Output Table Revision: C

============================================================

-- 1. Percentage of nulls in each column
SELECT
(SELECT
  count(*)
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_1_1_duplicates_removed`
WHERE ride_id IS NULL)/COUNT(*)*100 AS ride_id_percent_null,
(SELECT
  count(*)
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_1_1_duplicates_removed`
WHERE rideable_type IS NULL)/COUNT(*)*100 AS rideable_type_percent_null,
(SELECT
  count(*)
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_1_1_duplicates_removed`
WHERE started_at IS NULL)/COUNT(*)*100 AS started_at_percent_null,
(SELECT
  count(*)
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_1_1_duplicates_removed`
WHERE ended_at IS NULL)/COUNT(*)*100 AS ended_at_percent_null,
(SELECT
  count(*)
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_1_1_duplicates_removed`
WHERE start_station_name IS NULL)/COUNT(*)*100 AS start_station_name_percent_null,
(SELECT
  count(*)
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_1_1_duplicates_removed`
WHERE start_station_id IS NULL)/COUNT(*)*100 AS start_station_id_percent_null,
(SELECT
  count(*)
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_1_1_duplicates_removed`
WHERE end_station_name IS NULL)/COUNT(*)*100 AS end_station_name,
(SELECT
  count(*)
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_1_1_duplicates_removed`
WHERE end_station_id IS NULL)/COUNT(*)*100 AS end_station_id_percent_null,
(SELECT
  count(*)
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_1_1_duplicates_removed`
WHERE ended_at IS NULL)/COUNT(*)*100 AS ended_at_percent_null,
(SELECT
  count(*)
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_1_1_duplicates_removed`
WHERE start_lat IS NULL)/COUNT(*)*100 AS start_station_id_percent_null,
(SELECT
  count(*)
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_1_1_duplicates_removed`
WHERE start_lng IS NULL)/COUNT(*)*100 AS start_lng_percent_null,
(SELECT
  count(*)
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_1_1_duplicates_removed`
WHERE end_lat IS NULL)/COUNT(*)*100 AS end_lat_percent_null,
(SELECT
  count(*)
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_1_1_duplicates_removed`
WHERE end_lng IS NULL)/COUNT(*)*100 AS end_lng_percent_null,
(SELECT
  count(*)
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_1_1_duplicates_removed`
WHERE member_casual IS NULL)/COUNT(*)*100 AS member_casual_percent_null
FROM
  `sacred-atom-456611-t6.cyclistic_trips.1_1_1_duplicates_removed`

---------------------------------------------------------------------------

-- 2. Is there a link between nulls in end_lat and end_lng columns, and ride duration
SELECT
  COUNT(*) number_of_rides,
  TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS ride_duration
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_1_1_duplicates_removed`
WHERE
  end_lat IS NULL OR
  end_lng IS NULL
GROUP BY ride_duration
ORDER BY ride_duration DESC

-------------------------------------------------------------------------

-- 3. Removing end_lat and end_lng nulls and creating backup table
CREATE TABLE IF NOT EXISTS 
  `sacred-atom-456611-t6.cyclistic_trips.1_2_1_nulls_lat_lng_removed` AS
SELECT
  *
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_1_1_duplicates_removed`
WHERE
  end_lat IS NOT NULL AND
  end_lng IS NOT NULL
