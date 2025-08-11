-- Cleaning Step: N/A
-- Input Table Name: N/A
-- Input Table Revision: N/A
-- Output Table Name: 0_0_1_raw_data
-- Output Table Revision: A

====================================================================

-- 1. Aggregating data from monthly trip tables
CREATE OR REPLACE TABLE
  `sacred-atom-456611-t6.cyclistic_trips.0_0_1_raw_data` AS
SELECT
  *
FROM
  `sacred-atom-456611-t6.cyclistic_trips.tripdata_*`
WHERE _TABLE_SUFFIX BETWEEN '202405' AND '202504'

--------------------------------------------------------------------

-- 2. Check all rows from subsets have been correctly aggregated
WITH monthly_rows AS (
  SELECT
    (SELECT COUNT(*)
    FROM `sacred-atom-456611-t6.cyclistic_trips.tripdata_202405`
    ) AS MAY,
    (SELECT COUNT(*)
    FROM `sacred-atom-456611-t6.cyclistic_trips.tripdata_202406`
    ) AS JUNE,
    (SELECT COUNT(*)
    FROM `sacred-atom-456611-t6.cyclistic_trips.tripdata_202407`  
    ) AS JUL,
    (SELECT COUNT(*)
    FROM `sacred-atom-456611-t6.cyclistic_trips.tripdata_202408`  
    ) AS AUG,
    (SELECT COUNT(*)
    FROM `sacred-atom-456611-t6.cyclistic_trips.tripdata_202409`  
    ) AS SEP,
    (SELECT COUNT(*)
    FROM `sacred-atom-456611-t6.cyclistic_trips.tripdata_202410`  
    ) AS OCT,
    (SELECT COUNT(*)
    FROM `sacred-atom-456611-t6.cyclistic_trips.tripdata_202411`  
    ) AS NOV,
    (SELECT COUNT(*)
    FROM `sacred-atom-456611-t6.cyclistic_trips.tripdata_202412`  
    ) AS DEC,
    (SELECT COUNT(*)
    FROM `sacred-atom-456611-t6.cyclistic_trips.tripdata_202501`  
    ) AS JAN,
    (SELECT COUNT(*)
    FROM `sacred-atom-456611-t6.cyclistic_trips.tripdata_202502`  
    ) AS FEB,
    (SELECT COUNT(*)
    FROM `sacred-atom-456611-t6.cyclistic_trips.tripdata_202503`  
    ) AS MAR,
    (SELECT COUNT(*)
    FROM `sacred-atom-456611-t6.cyclistic_trips.tripdata_202504`  
    ) AS APRL
)

  SELECT
    *,
    JAN+FEB+MAR+APRL+MAY+JUNE+JUL+AUG+SEP+OCT+NOV+DEC AS total_rows
  FROM
    monthly_rows