-- bike type used by riders
 USE case_study;

SELECT member_casual, rideable_type, COUNT(*) AS total_trips
FROM dbo.[2023_24_tripdata_alldata_cleaned]
GROUP BY member_casual, rideable_type
ORDER BY member_casual, total_trips;

-- No. of trips per month 

USE case_study;

SELECT month, member_casual, COUNT(ride_id) AS total_trips
FROM dbo.[2023_24_tripdata_alldata_cleaned]
GROUP BY month, member_casual
ORDER BY member_casual;

-- no. of trips per day of week

USE case_study;

SELECT day_of_week, member_casual, COUNT(ride_id) AS total_trips
FROM dbo.[2023_24_tripdata_alldata_cleaned]
GROUP BY day_of_week, member_casual
ORDER BY member_casual;

-- no. of trips per hour

use case_study;
SELECT 
    FORMAT(started_at, 'hh tt') AS hour_of_day_am_pm, 
    member_casual, 
    COUNT(ride_id) AS total_trips
FROM 
    dbo.[2023_24_tripdata_alldata_cleaned]
GROUP BY 
    FORMAT(started_at, 'hh tt'), 
    member_casual
ORDER BY 
    member_casual, 
    hour_of_day_am_pm;


-- average ride_length per month

USE case_study;

SELECT 
    FORMAT(started_at, 'MMM') AS month, 
    member_casual, 
    AVG(DATEDIFF(MINUTE, started_at, ended_at)) AS avg_ride_duration
FROM 
    dbo.[2023_24_tripdata_alldata_cleaned]
GROUP BY 
    FORMAT(started_at, 'MMM'), 
    member_casual
order by
		month,
	member_casual;

	
-- average ride_length per day of week

	USE case_study;

SELECT 
    DATENAME(WEEKDAY, started_at) AS day_of_week, 
    member_casual, 
    AVG(DATEDIFF(MINUTE, started_at, ended_at)) AS avg_ride_duration
FROM 
    dbo.[2023_24_tripdata_alldata_cleaned]
GROUP BY 
    DATENAME(WEEKDAY, started_at), 
    member_casual;
	
-- average ride_length per hour

	USE case_study;

SELECT 
    FORMAT(started_at, 'hh tt') AS hour_of_day_am_pm, 
    member_casual, 
    AVG(ride_length) AS avg_ride_duration
FROM 
    dbo.[2023_24_tripdata_alldata_cleaned]
GROUP BY 
    FORMAT(started_at, 'hh tt'), 
    member_casual
ORDER BY 
    member_casual, 
    hour_of_day_am_pm;


-- starting station locations
	
USE case_study;

SELECT 
    start_station_name, 
    member_casual,
    AVG(start_lat) AS avg_start_lat,
    AVG(start_lng) AS avg_start_lng,
    COUNT(ride_id) AS total_trips
FROM 
    (
        SELECT 
            CAST(start_station_name AS nvarchar(50)) AS start_station_name,
            member_casual,
            CAST(start_lat AS FLOAT) AS start_lat,
            CAST(start_lng AS FLOAT) AS start_lng,
            ride_id
        FROM 
            dbo.[2023_24_tripdata_alldata_cleaned]
    ) AS subquery
GROUP BY 
    start_station_name, 
    member_casual;


-- ending station locations

USE case_study;

SELECT 
    end_station_name, 
    member_casual,
    AVG(end_lat) AS avg_end_lat,
    AVG(end_lng) AS avg_end_lng,
    COUNT(ride_id) AS total_trips
FROM 
    (
        SELECT 
            CAST(end_station_name AS nvarchar(50)) AS end_station_name,
            member_casual,
            CAST(end_lat AS FLOAT) AS end_lat,
            CAST(end_lng AS FLOAT) AS end_lng,
            ride_id
        FROM 
            dbo.[2023_24_tripdata_alldata_cleaned]
    ) AS subquery
GROUP BY 
    end_station_name, 
    member_casual;