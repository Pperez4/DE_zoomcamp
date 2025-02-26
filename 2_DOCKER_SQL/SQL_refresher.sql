-------------------------------------------------------------------------
-- IMPLICIT JOIN 
-- ---> In this type of join we don't specify the 'JOIN' keyword
-- ---> We focus more on 'WHERE' - 'FROM' to get the data we want
-------------------------------------------------------------------------

SELECT
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    total_amount,
	--The boroughs of New York City are the five major governmental districts that comprise New York City
    CONCAT(zpu."Borough", ' | ', zpu."Zone") AS "pickup_loc",
    CONCAT(zdo."Borough", ' | ', zdo."Zone") AS "dropoff_loc"
FROM 
    ny_taxi_data t,
    zones zpu,
    zones zdo
WHERE
    t."PULocationID" = zpu."LocationID"
    AND t."DOLocationID" = zdo."LocationID"
LIMIT 100;


-------------------------------------------------------------------------
-- EXPLICIT INNER JOIN 
-- ---> In this type of join we do specify the 'JOIN' keyword
-------------------------------------------------------------------------

SELECT
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    total_amount,
    CONCAT(zpu."Borough", ' | ', zpu."Zone") AS "pickup_loc",
    CONCAT(zdo."Borough", ' | ', zdo."Zone") AS "dropoff_loc"
FROM 
    ny_taxi_data t
JOIN 
-- or INNER JOIN but it's less used, when writing JOIN, 
-- postgreSQL understands implicitly that we want to use an INNER JOIN
    zones zpu ON t."PULocationID" = zpu."LocationID"
JOIN
    zones zdo ON t."DOLocationID" = zdo."LocationID"
LIMIT 100;

------------------------------------------------------------------------
-- Checking for Location IDs in the Zones table NOT IN the Yellow Taxi table
------------------------------------------------------------------------

SELECT
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    total_amount,
    "PULocationID",
    "DOLocationID"
FROM ny_taxi_data
-- subquery 
WHERE
    "DOLocationID" NOT IN (SELECT "LocationID" from zones)
    OR "PULocationID" NOT IN (SELECT "LocationID" from zones)
LIMIT 100;


--------------------------------------------------------------------------
-- number of trips per day
--------------------------------------------------------------------------
SELECT
    CAST(tpep_dropoff_datetime AS DATE) AS "day",
    COUNT(*)
FROM 
    ny_taxi_data
GROUP BY
    CAST(tpep_dropoff_datetime AS DATE)
LIMIT 100;