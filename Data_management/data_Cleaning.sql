USE case_study;

-- Create the new table
CREATE TABLE [2023_24_tripdata].[alldata_cleaned] (
    ride_id nvarchar(50),
    rideable_type nvarchar(50),
    started_at datetime2(7),
    ended_at datetime2(7),
    ride_length float,
    day_of_week nvarchar(3),
    month nvarchar(3),
    start_station_name ntext,
    end_station_name ntext,
    start_lat float,
    start_lng float,
    end_lat float,
    end_lng float,
    member_casual nvarchar(50)
);

-- Insert data into the new table
INSERT INTO [2023_24_tripdata].[alldata_cleaned] (
    ride_id, rideable_type, started_at, ended_at, 
    ride_length, day_of_week, month,
    start_station_name, end_station_name, 
    start_lat, start_lng, end_lat, end_lng, member_casual
)
SELECT 
    a.ride_id, a.rideable_type, a.started_at, a.ended_at, 
    DATEDIFF(MINUTE, a.started_at, a.ended_at) AS ride_length,
    CASE DATEPART(WEEKDAY, a.started_at) 
      WHEN 1 THEN 'Sun'
      WHEN 2 THEN 'Mon'
      WHEN 3 THEN 'Tue'
      WHEN 4 THEN 'Wed'
      WHEN 5 THEN 'Thu'
      WHEN 6 THEN 'Fri'
      WHEN 7 THEN 'Sat'    
    END AS day_of_week,
    CASE DATEPART(MONTH, a.started_at)
      WHEN 1 THEN 'Jan'
      WHEN 2 THEN 'Feb'
      WHEN 3 THEN 'Mar'
      WHEN 4 THEN 'Apr'
      WHEN 5 THEN 'May'
      WHEN 6 THEN 'Jun'
      WHEN 7 THEN 'Jul'
      WHEN 8 THEN 'Aug'
      WHEN 9 THEN 'Sep'
      WHEN 10 THEN 'Oct'
      WHEN 11 THEN 'Nov'
      WHEN 12 THEN 'Dec'
    END AS month,
    a.start_station_name, a.end_station_name, 
    a.start_lat, a.start_lng, a.end_lat, a.end_lng, a.member_casual
FROM [2023_24_tripdata].[all_tripdata] a
WHERE 
    a.start_station_name IS NOT NULL AND
    a.end_station_name IS NOT NULL AND
    a.end_lat IS NOT NULL AND
    a.end_lng IS NOT NULL AND
    DATEDIFF(MINUTE, a.started_at, a.ended_at) > 1 AND 
    DATEDIFF(MINUTE, a.started_at, a.ended_at) < 1440;



	USE case_study;

ALTER TABLE dbo.[2023_24_tripdata].[alldata_cleaned]
ADD PRIMARY KEY (ride_id);

USE case_study;

SELECT COUNT(ride_id) AS no_of_rows
FROM dbo.[2023_24_tripdata_alldata_cleaned]
