Title: Ride Percentages Through The Year by Member Type
Report Section: Results

======================================================================

WITH casual AS (SELECT
  DATE(started_local) AS date_started,
  COUNT(*) AS casual_ride_count,
  ROUND(COUNT(*)/ (SELECT COUNT(*) FROM `sacred-atom-456611-t6.cyclistic_trips.3_1_1_analysis` WHERE member_type = 'casual')*100,3) AS casual_ride_percentage
FROM
  `sacred-atom-456611-t6.cyclistic_trips.3_1_1_analysis`
WHERE
  member_type = 'casual'
GROUP BY
  date_started),

member AS (
SELECT
  DATE(started_local) AS date_started,
  COUNT(*) AS member_ride_count,
  ROUND(COUNT(*)/ (SELECT COUNT(*) FROM `sacred-atom-456611-t6.cyclistic_trips.3_1_1_analysis` WHERE member_type = 'member')*100,3) AS member_ride_percentage
FROM
  `sacred-atom-456611-t6.cyclistic_trips.3_1_1_analysis`
WHERE
  member_type = 'member'
GROUP BY
  date_started)

SELECT
  casual.date_started,
  casual.casual_ride_count,
  casual.casual_ride_percentage,
  member.member_ride_count,
  member.member_ride_percentage
FROM
  casual
FULL OUTER JOIN
  member
ON member.date_started = casual.date_started
ORDER BY
  date_started