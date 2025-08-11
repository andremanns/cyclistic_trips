-- Cleaning Step: A-B
-- Input Table Name: 0_0_1_raw_data
-- Input Table Revision: A
-- Output Table Name: 1_1_1_duplicates_removed
-- Output Table Revision: B

======================================================

-- 1. Find duplicates
SELECT
  COUNT(*) AS all_rides,
  COUNT(DISTINCT(ride_id)) AS unique_rides,
  COUNT(*)-COUNT(DISTINCT(ride_id)) AS duplicated_rides
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.0_0_1_raw_data`

------------------------------------------------------

-- 2. How many ride_id(s) affected?
SELECT
  ride_id,
  COUNT(*) AS no_of_duplicates
FROM
  `sacred-atom-456611-t6.cyclistic_trips.0_0_1_raw_data`
GROUP BY
  ride_id
HAVING no_of_duplicates > 1
ORDER BY
  COUNT(*) DESC

-------------------------------------------------------

--3. Removing duplicates and creating new table
CREATE TABLE IF NOT EXISTS
`sacred-atom-456611-t6.cyclistic_trips.1_1_1_duplicates_removed` AS
SELECT
* EXCEPT(duplicates)
FROM
(
  SELECT
  *,
  row_number() over (partition by ride_id) AS duplicates
  FROM
    `sacred-atom-456611-t6.cyclistic_trips.0_0_1_raw_data`
)
WHERE duplicates < 2
