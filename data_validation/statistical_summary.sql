-- Title: Statistical Summary
-- Report Section: Data Validation

============================================================

-- Assessing profile of 0_0_1_raw_data
WITH median_data AS 
(
SELECT
  ROUND(uq_td + (3*(uq_td - lq_td)),0) AS extreme_upper_bound_td,
  ROUND(mq_td,0) AS median_td,
  ROUND(uq_td-lq_td,0) AS iqr
FROM
(
  SELECT
    percentile_cont(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000, 0.25) over() AS lq_td,
    percentile_cont(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000, 0.5) over() AS mq_td,
    percentile_cont(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000, 0.75) over() AS uq_td
  FROM
    `sacred-atom-456611-t6.cyclistic_trips.0_0_1_raw_data`
  LIMIT 1
)
),

mean_data AS 
(
SELECT
  ROUND(AVG(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000),0) AS mean_td,
  ROUND(STDDEV(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000),0) AS sd_td,
  ROUND((STDDEV(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000)/AVG(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000))*100,0) AS coefvar_td,
  ROUND(MIN(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000),0) AS min_duration,
  ROUND(MAX(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000),0) AS max_duration
FROM
  `sacred-atom-456611-t6.cyclistic_trips.0_0_1_raw_data`
)

SELECT
  extreme_upper_bound_td,
  median_td,
  min_duration,
  max_duration,
  iqr,
  mean_td,
  sd_td,
  coefvar_td
FROM
  mean_data, 
  median_data

---------------------------------------------------------------

-- Assessing profile of 1_1_1_duplicates_removed
WITH median_data AS 
(
SELECT
  ROUND(uq_td + (3*(uq_td - lq_td)),0) AS extreme_upper_bound_td,
  ROUND(mq_td,0) AS median_td,
  ROUND(uq_td - lq_td,0) AS iqr
FROM
(
  SELECT
    percentile_cont(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000, 0.25) over() AS lq_td,
    percentile_cont(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000, 0.5) over() AS mq_td,
    percentile_cont(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000, 0.75) over() AS uq_td
  FROM
    `sacred-atom-456611-t6.cyclistic_trips.1_1_1_duplicates_removed`
  LIMIT 1
)
),

mean_data AS 
(
SELECT
  ROUND(AVG(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000),0) AS mean_td,
  ROUND(STDDEV(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000),0) AS sd_td,
  ROUND((STDDEV(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000)/AVG(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000))*100,0) AS coefvar_td,
  ROUND(MIN(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000),0) AS min_duration,
  ROUND(MAX(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000),0) AS max_duration
FROM
  `sacred-atom-456611-t6.cyclistic_trips.1_1_1_duplicates_removed`
)

SELECT
  extreme_upper_bound_td,
  median_td,
  iqr,
  min_duration,
  max_duration,
  mean_td,
  sd_td,
  coefvar_td
FROM
  mean_data, 
  median_data

  ----------------------------------------------------------------

-- Assessing profile of 1_2_1_nulls_lat_lng_removed
WITH median_data AS 
(
SELECT
  ROUND(uq_td + (3*(uq_td - lq_td)),0) AS extreme_upper_bound_td,
  ROUND(mq_td,0) AS median_td,
  ROUND(uq_td - lq_td,0) AS iqr
FROM
(
  SELECT
    percentile_cont(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000, 0.25) over() AS lq_td,
    percentile_cont(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000, 0.5) over() AS mq_td,
    percentile_cont(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000, 0.75) over() AS uq_td
  FROM
    `sacred-atom-456611-t6.cyclistic_trips.1_2_1_nulls_lat_lng_removed`
  LIMIT 1
)
),

mean_data AS 
(
SELECT
  ROUND(AVG(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000),0) AS mean_td,
  ROUND(STDDEV(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000),0) AS sd_td,
  ROUND((STDDEV(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000)/AVG(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000))*100,0) AS coefvar_td,
  ROUND(MIN(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000),0) AS min_duration,
  ROUND(MAX(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000),0) AS max_duration
FROM
  `sacred-atom-456611-t6.cyclistic_trips.1_2_1_nulls_lat_lng_removed`
)

SELECT
  extreme_upper_bound_td,
  median_td,
  iqr,
  min_duration,
  max_duration,
  mean_td,
  sd_td,
  coefvar_td
FROM
  mean_data, 
  median_data

----------------------------------------------------------------------

-- Assessing profile of 1_3_1_filtered
WITH median_data AS 
(
SELECT
  ROUND(uq_td + (3*(uq_td - lq_td)),0) AS extreme_upper_bound_td,
  ROUND(mq_td,0) AS median_td,
  ROUND(uq_td - lq_td,0) AS iqr
FROM
(
  SELECT
    percentile_cont(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000, 0.25) over() AS lq_td,
    percentile_cont(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000, 0.5) over() AS mq_td,
    percentile_cont(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000, 0.75) over() AS uq_td
  FROM
    `sacred-atom-456611-t6.cyclistic_trips.1_3_1_filtered`
  LIMIT 1
)
),

mean_data AS 
(
SELECT
  ROUND(AVG(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000),0) AS mean_td,
  ROUND(STDDEV(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000),0) AS sd_td,
  ROUND((STDDEV(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000)/AVG(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000))*100,0) AS coefvar_td,
  ROUND(MIN(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000),0) AS min_duration,
  ROUND(MAX(TIMESTAMP_DIFF(ended_at, started_at, millisecond)/1000),0) AS max_duration
FROM
  `sacred-atom-456611-t6.cyclistic_trips.1_3_1_filtered`
)

SELECT
  extreme_upper_bound_td,
  median_td,
  iqr,
  min_duration,
  max_duration,
  mean_td,
  sd_td,
  coefvar_td
FROM
  mean_data, 
  median_data

-----------------------------------------------------------------------------------

-- Assessing profile of 1_5_1_outliers_lwr_removed. Determination of extreme-upper boundary
WITH median_data AS 
(
SELECT
  ROUND(uq_td + (3*(uq_td - lq_td)),0) AS extreme_upper_bound_td,
  ROUND(mq_td,0) AS median_td,
  uq_td - lq_td AS iqr
FROM
(
  SELECT
    percentile_cont(trip_duration, 0.25) over() AS lq_td,
    percentile_cont(trip_duration, 0.5) over() AS mq_td,
    percentile_cont(trip_duration, 0.75) over() AS uq_td
  FROM
    `sacred-atom-456611-t6.cyclistic_trips.1_5_1_outliers_lwr_removed`
  LIMIT 1
)
),

mean_data AS 
(
SELECT
  ROUND(AVG(trip_duration),0) AS mean_td,
  ROUND(STDDEV(trip_duration),0) AS sd_td,
  ROUND((STDDEV(trip_duration)/AVG(trip_duration))*100,0) AS coefvar_td,
  MIN(trip_duration) AS min_duration,
  MAX(trip_duration) AS max_duration
FROM
  `sacred-atom-456611-t6.cyclistic_trips.1_5_1_outliers_lwr_removed`
)

SELECT
  extreme_upper_bound_td,
  median_td,
  iqr,
  min_duration,
  max_duration,
  mean_td,
  sd_td,
  coefvar_td
FROM
  mean_data, 
  median_data

---------------------------------------------------------------------------

-- Assessing profile of 1_5_2_outliers_upr_removed
WITH median_data AS 
(
SELECT
  ROUND(uq_td + (3*(uq_td - lq_td)),0) AS extreme_upper_bound_td,
  ROUND(mq_td,0) AS median_td,
  uq_td - lq_td AS iqr
FROM
(
  SELECT
    percentile_cont(trip_duration, 0.25) over() AS lq_td,
    percentile_cont(trip_duration, 0.5) over() AS mq_td,
    percentile_cont(trip_duration, 0.75) over() AS uq_td
  FROM
    `sacred-atom-456611-t6.cyclistic_trips.1_5_2_outliers_upr_removed`
  LIMIT 1
)
),

mean_data AS 
(
SELECT
  ROUND(AVG(trip_duration),0) AS mean_td,
  ROUND(STDDEV(trip_duration),0) AS sd_td,
  ROUND((STDDEV(trip_duration)/AVG(trip_duration))*100,0) AS coefvar_td,
  MIN(trip_duration) AS min_duration,
  MAX(trip_duration) AS max_duration
FROM
  `sacred-atom-456611-t6.cyclistic_trips.1_5_2_outliers_upr_removed`
)

SELECT
  extreme_upper_bound_td,
  median_td,
  iqr,
  min_duration,
  max_duration,
  mean_td,
  sd_td,
  coefvar_td
FROM
  mean_data, 
  median_data

---------------------------------------------------------------------------------------

-- Assessing profile of 1_5_3_speed_outliers_removed
WITH median_data AS 
(
SELECT
  ROUND(uq_td + (3*(uq_td - lq_td)),0) AS extreme_upper_bound_td,
  ROUND(mq_td,0) AS median_td,
  uq_td - lq_td AS iqr
FROM
(
  SELECT
    percentile_cont(trip_duration, 0.25) over() AS lq_td,
    percentile_cont(trip_duration, 0.5) over() AS mq_td,
    percentile_cont(trip_duration, 0.75) over() AS uq_td
  FROM
    `sacred-atom-456611-t6.cyclistic_trips.1_5_3_speed_outliers_removed`
  LIMIT 1
)
),

mean_data AS 
(
SELECT
  ROUND(AVG(trip_duration),0) AS mean_td,
  ROUND(STDDEV(trip_duration),0) AS sd_td,
  ROUND((STDDEV(trip_duration)/AVG(trip_duration))*100,0) AS coefvar_td,
  MIN(trip_duration) AS min_duration,
  MAX(trip_duration) AS max_duration
FROM
  `sacred-atom-456611-t6.cyclistic_trips.1_5_3_speed_outliers_removed`
)

SELECT
  extreme_upper_bound_td,
  median_td,
  iqr,
  min_duration,
  max_duration,
  mean_td,
  sd_td,
  coefvar_td
FROM
  mean_data, 
  median_data

----------------------------------------------------------------------------------

-- Assessing profile of 3_1_1_analysis
WITH median_data AS 
(
SELECT
  ROUND(uq_td + (3*(uq_td - lq_td)),0) AS extreme_upper_bound_td,
  ROUND(mq_td,0) AS median_td,
  uq_td - lq_td AS iqr
FROM
(
  SELECT
    percentile_cont(ride_duration_seconds, 0.25) over() AS lq_td,
    percentile_cont(ride_duration_seconds, 0.5) over() AS mq_td,
    percentile_cont(ride_duration_seconds, 0.75) over() AS uq_td
  FROM
    `sacred-atom-456611-t6.cyclistic_trips.3_1_1_analysis`
  LIMIT 1
)
),

mean_data AS 
(
SELECT
  ROUND(AVG(ride_duration_seconds),0) AS mean_td,
  ROUND(STDDEV(ride_duration_seconds),0) AS sd_td,
  ROUND((STDDEV(ride_duration_seconds)/AVG(ride_duration_seconds))*100,0) AS coefvar_td,
  MIN(ride_duration_seconds) AS min_duration,
  MAX(ride_duration_seconds) AS max_duration
FROM
  `sacred-atom-456611-t6.cyclistic_trips.3_1_1_analysis`
)

SELECT
  extreme_upper_bound_td,
  median_td,
  iqr,
  min_duration,
  max_duration,
  mean_td,
  sd_td,
  coefvar_td
FROM
  mean_data, 
  median_data

