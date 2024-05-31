USE case_study;

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dbo' 
AND TABLE_NAME = '2023_24_tripdata_all_tripdata';


USE case_study;

SELECT 
    COUNT(*) - COUNT(ride_id) AS ride_id,
    COUNT(*) - COUNT(rideable_type) AS rideable_type,
    COUNT(*) - COUNT(started_at) AS started_at,
    COUNT(*) - COUNT(ended_at) AS ended_at,
    COUNT(*) - COUNT(CONVERT(nvarchar(max), start_station_name)) AS start_station_name,
    COUNT(*) - COUNT(CONVERT(nvarchar(max), start_station_id)) AS start_station_id,
    COUNT(*) - COUNT(CONVERT(nvarchar(max), end_station_name)) AS end_station_name,
    COUNT(*) - COUNT(CONVERT(nvarchar(max), end_station_id)) AS end_station_id,
    COUNT(*) - COUNT(start_lat) AS start_lat,
    COUNT(*) - COUNT(start_lng) AS start_lng,
    COUNT(*) - COUNT(end_lat) AS end_lat,
    COUNT(*) - COUNT(end_lng) AS end_lng,
    COUNT(*) - COUNT(member_casual) AS member_casual
FROM dbo.[2023_24_tripdata_all_tripdata];



USE case_study;

SELECT COUNT(ride_id) - COUNT(DISTINCT ride_id) AS duplicate_rows
FROM dbo.[2023_24_tripdata_all_tripdata];


USE case_study;

SELECT rideable_type, COUNT(rideable_type) AS trip_type
FROM dbo.[2023_24_tripdata_all_tripdata]
GROUP BY rideable_type;


use case_study
SELECT DISTINCT member_casual, COUNT(*) AS count_member_type
FROM dbo.[2023_24_tripdata_all_tripdata]
GROUP BY member_casual;