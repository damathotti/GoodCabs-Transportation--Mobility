use trips_db;

/* BR5. identify The month with the Highest Revenue for each City */
with city_revenue as (
select dc.city_name, month_name,
 sum(ft.fare_amount) as revenue
from fact_trips ft
join dim_city dc on dc.city_id = ft.city_id
join dim_date d on d.date = ft.date
group by dc.city_name, month_name
),
city_total_revenue as (
select city_name,  sum(revenue) as total_revenue
from city_revenue 
group by city_name 
),
city_max_revenue as(
select cr.city_name, cr.month_name as highest_revenue_month, 
cr.revenue, ct.total_revenue,
(cr.revenue * 100.0) / ct.total_revenue as percentage_contribution
from city_revenue cr
join city_total_revenue as ct
on cr.city_name = ct.city_name
where cr.revenue = (select max(revenue) from city_revenue 
where city_name = cr.city_name )
)
 select city_name, highest_revenue_month, revenue,
 cast(percentage_contribution as decimal(10,2)) as percent_contribution
 from city_max_revenue
 order by city_name;