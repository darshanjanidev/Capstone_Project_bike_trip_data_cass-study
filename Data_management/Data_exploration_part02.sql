USE case_study;

SELECT TOP 20 started_at, ended_at
FROM dbo.[2023_24_tripdata_all_tripdata];


USE case_study;

SELECT COUNT(*) AS longer_than_1_day
FROM dbo.[2023_24_tripdata_all_tripdata]
WHERE DATEDIFF(MINUTE, started_at, ended_at) >= 1440;  -- 1440 minutes = 1 day 7343 rows


USE case_study;

SELECT COUNT(*) AS less_than_a_minute
FROM dbo.[2023_24_tripdata_all_tripdata]
WHERE DATEDIFF(SECOND, started_at, ended_at) <= 60;  -- 60 seconds = 1 minute  139873 rows


USE case_study;

SELECT DISTINCT 
    CONVERT(nvarchar(max), start_station_name) AS start_station_name
FROM dbo.[2023_24_tripdata_all_tripdata]
ORDER BY start_station_name;



USE case_study;

SELECT COUNT(ride_id) AS start_station_null   
FROM dbo.[2023_24_tripdata_all_tripdata]
WHERE start_station_name IS NULL OR start_station_id IS NULL; 


USE case_study;

SELECT DISTINCT 
    CONVERT(nvarchar(max), start_station_name) AS start_station_name
FROM dbo.[2023_24_tripdata_all_tripdata]
ORDER BY start_station_name;


USE case_study;

SELECT COUNT(ride_id) AS start_station_null   
FROM dbo.[2023_24_tripdata_all_tripdata]
WHERE start_station_name IS NULL OR start_station_id IS NULL;  


USE case_study;

SELECT COUNT(ride_id) AS end_loc_null
FROM dbo.[2023_24_tripdata_all_tripdata]
WHERE end_lat IS NULL OR end_lng IS NULL;
