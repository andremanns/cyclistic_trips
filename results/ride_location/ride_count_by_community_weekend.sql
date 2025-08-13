-- Title: Ride count by community and membership type at the weekend
-- Report Section: Results

=====================================================================

CREATE OR REPLACE TABLE `sacred-atom-456611-t6.cyclistic_geo_days.fri_sun_casual` AS
(WITH fri_sun_ride_info AS (
SELECT
    ROUND(start_lat,3) AS start_lat,
    ROUND(start_lng,3) AS start_lng,
    COUNT(*) AS fri_sun_ride_count_coordinates
  FROM
    `sacred-atom-456611-t6.cyclistic_trips.3_1_1_analysis`
  WHERE 
    member_type = 'casual' AND -- enter membership type casual or member
    FORMAT_DATETIME('%A', started_local) IN ('Friday', 'Saturday', 'Sunday')
  GROUP BY
  start_lat,
  start_lng),

communities AS (
SELECT
  ST_GEOGFROMTEXT(the_geom) AS the_geom_cast_geog, -- convert from string to geography for spatial join
  COMMUNITY AS community_name
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.chicago_communities`) -- city of chicago community areas table

SELECT 
* EXCEPT (fri_sun_ride_count_community_name_nulls),
IFNULL(fri_sun_ride_count_community_name_nulls, 0) AS fri_sun_ride_count_community_name -- communities with 0 rides
FROM
(SELECT
community_name,
SUM(fri_sun_ride_count_coordinates) AS fri_sun_ride_count_community_name_nulls -- communities with zero rides listed as nulls
FROM
(SELECT
  communities.community_name,
  fri_sun_ride_info.fri_sun_ride_count_coordinates
FROM 
communities
LEFT JOIN fri_sun_ride_info 
ON ST_CONTAINS(communities.the_geom_cast_geog, ST_GEOGPOINT(fri_sun_ride_info.start_lng, fri_sun_ride_info.start_lat)) -- attributes each coordinate to community
GROUP BY
  community_name,
  fri_sun_ride_info.start_lng,
  fri_sun_ride_info.start_lat,
  fri_sun_ride_info.fri_sun_ride_count_coordinates)
GROUP BY
community_name
ORDER BY
community_name))
