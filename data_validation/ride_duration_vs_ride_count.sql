-- Title: Ride Duration vs Ride Count
-- Report Section: Data Validation

-- Ride duration vs Ride Count: 1_5_1_outliers_lwr_removed
SELECT
  COUNT(*) AS no_of_rides,
  ROUND(timestamp_diff(ended_at, started_at, second)/60) AS duration_minutes
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_5_1_outliers_lwr_removed`
GROUP BY 
ROUND(timestamp_diff(ended_at, started_at, second)/60)

-- Ride duration vs Ride Count: 1_5_2_outliers_upr_removed
SELECT
  COUNT(*) AS no_of_rides,
  ROUND(timestamp_diff(ended_at, started_at, second)/60) AS duration_minutes
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_5_2_outliers_upr_removed`
GROUP BY 
ROUND(timestamp_diff(ended_at, started_at, second)/60)