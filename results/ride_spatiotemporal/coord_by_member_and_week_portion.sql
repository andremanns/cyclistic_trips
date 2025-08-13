-- Title: Average starting coordinates by member type and week portion
-- Report Section: Results

=========================================================================

WITH rider_info as 
  (SELECT
    member_type,
    CASE WHEN
  day_of_week = 'Saturday' OR day_of_week = 'Sunday' OR day_of_week = 'Friday' THEN 'Weekend'
    ELSE 'Weekday'
    END AS days_grouped,
    start_lng,
    start_lat
  FROM
    (SELECT
      member_type,
      FORMAT_DATETIME('%A', started_local) AS day_of_week,
      ROUND(start_lng,3) AS start_lng, 
      ROUND(start_lat,3) AS start_lat
    FROM
      `sacred-atom-456611-t6.cyclistic_trips.3_1_1_analysis`))


SELECT
  member_type,
  days_grouped,
  ROUND(AVG(start_lng),3),
  ROUND(AVG(start_lat),3)
FROM
  rider_info
WHERE
  member_type = 'member' AND -- enter member type casual or member
  days_grouped = 'Weekday' -- enter week portion weekday or weekend
GROUP BY
  member_type,
  days_grouped