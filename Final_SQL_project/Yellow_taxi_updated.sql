-- 1)  The average number of trips on Saturdays

select (count("tpep_dropoff_datetime") / count(distinct("tpep_dropoff_datetime")))
from
(select "tpep_dropoff_datetime", to_char("tpep_dropoff_datetime", 'day') as "day_name"
from "yellow_tripdata_2015-01") as dd
where "day_name" like 'satur%'



-- 2)The average fare (fare_amount) per trip on Saturdays

select avg("fare_amount") as "avg_fare_amount", "day_name"
from
(select "fare_amount", to_char("tpep_dropoff_datetime", 'day') as "day_name"
from "yellow_tripdata_2015-01") as "day"
where "day_name" like 'satur%'
group by 2
order by 1



-- 3) The average duration per trip on Saturdays
select avg("duration") as "avg_duration", "day_name"
from
(select to_char("tpep_dropoff_datetime", 'day') as "day_name", 
("tpep_dropoff_datetime" - "tpep_pickup_datetime") as "duration", "trip_distance"
from "yellow_tripdata_2015-01") as "duration"
where "day_name" like 'satur%'
group by 2
order by 1


-- 4) The average number of trips on Sundays

select (count("tpep_dropoff_datetime") / count(distinct("tpep_dropoff_datetime")))
from
(select "tpep_dropoff_datetime", to_char("tpep_dropoff_datetime", 'day') as "day_name"
from "yellow_tripdata_2015-01") as dd
where "day_name" like 'sund%'


-- 5) The average fare (fare_amount) per trip on Sundays

select avg("fare_amount") as "avg_fare_amount", "day_name"
from
(select "fare_amount", to_char("tpep_dropoff_datetime", 'day') as "day_name"
from "yellow_tripdata_2015-01") as "day"
where "day_name" like 'sund%'
group by 2
order by 1


-- 6)  The average duration per trip on Sundays

select avg("duration") as "avg_duration", "day_name"
from
(select to_char("tpep_dropoff_datetime", 'day') as "day_name", 
("tpep_dropoff_datetime" - "tpep_pickup_datetime") as "duration", "trip_distance"
from "yellow_tripdata_2015-01") as "duration"
where "day_name" like 'sund%'
group by 2
order by 1
