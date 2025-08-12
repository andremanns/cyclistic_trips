-- Cleaning Step: M-N
-- Input Table Name: 2_1_1_format
-- Input Table Revision: M
-- Output Table Name: 3_1_1_analysis
-- Output Table Revision: N

============================================================

-- Create Cleaned Table for Analysis
CREATE TABLE IF NOT EXISTS
`sacred-atom-456611-t6.cyclistic_trips.3_1_1_analysis` AS
SELECT * FROM `sacred-atom-456611-t6.cyclistic_trips.2_1_1_format`