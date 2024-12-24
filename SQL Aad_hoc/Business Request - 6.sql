use trips_db;

/* BR6. Repeat Passenger rate Analysis */
 select dc.city_name, d.month_name, repeat_passengers,
 total_passengers,
 round((
 sum(fp.repeat_passengers)*100)/sum(fp.total_passengers),2) 
 as repeat_passenger_rate
 from dim_city dc
 join fact_passenger_summary fp
 on dc.city_id = fp.city_id
 join dim_date d 
 on d.start_of_month = fp.month
 group by dc.city_name, d.month_name, repeat_passengers, total_passengers
 order by repeat_passenger_rate desc;