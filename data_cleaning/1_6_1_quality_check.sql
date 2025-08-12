-- Cleaning Step: K-L
-- Input Table Name: 1_5_3_outliers_speed_removed
-- Input Table Revision: K
-- Output Table Name: 1_6_1_quality_check
-- Output Table Revision: L

============================================================

-- 1. Investigating stations with at least 20 trips and avg trip durations of at least 40 minutes
SELECT
  start_location,
  ROUND(avg(trip_duration)/60) AS avg_trip_duration,
  COUNT(*) AS no_of_trips
FROM
  `sacred-atom-456611-t6.cyclistic_trips.1_5_3_outliers_speed_removed`
GROUP BY
  start_location
HAVING
  avg_trip_duration > 39 AND
  no_of_trips >= 20
ORDER BY 
  no_of_trips DESC

-----------------------------------------------------------

-- 2. Investigating trips from start locations with 'science' in their name
SELECT
  start_location,
  ROUND(avg(trip_duration)/60) AS avg_trip_duration,
  COUNT(*) AS no_of_trips
FROM
  `sacred-atom-456611-t6.cyclistic_trips.1_5_3_outliers_speed_removed`
GROUP BY
  start_location
HAVING
  REGEXP_CONTAINS(LOWER(start_location), r'\bscience\b')
ORDER BY 
  no_of_trips DESC

-------------------------------------------------------------

-- 3. Creating consistent name for 'Griffin Museum'
CREATE TABLE IF NOT EXISTS
  `sacred-atom-456611-t6.cyclistic_trips.1_6_1_quality_check` AS
(SELECT
  * EXCEPT(start_location, end_location),
  CASE WHEN
  start_location = 'Museum of Science and Industry' THEN 'Griffin Museum of Science and Industry'
  ELSE start_location
  END AS start_location,
  CASE WHEN
  end_location = 'Museum of Science and Industry' THEN 'Griffin Museum of Science and Industry'
  ELSE end_location
  END AS end_location
  FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_5_3_speed_outliers_removed`)
