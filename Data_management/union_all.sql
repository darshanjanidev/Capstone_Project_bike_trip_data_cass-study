USE case_study;

-- Step 1: Create the table if it does not exist
IF NOT EXISTS (
    SELECT * 
    FROM sys.tables 
    WHERE name = '2023_24_tripdata_all_tripdata' AND schema_id = SCHEMA_ID('dbo')
)
BEGIN
    CREATE TABLE dbo.[2023_24_tripdata_all_tripdata] (
        ride_id NVARCHAR(50),
        rideable_type NVARCHAR(50),
        started_at DATETIME2(7),
        ended_at DATETIME2(7),
        start_station_name NTEXT,
        start_station_id NTEXT,
        end_station_name NTEXT,
        end_station_id NTEXT,
        start_lat FLOAT,
        start_lng FLOAT,
        end_lat FLOAT,
        end_lng FLOAT,
        member_casual NVARCHAR(50)
    );
END;

-- Step 2: Populate the table with data
INSERT INTO dbo.[2023_24_tripdata_all_tripdata] (
    ride_id, 
    rideable_type, 
    started_at, 
    ended_at, 
    start_station_name, 
    start_station_id, 
    end_station_name, 
    end_station_id, 
    start_lat, 
    start_lng, 
    end_lat, 
    end_lng, 
    member_casual
)
SELECT * FROM [case_study].[dbo].[202305-divvy-tripdata]
UNION ALL
SELECT * FROM [case_study].[dbo].[202306-divvy-tripdata]
UNION ALL
SELECT * FROM [case_study].[dbo].[202307-divvy-tripdata]
UNION ALL
SELECT * FROM [case_study].[dbo].[202308-divvy-tripdata]
UNION ALL
SELECT * FROM [case_study].[dbo].[202309-divvy-tripdata]
UNION ALL
SELECT * FROM [case_study].[dbo].[202310-divvy-tripdata]
UNION ALL
SELECT * FROM [case_study].[dbo].[202311-divvy-tripdata]
UNION ALL
SELECT * FROM [case_study].[dbo].[202312-divvy-tripdata]
UNION ALL
SELECT * FROM [case_study].[dbo].[202401-divvy-tripdata]
UNION ALL
SELECT * FROM [case_study].[dbo].[202402-divvy-tripdata]
UNION ALL
SELECT * FROM [case_study].[dbo].[202403-divvy-tripdata]
UNION ALL
SELECT * FROM [case_study].[dbo].[202404-divvy-tripdata];

SELECT Count(*)
  FROM [case_study].[dbo].[2023_24_tripdata_all_tripdata]