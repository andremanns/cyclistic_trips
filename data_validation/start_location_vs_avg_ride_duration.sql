-- Title: Start location vs avg ride duration
-- Report Section: Data Validation

===========================================================

-- Start location vs avg ride duration: 1_5_1_outliers_lwr_removed
SELECT
  start_location,
  ROUND(avg(trip_duration)/60) AS avg_trip_duration,
  COUNT(*) AS no_of_trips
FROM
  `sacred-atom-456611-t6.cyclistic_trips.1_5_1_outliers_lwr_removed`
GROUP BY
  start_location

------------------------------------------------------

-- Start location vs avg ride duration: 3_1_1_analysis
SELECT
  start_location,
  ROUND(avg(ride_duration_seconds)/60) AS avg_trip_duration,
  COUNT(*) AS no_of_trips
FROM
  `sacred-atom-456611-t6.cyclistic_trips.3_1_1_analysis`
GROUP BY
  start_location
