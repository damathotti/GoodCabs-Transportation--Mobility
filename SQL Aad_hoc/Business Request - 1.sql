use trips_db;

select city_name, count(trip_id) as total_trips,
round((sum(fare_amount)/sum(distance_travelled_km)),2) as avg_fare_per_km,
round((sum(fare_amount)/count(trip_id)),2) as avg_fare_per_trip,
round(((count(ft.trip_id) /(select count(trip_id) from fact_trips))*100),2) as 
city_percent_contribution
from fact_trips ft 
inner join dim_city dc
on ft.city_id = dc.city_id
group by dc.city_name;