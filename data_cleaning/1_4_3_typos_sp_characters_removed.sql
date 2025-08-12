-- Cleaning Step: G-H
-- Input Table Name: 1_4_2_double_spaces_removed
-- Input Table Revision: G
-- Output Table Name: 1_4_3_typos_sp_characters_removed
-- Output Table Revision: H

============================================================

-- 1. finding 20 most frequent words in 'start_location' and 'end_location' fields
WITH all_words AS 
(
SELECT
  words
FROM
  `sacred-atom-456611-t6.cyclistic_trips.1_4_2_double_spaces_removed`,
  UNNEST(SPLIT(start_location, ' ')) AS words
UNION ALL
SELECT
  words
FROM
  `sacred-atom-456611-t6.cyclistic_trips.1_4_2_double_spaces_removed`,
  UNNEST(SPLIT(end_location, ' ')) AS words
)

SELECT
  words,
  COUNT(*) AS no_of_times_repeated
FROM
  all_words
GROUP BY words
ORDER BY no_of_times_repeated DESC
LIMIT 20

-----------------------------------------------------------------

-- 2. Checking for typos in 20 most frequent words
SELECT
  ride_id,
  start_location,
  end_location 
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_4_2_double_spaces_removed`
WHERE
  REGEXP_CONTAINS(LOWER(start_location), r'\b(sst|stt|aave|avee|ddr|drr|llake|lakee|cclark|clarkk|bblvd|blvdd|rrd|rdd|wwells|wellss|ppark|parkk|mmichigan|michigann|sshore|shoree|hhalsted|halstedd|ddusable|dusablee|bbroadway|broadwayy|jjackson|jacksonn|ggrand|grandd|cclinton|clintonn|cchicago|chicagoo)\b') OR
REGEXP_CONTAINS(LOWER(end_location), r'\b(sst|stt|aave|avee|ddr|drr|llake|lakee|cclark|clarkk|bblvd|blvdd|rrd|rdd|wwells|wellss|ppark|parkk|mmichigan|michigann|sshore|shoree|hhalsted|halstedd|ddusable|dusablee|bbroadway|broadwayy|jjackson|jacksonn|ggrand|grandd|cclinton|clintonn|cchicago|chicagoo)\b') 

-----------------------------------------------------------------------

-- 3. Finding instances of station duplication due to asterisk
SELECT
  asterisk.start_location_id,
  asterisk.start_location AS location_asterisk,
  no_asterisk.start_location AS location_no_asterisk
FROM 
(SELECT
DISTINCT start_location,
start_location_id
FROM
  `sacred-atom-456611-t6.cyclistic_trips.1_4_2_double_spaces_removed`
WHERE
  REGEXP_CONTAINS(start_location, r'\*')) AS asterisk
LEFT JOIN
(SELECT
  DISTINCT start_location,
  start_location_id
FROM
`sacred-atom-456611-t6.cyclistic_trips.1_4_2_double_spaces_removed`
WHERE NOT
REGEXP_CONTAINS(start_location, r'\*')) AS no_asterisk
ON asterisk.start_location_id = no_asterisk.start_location_id

-----------------------------------------------------------------------------------

-- 4. Removing asterisk and replacing forward slash with '&' for consistency.
CREATE TABLE IF NOT EXISTS
  `sacred-atom-456611-t6.cyclistic_trips.1_4_3_typos_sp_characters_removed` AS
(SELECT
  * EXCEPT(start_location, end_location),
  REGEXP_REPLACE(REGEXP_REPLACE(start_location, r'\b/\b', ' & '), r'\*', '') AS start_location,
  REGEXP_REPLACE(REGEXP_REPLACE(end_location, r'\b/\b', ' & '), r'\*', '') AS end_location
FROM 
  `sacred-atom-456611-t6.cyclistic_trips.1_4_2_double_spaces_removed`)