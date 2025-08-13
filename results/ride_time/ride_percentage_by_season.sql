-- Title: Ride Percentage by Season
-- Report Section: Results

=====================================================================================
WITH ride_data AS (
  SELECT 
  *
  FROM
  `sacred-atom-456611-t6.cyclistic_trips.3_1_1_analysis`
),

casual AS (SELECT
  COUNT(*) AS casual_ride_count,
  ROUND((COUNT(*)/(SELECT COUNT(*) FROM ride_data WHERE member_type = 'casual'))*100, 2) AS casual_ride_percentage,
  CASE WHEN
    DATE(started_local) BETWEEN '2024-03-20' AND '2024-06-20' THEN 'Spring'
    WHEN DATE(started_local) BETWEEN '2024-06-20' AND '2024-09-22' THEN 'Summer'
    WHEN DATE(started_local) BETWEEN '2024-09-22' AND '2024-12-21' THEN 'Autumn'
    ELSE 'Winter'
    END AS seasons
FROM 
  ride_data
WHERE
  member_type = 'casual'
GROUP BY seasons),

member AS (SELECT
  COUNT(*) AS member_ride_count,
  ROUND((COUNT(*)/(SELECT COUNT(*) FROM ride_data WHERE member_type = 'member'))*100, 2) AS member_ride_percentage,
  CASE WHEN
    DATE(started_local) BETWEEN '2024-03-20' AND '2024-06-20' THEN 'Spring'
    WHEN DATE(started_local) BETWEEN '2024-06-20' AND '2024-09-22' THEN 'Summer'
    WHEN DATE(started_local) BETWEEN '2024-09-22' AND '2024-12-21' THEN 'Autumn'
    ELSE 'Winter'
    END AS seasons
FROM 
  ride_data
WHERE
  member_type = 'member'
GROUP BY seasons)

SELECT
  casual.seasons,
  casual.casual_ride_count,
  casual.casual_ride_percentage,
  member.member_ride_count,
  member.member_ride_percentage
FROM
  casual
FULL OUTER JOIN member 
ON casual.seasons = member.seasons
ORDER BY CASE casual.seasons 
WHEN 'Spring' THEN 1
WHEN 'Summer' THEN 2
WHEN 'Autumn' THEN 3
WHEN 'Winter' THEN 4
END