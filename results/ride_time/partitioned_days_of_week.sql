-- Title: Ride Percentages Partitioned by Days of the Week and Member Type
-- Report Section: Results

===============================================================

SELECT
  casual.day_of_week,
  casual.no_of_rides AS casual_ride_count,
  casual.percentage AS casual_ride_perecentage,
  member.no_of_rides AS member_ride_count,
  member.percentage AS member_ride_percentage
FROM
(SELECT
FORMAT_DATETIME('%A', started_local) AS day_of_week,
COUNT(*) AS no_of_rides,
ROUND(COUNT(*)/(SELECT COUNT(*) FROM `sacred-atom-456611-t6.cyclistic_trips.3_1_1_analysis` WHERE member_type = 'casual'
)*100,2) AS percentage
FROM
  `sacred-atom-456611-t6.cyclistic_trips.3_1_1_analysis`
WHERE member_type = 'casual'
GROUP BY
  FORMAT_DATETIME('%A', started_local)
) AS casual
JOIN
(SELECT
  FORMAT_DATETIME('%A', started_local) AS day_of_week,
  COUNT(*) AS no_of_rides,
  ROUND(COUNT(*)/(SELECT COUNT(*) FROM `sacred-atom-456611-t6.cyclistic_trips.3_1_1_analysis` WHERE member_type = 'member')*100,2) AS percentage
FROM
  `sacred-atom-456611-t6.cyclistic_trips.3_1_1_analysis`
WHERE member_type = 'member'
GROUP BY
  FORMAT_DATETIME('%A', started_local)
) AS member
ON member.day_of_week = casual.day_of_week
ORDER BY
  CASE casual.day_of_week
  WHEN 'Monday' THEN 1
  WHEN 'Tuesday' THEN 2
  WHEN 'Wednesday' THEN 3
  WHEN 'Thursday' THEN 4
  WHEN 'Friday' THEN 5
  WHEN 'Saturday' THEN 6
  WHEN 'Sunday' THEN 7
END