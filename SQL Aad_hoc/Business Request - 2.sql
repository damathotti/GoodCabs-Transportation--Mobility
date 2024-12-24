use trips_db;
/*Business Request - 2: Monthly City-Level Trips Target Performance Report*/

with actual_trip as( select dc.city_name, d.month_name,
count(ft.trip_id) as actual_trip
from fact_trips ft
join dim_city dc on ft.city_id = dc.city_id
join dim_date d on d.date = ft.date
group by dc.city_name, d.month_name ) ,
target_trips as ( select dc.city_name, d.month_name,
sum(total_target_trips) as target_trips
from targets_db.monthly_target_trips mt
join dim_city dc on dc.city_id = mt.city_id
join dim_date d on d.date = mt.month
group by dc.city_name, d.month_name
)
select at.city_name, at.month_name, at.actual_trip,t.target_trips,
case when t.target_trips = 0 then null
else round(((actual_trip - target_trips) / Nullif(target_trips, 0))* 100,2)
end as percent_difference,
case when actual_trip > target_trips then "Above Target"
else "Below Target"
end as performance_status
from actual_trip at
join target_trips t
on at.city_name = t.city_name and at.month_name = t.month_name 
order by at.city_name, at.month_name;