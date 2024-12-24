use trips_db;

/* BR4. Identify Cities with Highest and Lowest Total New Passengers */
-- cities with highest total new passengers --
with a as(
select city_id,  sum(fp.new_passengers) as total_new_passengers
from fact_passenger_summary fp
group by city_id ),
b as( 
select city_name, total_new_passengers,
rank() over(order by total_new_passengers desc) as rnk
from a 
join dim_city dc on a.city_id = dc.city_id),
c as (
select city_name, total_new_passengers,
(case when rnk <=3 then "top 3"
when rnk >=7 then "bottom 3"
else "middle rank" end ) as city_categories
from b 
group by city_name, total_new_passengers) 
select city_name, total_new_passengers, city_categories from c
where city_categories ="top 3" or city_categories = "bottom 3";