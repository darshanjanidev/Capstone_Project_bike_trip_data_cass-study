# Capstone_Project_bike_trip_data_cass-study
Course: [Google Data Analytics Capstone: Complete a Case Study](https://www.coursera.org/learn/google-data-analytics-capstone)
## Introduction
In this case study, I will perform many real-world tasks of a junior data analyst at a fictional company, Cyclistic. In order to answer the key business questions, I will follow the steps of the data analysis process: [Ask](https://github.com/darshanjanidev/Google_Capstone_Project_bike_trip_data_case-study/blob/main/README.md#ask), [Prepare](https://github.com/darshanjanidev/Google_Capstone_Project_bike_trip_data_case-study/blob/main/README.md#prepare), [Process](https://github.com/darshanjanidev/Google_Capstone_Project_bike_trip_data_case-studyblob/main/README.md#process), [Analyze](https://github.com/darshanjanidev/Google_Capstone_Project_bike_trip_data_case-study/blob/main/README.md#analyze-and-share), [Share](https://github.com/darshanjanidev/Google_Capstone_Project_bike_trip_data_case-study/blob/main/README.md#analyze-and-share), and [Act](https://github.com/darshanjanidev/Google_Capstone_Project_bike_trip_data_case-study#act).
  
Data Visualizations: [Tableau](https://public.tableau.com/app/profile/darshan.jani/viz/Case_Study-Bike-Trip-data/BikeTypes#1)  
## Background
### Cyclistic
A bike-share program that features more than 5,800 bicycles and 600 docking stations. Cyclistic sets itself apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive to people with disabilities and riders who can’t use a standard two-wheeled bike. The majority of riders opt for traditional bikes; about 8% of riders use the assistive options. Cyclistic users are more likely to ride for leisure, but about 30% use them to commute to work each day.   
  
Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments. One approach that helped make these things possible was the flexibility of its pricing plans: single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers who purchase annual memberships are Cyclistic members.  
  
Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the pricing flexibility helps Cyclistic attract more customers, Moreno (the director of marketing and my manager) believes that maximizing the number of annual members will be key to future growth. Rather than creating a marketing campaign that targets all-new customers, Moreno believes there is a very good chance to convert casual riders into members. She notes that casual riders are already aware of the Cyclistic program and have chosen Cyclistic for their mobility needs.  

Moreno has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members. In order to do that, however, the marketing analyst team needs to better understand how annual members and casual riders differ, why casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are interested in analyzing the Cyclistic historical bike trip data to identify trends.  

### Scenario
I am assuming to be a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, my team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, my team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve our recommendations, so they must be backed up with compelling data insights and professional data visualizations.

## Ask
### Business Task
Devise marketing strategies to convert casual riders to members.
### Analysis Questions
Three questions will guide the future marketing program:  
1. How do annual members and casual riders use Cyclistic bikes differently?  
2. Why would casual riders buy Cyclistic annual memberships?  
3. How can Cyclistic use digital media to influence casual riders to become members?  

Moreno has assigned me the first question to answer: How do annual members and casual riders use Cyclistic bikes differently?
## Prepare
### Data Source
I will use Cyclistic’s historical trip data to analyze and identify trends from Jan 2022 to Dec 2022 which can be downloaded from [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html). The data has been made available by Motivate International Inc. under this [license](https://www.divvybikes.com/data-license-agreement).  
  
This is public data that can be used to explore how different customer types are using Cyclistic bikes. But note that data-privacy issues prohibit from using riders’ personally identifiable information. This means that we won’t be able to connect pass purchases to credit card numbers to determine if casual riders live in the Cyclistic service area or if they have purchased multiple single passes.

This step will address the data source that will be used for the analysis and the organization of the data structure.

**Data Source**:  Cyclistic’s historical trip data from Jan 2022 to Dec 2022 which is a public dataset published by Motivate International Inc. will be used to analyze and identify trends. [Click Here](https://divvy-tripdata.s3.amazonaws.com/index.html) for the dataset.

**Data Information**: In the data source, there are 12 files in total following the naming convention of *"YYYYMM-divvy-tripdata"*. Each file contains data for a specific month, including other details such as ride ID, bike type, start time, end time, start station, end station, start location, end location, and member status. The corresponding column names are:
- ride_id
- rideable_type
- started_at
- ended_at
- start_station_name
- start_station_id
- end_station_name
- end_station_id
- start_lats
- start_lng
- end_lat
- end_lng
- member_casual
  

## Process

**Tool**: SQL Server Management Studio 20 is used to combine the total 12 files into one dataset.

#### Data Combination

Tables representing 12 CSV files have been uploaded to the case_study dataset. To help with data combination, the following SQL query is implemented in order to combine all 12 files into a single dataset. A new table named ***"all_tripdata"*** has been generated using the following code.:

```
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

```

Then, to check the total row numbers, we perform this SQL query. The new dataset ***"all_tripdata"*** holds a total of 5,738,612 data rows encompassing the entire year:

```
SELECT Count(*)
  FROM [case_study].[dbo].[2023_24_tripdata_all_tripdata]
```
We perform the following code to show the first 10 rows of the dataset in order to understand the dataset better

```
USE case_study;

SELECT TOP 10 *
FROM dbo.[2023_24_tripdata_all_tripdata];

```
#### Data Exploration

In order to do data exploration, the first thing to do is to check the data type to observe the inconsistencies. After checking, we have seen that the entire dataset has the ride_id as the primary key:

```
USE case_study;

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dbo' 
AND TABLE_NAME = '2023_24_tripdata_all_tripdata';

```
To help ensure data cleanness, we have to check if the dataset has any null values in any column. However, it appears that there are no ***null*** values in the dataset:

```
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

```

After checking the null values, we also need to check if the dataset has any duplicate values. By performing this following code, it appears that we have no duplicate values:

```

USE case_study;

SELECT COUNT(ride_id) - COUNT(DISTINCT ride_id) AS duplicate_rows
FROM dbo.[2023_24_tripdata_all_tripdata];

```

Retrieve the records of the rideable_type column to see the different bike types: electric_bike, classical_bike, docked_bike

```
USE case_study;

SELECT rideable_type, COUNT(rideable_type) AS trip_type
FROM dbo.[2023_24_tripdata_all_tripdata]
GROUP BY rideable_type;

```
Retrieve the records of the member_casual column to check the different member types: member, casual

```
use case_study
SELECT DISTINCT member_casual, COUNT(*) AS count_member_type
FROM dbo.[2023_24_tripdata_all_tripdata]
GROUP BY member_casual;
```
The trip starts and end times are indicated in the format YYYY-MM-DD hh:mm:ss UTC in the columns *"started_at"* and *"ended_at."* By introducing a new column called ***"ride_length"*** we can compute the total trip duration. It is necessary to exclude 7343 trips with a duration exceeding one day and 139,873 trips with a duration less than a minute or end times earlier than start times.

Columns such as ***"day_of_week"*** and ***"month"*** can offer valuable insights into analyzing trips at various times throughout the year.

To enhance data integrity, 885429 rows with missing values in both "start_station_name" and "start_station_id" should be eliminated. Similarly, 885,429 rows with missing values in both ***"end_station_name"*** and ***"end_station_id"*** and 7343 rows with missing values in both ***"end_lat"*** and ***"end_lng"*** should also be removed.

```
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

```

In the dataset, there are 885,429 rows where both the ***"start_station_name"*** and ***"start_station_id"*** values are missing.

```
USE case_study;

SELECT DISTINCT 
    CONVERT(nvarchar(max), start_station_name) AS start_station_name
FROM dbo.[2023_24_tripdata_all_tripdata]
ORDER BY start_station_name;



USE case_study;

SELECT COUNT(ride_id) AS start_station_null   
FROM dbo.[2023_24_tripdata_all_tripdata]
WHERE start_station_name IS NULL OR start_station_id IS NULL; 

```

There are also 885,429 rows in which both the ***"end_station_name"*** and ***"end_station_id"*** values are absent.

```
USE case_study;

SELECT DISTINCT 
    CONVERT(nvarchar(max), start_station_name) AS start_station_name
FROM dbo.[2023_24_tripdata_all_tripdata]
ORDER BY start_station_name;


USE case_study;

SELECT COUNT(ride_id) AS start_station_null   
FROM dbo.[2023_24_tripdata_all_tripdata]
WHERE start_station_name IS NULL OR start_station_id IS NULL;  


```
In the dataset, there are a total of 7,613 rows where both the ***"end_lat"*** and ***"end_lng"*** values are missing.
```
USE case_study;

SELECT COUNT(ride_id) AS end_loc_null
FROM dbo.[2023_24_tripdata_all_tripdata]
WHERE end_lat IS NULL OR end_lng IS NULL;

```
#### Data Cleaning

In step, a new table will be created for cleaned data which is easier for analysis. Therefore, the following steps are implemented:

 - First, any rows containing missing values are removed from the dataset.
 - 3 new columns, namely ***"ride_length"*** to indicate the trip duration, ***"day_of_week"*** to specify the day of the week, and ***"month"*** to represent the month, are added.
 - Trips with durations less than a minute and longer than a day are excluded, leading to the removal of a total of 4,224,259 rows during this process.


Create a new table called ***"alldata_cleaned"*** with the following code:
```
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

```

Set ***"ride_id"*** as the primary key for the new table and remove rows:

```
USE case_study;

ALTER TABLE dbo.[2023_24_tripdata].[alldata_cleaned]
ADD PRIMARY KEY (ride_id);

USE case_study;

SELECT COUNT(ride_id) AS no_of_rows
FROM dbo.[2023_24_tripdata_alldata_cleaned]

```

  
## Analyze and Share

#### Data Analysis

In step, all the reports are saved individually in .csv format for visual analysis.

```
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
```



Data Visualization: [Tableau](https://public.tableau.com/app/profile/darshan.jani/viz/Case_Study-Bike-Trip-data/BikeTypes#1)  
The data is stored appropriately and is now prepared for analysis. I queried multiple relevant tables for the analysis and visualized them in Tableau.  
The analysis question is: How do annual members and casual riders use Cyclistic bikes differently?  

First of all, member and casual riders are compared by the type of bikes they are using.  

![Bike Types](https://github.com/darshanjanidev/Google_Capstone_Project_bike_trip_data_case-study/assets/88767282/5a7efe9f-359a-4938-b544-3b5133bcb572)
  
The members make 64.71% of the total while remaining 35.29% constitutes casual riders. Each bike type chart shows percentage from the total. Most used bike is classic bike followed by the electric bike. Docked bikes are used the least by only casual riders. 
  
Next the number of trips distributed by the months, days of the week and hours of the day are examined.  
  
![Total Trips per Month_day_Hour](https://github.com/darshanjanidev/Google_Capstone_Project_bike_trip_data_case-study/assets/88767282/0f184e16-3343-4aaf-b024-5b6606f75411)
  
__Months:__ When it comes to monthly trips, both casual and members exhibit comparable behavior, with more trips in the spring and summer and fewer in the winter. The gap between casuals and members is closest in the month of july in summmer.   
__Days of Week:__ When the days of the week are compared, it is discovered that casual riders make more journeys on the weekends while members show a decline over the weekend in contrast to the other days of the week.  
__Hours of the Day:__ The members shows 2 peaks throughout the day in terms of number of trips. One is early in the morning at around 6 am to 8 am and other is in the evening at around 4 pm to 8 pm while number of trips for casual riders increase consistently over the day till evening and then decrease afterwards.  
  
We can infer from the previous observations that member may be using bikes for commuting to and from the work in the week days while casual riders are using bikes throughout the day, more frequently over the weekends for leisure purposes. Both are most active in summer and spring.  
  
Ride duration of the trips are compared to find the differences in the behavior of casual and member riders.  
  
![Average Ride Diration per Month_Day_hour](https://github.com/darshanjanidev/Google_Capstone_Project_bike_trip_data_case-study/assets/88767282/9ea2ac32-7b1e-4f02-b3bd-3790f9f67110)
  
Take note that casual riders tend to cycle longer than members do on average. The length of the average journey for members doesn't change throughout the year, week, or day. However, there are variations in how long casual riders cycle. In the spring and summer, on weekends, and from 10 am to 2 pm during the day, they travel greater distances. Between five and eight in the morning, they have brief trips.
  
These findings lead to the conclusion that casual commuters travel longer (approximately 2x more) but less frequently than members. They make longer journeys on weekends and during the day outside of commuting hours and in spring and summer season, so they might be doing so for recreation purposes.    
  
To further understand the differences in casual and member riders, locations of starting and ending stations can be analysed. Stations with the most trips are considered using filters to draw out the following conclusions.  
  
![Total Trips Strat Location](https://github.com/darshanjanidev/Google_Capstone_Project_bike_trip_data_case-study/assets/88767282/485c519e-b327-4d3c-a356-f4737a7ab9b8)
  
Casual riders have frequently started their trips from the stations in vicinity of museums, parks, beach, harbor points and aquarium while members have begun their journeys from stations close to universities, residential areas, restaurants, hospitals, grocery stores, theatre, schools, banks, factories, train stations, parks and plazas.  

![Total Trips End Location](https://github.com/darshanjanidev/Google_Capstone_Project_bike_trip_data_case-study/assets/88767282/3475c1ac-98e6-4069-b038-83c0fd57620d)

  
Similar trend can be observed in ending station locations. Casual riders end their journay near parks, museums and other recreational sites whereas members end their trips close to universities, residential and commmercial areas. So this proves that casual riders use bikes for leisure activities while members extensively rely on them for daily commute.  
  
Summary:
  
|Casual|Member|
|------|------|
|Prefer using bikes throughout the day, more frequently over the weekends in summer and spring for leisure activities.|Prefer riding bikes on week days during commute hours (8 am / 5pm) in summer and spring.|
|Travel 2 times longer but less frequently than members.|Travel more frequently but shorter rides (approximately half of casual riders' trip duration).|
|Start and end their journeys near parks, museums, along the coast and other recreational sites.|Start and end their trips close to universities, residential and commercial areas.|  
  
## Act
After identifying the differences between casual and member riders, marketing strategies to target casual riders can be developed to persuade them to become members.  
