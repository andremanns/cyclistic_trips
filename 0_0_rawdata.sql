CREATE OR REPLACE TABLE
  `sacred-atom-456611-t6.cyclistic_trips.tripdata_0_0_rawdata` AS
SELECT
  *
FROM
  `sacred-atom-456611-t6.cyclistic_trips.tripdata_*`
WHERE _TABLE_SUFFIX BETWEEN '202405' AND '202504'