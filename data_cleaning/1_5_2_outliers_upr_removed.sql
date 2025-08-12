-- Cleaning Step: I-J
-- Input Table Name: 1_5_1_outliers_lwr_removed
-- Input Table Revision: I
-- Output Table Name: 1_5_2_outliers_upr_removed
-- Output Table Revision: J

============================================================

-- 1. Date vs ride count anomalies
SELECT
  DATE(started_at, 'America/Chicago') AS date,
  COUNT(*) AS no_of_rides
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_5_1_outliers_lwr_removed`
GROUP BY 
  DATE(started_at, 'America/Chicago')
ORDER BY
  DATE(started_at, 'America/Chicago')

-----------------------------------------------------------

-- 2. Start location vs avg ride duration anomalies
SELECT
  start_location,
  ROUND(avg(trip_duration)/60) AS avg_trip_duration,
  COUNT(*) AS no_of_trips
FROM
  `sacred-atom-456611-t6.cyclistic_trips.1_5_1_outliers_lwr_removed`
GROUP BY
  start_location
ORDER BY 
  no_of_trips DESC

---------------------------------------------------------

-- 3. Ride duration vs Ride Count anomalies
SELECT
  COUNT(*) AS no_of_rides,
  ROUND(timestamp_diff(ended_at, started_at, second)/60) duration_minutes
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_5_1_outliers_lwr_removed`
GROUP BY 
ROUND(timestamp_diff(ended_at, started_at, second)/60)
ORDER BY duration_minutes

---------------------------------------------------------

-- 4. Removal of Upper End Outliers
CREATE TABLE IF NOT EXISTS
  `sacred-atom-456611-t6.cyclistic_trips.1_5_2_outliers_upr_removed` AS (
SELECT 
  *
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_5_1_outliers_lwr_removed`
WHERE NOT
-- a. Removal of 'timed out rides' or defaulted rides lasting at least 3 hours --
(trip_duration > 10799 AND
  (ROUND((trip_duration/3600)-FLOOR(trip_duration/3600),4) < 0.015 OR 
  ROUND((trip_duration/3600)-FLOOR(trip_duration/3600),4) > 0.985)) AND -- ride finsihes within 0.15 of exact hour
ride_id NOT IN
-- b. Removal of rides with abnormal durations, start times and end times. This targets rides affected by incorrect docking --
(SELECT
  ride_id
FROM
  (SELECT
  ride_id,
   CASE WHEN 
  trip_duration <= 27799 AND 
  TIME(started_at, 'America/Chicago') > TIME '05:59:59' AND
  TIME(ended_at, 'America/Chicago') < TIME '00:59:59'AND
  DATE(started_at, 'America/Chicago') <> DATE(ended_at, 'America/Chicago')
  THEN 'ride_valid'
  WHEN trip_duration <= 27799 AND 
  TIME(started_at, 'America/Chicago') > TIME '05:59:59' AND
  TIME(ended_at, 'America/Chicago') < TIME '23:59:59'AND
  DATE(started_at, 'America/Chicago') = DATE(ended_at, 'America/Chicago')
  THEN 'ride_valid'
  WHEN trip_duration > 27799 AND
  TIME(started_at, 'America/Chicago') > TIME '05:59:59' AND
  DATE(started_at, 'America/Chicago') = DATE(ended_at, 'America/Chicago')
  THEN 'ride_valid'
  ELSE 'incorrect_docking'
  END AS ride_filtering
  FROM
  `sacred-atom-456611-t6.cyclistic_trips.1_5_1_outliers_lwr_removed`
  WHERE
    trip_duration > 21599)
WHERE
  ride_filtering = 'incorrect_docking') AND
ride_id NOT IN 
-- c. Removal of overnight rides at least 3 hours long grouped by start location and start date. This is to remove rides affected by station maintenance --
(SELECT
  ride_id
FROM
(SELECT
  *,
  COUNT(*) OVER (PARTITION BY DATE(started_at, 'America/Chicago'), start_location) AS overnight_maintenance
FROM
    `sacred-atom-456611-t6.cyclistic_trips.1_5_1_outliers_lwr_removed`
  WHERE trip_duration > 10799 AND DATE(started_at, 'America/Chicago') <> DATE(ended_at, 'America/Chicago'))
WHERE
  overnight_maintenance > 1) AND
ride_id NOT IN
-- d. Removal of rides classified as 'extreme outliers', grouped by end time and end location. This is to remove rides affected by end location network issues -- 
(SELECT
  ride_id
FROM
(SELECT
  *,
  COUNT(*) OVER(PARTITION BY ended_at, end_location) AS bikes_offline_count
FROM
  `sacred-atom-456611-t6.cyclistic_trips.1_5_1_outliers_lwr_removed`
WHERE trip_duration > 3137)
WHERE bikes_offline_count > 1) AND
ride_id NOT IN
-- e. Removal of rides classified as 'extreme outliers', grouped by start time and start location. This is to remove rides affected by start location network issues --
(SELECT
  ride_id
FROM
(SELECT
  *,
  COUNT(*) OVER(PARTITION BY started_at, start_location) AS bikes_online_count
FROM
  `sacred-atom-456611-t6.cyclistic_trips.1_5_1_outliers_lwr_removed`
WHERE trip_duration > 3137)
WHERE bikes_online_count > 1))
