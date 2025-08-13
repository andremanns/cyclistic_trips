-- Title: T-test input values
-- Report Section: Results

=========================================================

SELECT
COUNT(*) AS n_casual,
AVG(ride_duration_seconds) AS mean_casual,
STDDEV(ride_duration_seconds) AS sd_casual,
VARIANCE(ride_duration_seconds) AS var_casual
FROM
(SELECT
  ride_duration_seconds
FROM
  `sacred-atom-456611-t6.cyclistic_trips.3_1_1_analysis`
WHERE
  member_type = 'casual') -- enter member type casual or member