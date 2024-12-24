use trips_db;

/* 3. City Level Repeat Passenger Trip Frequency Report */
with repeat_passengers as(
select dc.city_name, dr.city_id, 
sum(case when dr.trip_count = "2-Trips" then dr.repeat_passenger_count else 0 end)
 as trip_2,
 sum(case when dr.trip_count = "3-Trips" then dr.repeat_passenger_count else 0 end)
 as trip_3,
 sum(case when dr.trip_count = "4-Trips" then dr.repeat_passenger_count else 0 end)
 as trip_4,
 sum(case when dr.trip_count = "5-Trips" then dr.repeat_passenger_count else 0 end)
 as trip_5,
 sum(case when dr.trip_count = "6-Trips" then dr.repeat_passenger_count else 0 end)
 as trip_6,
 sum(case when dr.trip_count = "7-Trips" then dr.repeat_passenger_count else 0 end)
 as trip_7,
sum(case when dr.trip_count = "8-Trips" then dr.repeat_passenger_count else 0 end)
 as trip_8,
 sum(case when dr.trip_count = "9-Trips" then dr.repeat_passenger_count else 0 end)
 as trip_9,
 sum(case when dr.trip_count = "10-Trips" then dr.repeat_passenger_count else 0 end)
 as trip_10
 from dim_repeat_trip_distribution dr
 join dim_city dc on dr.city_id = dc.city_id
 group by 1, 2)
 select rp.city_name,
concat(round(trip_2 /sum(dr.repeat_passenger_count)*100,2),"%") as "Trip_2",
concat(round(trip_3 /sum(dr.repeat_passenger_count)*100,2),"%") as "Trip_3",
concat(round(trip_4 /sum(dr.repeat_passenger_count)*100,2),"%") as "Trip_4",
concat(round(trip_5 /sum(dr.repeat_passenger_count)*100,2),"%") as "Trip_5",
concat(round(trip_6 /sum(dr.repeat_passenger_count)*100,2),"%") as "Trip_6",
concat(round(trip_7 /sum(dr.repeat_passenger_count)*100,2),"%") as "Trip_7",
concat(round(trip_8 /sum(dr.repeat_passenger_count)*100,2),"%") as "Trip_8",
concat(round(trip_9 /sum(dr.repeat_passenger_count)*100,2),"%") as "Trip_9",
concat(round(trip_10 /sum(dr.repeat_passenger_count)*100,2),"%") as "Trip_10"
from repeat_passengers rp
join dim_repeat_trip_distribution dr
on rp.city_id = dr.city_id
group by rp.city_id;


