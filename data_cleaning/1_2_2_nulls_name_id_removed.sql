-- Cleaning Step: C-D
-- Input Table Name: 1_2_1_nulls_lat_lng_removed
-- Input Table Revision: C
-- Output Table Name: 1_2_2_nulls_name_id_removed
-- Output Table Revision: D

============================================================

-- Removing nulls from name and id columns. New backup table created
CREATE TABLE IF NOT EXISTS
  `sacred-atom-456611-t6.cyclistic_trips.1_2_2_nulls_name_id_removed` AS
SELECT
  * EXCEPT(start_station_name, end_station_name, start_station_id, end_station_id),
  IFNULL(start_station_name, 'unregistered_location') AS start_location,
  IFNULL(end_station_name, 'unregistered_location') AS end_location,
  IFNULL(start_station_id, 'unregistered_location') AS start_location_id,
  IFNULL(end_station_id,'unregistered_location') AS end_location_id
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_2_1_nulls_lat_lng_removed`
