-- Title: Partitioned ride duration by member type
-- Report Section: Results

=================================================================================

WITH casual AS (SELECT
COUNT(*) AS casual_ride_count_grouped,
CASE WHEN
  ride_duration_seconds < 10*60 THEN 'Ride Duration < 10 minutes'
  WHEN ride_duration_seconds >= 10*60 AND ride_duration_seconds < 20*60 THEN '10 <= Ride Duration < 20'
  WHEN ride_duration_seconds >= 20*60 AND ride_duration_seconds < 30*60 THEN '20 <= Ride Duration < 30'
  WHEN ride_duration_seconds >= 30*60 AND ride_duration_seconds < 40*60 THEN '30 <= Ride Duration < 40'
  WHEN ride_duration_seconds >= 40*60 AND ride_duration_seconds < 50*60 THEN '40 <= Ride Duration < 50'
  WHEN ride_duration_seconds >= 50*60 AND ride_duration_seconds < 60*60 THEN '50 <= Ride Duration < 60'
  ELSE 'Ride Duration >= 1 hour'
  END AS duration_grouping,
  (SELECT
  COUNT(*)
  FROM
  `sacred-atom-456611-t6.cyclistic_trips.3_1_1_analysis`
  WHERE
  member_type = 'casual') AS casual_ride_count_total
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.3_1_1_analysis`
WHERE
  member_type = 'casual'
GROUP BY
  duration_grouping
ORDER BY
  casual_ride_count_grouped DESC),

member AS (SELECT
COUNT(*) AS member_ride_count_grouped,
CASE WHEN
  ride_duration_seconds < 10*60 THEN 'Ride Duration < 10 minutes'
  WHEN ride_duration_seconds >= 10*60 AND ride_duration_seconds < 20*60 THEN '10 <= Ride Duration < 20'
  WHEN ride_duration_seconds >= 20*60 AND ride_duration_seconds < 30*60 THEN '20 <= Ride Duration < 30'
  WHEN ride_duration_seconds >= 30*60 AND ride_duration_seconds < 40*60 THEN '30 <= Ride Duration < 40'
  WHEN ride_duration_seconds >= 40*60 AND ride_duration_seconds < 50*60 THEN '40 <= Ride Duration < 50'
  WHEN ride_duration_seconds >= 50*60 AND ride_duration_seconds < 60*60 THEN '50 <= Ride Duration < 60'
  ELSE 'Ride Duration >= 1 hour'
  END AS duration_grouping,
  (SELECT
  COUNT(*)
  FROM
  `sacred-atom-456611-t6.cyclistic_trips.3_1_1_analysis`
  WHERE
  member_type = 'member') AS member_ride_count_total
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.3_1_1_analysis`
WHERE
  member_type = 'member'
GROUP BY
  duration_grouping
ORDER BY
  member_ride_count_grouped DESC)

SELECT
  casual.duration_grouping,
  casual.casual_ride_count_grouped,
  (casual.casual_ride_count_grouped/casual_ride_count_total)*100 AS casual_ride_percentage_grouped,
  member.member_ride_count_grouped,
  (member.member_ride_count_grouped/member_ride_count_total)*100 AS member_ride_percentage_grouped
FROM
  casual
JOIN member
ON casual.duration_grouping = member.duration_grouping