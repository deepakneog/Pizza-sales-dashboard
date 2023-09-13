select * from pizza_data;
copy pizza_data from 'C:\Program Files\PostgreSQL\15\data\dataset\pizza_sales.csv' CSV header;

--KPI

--Total Revenue:
select sum(total_price) as Total_Price from pizza_data;

--Average Order Value
select sum(total_price) / count(distinct order_id) as Average from pizza_data;

--Total Pizzas Sold
select sum(quantity) as Total_pizza_sold from pizza_data;

--Total Orders
select count(distinct order_id) as Total_order from pizza_data;

--Average Pizzas Per Order
select cast(cast(sum(quantity) as decimal(10,2)) / 
cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2))
as Average_pizza_sold_per_order 
from pizza_data;

--Chart requirement

--Daily Trend for Total Orders
select to_char(order_date, 'Day') as order_day, 
count(distinct order_id) 
from pizza_data 
group by order_day;

--Monthly Trend for Orders
select to_char(order_date, 'Month') as Month_order, 
count(distinct order_id) as total_order
from pizza_data 
group by Month_order
order by total_order desc;

--Total % of Sales by Pizza Category
select pizza_category, sum(total_price) as Total_price,
sum(total_price) * 100/ (select sum(total_price) from pizza_data) as PCT
from pizza_data
group by pizza_category;

--Total % of Sales by Pizza Size
select pizza_size, sum(total_price) as Total_price,
cast(sum(total_price) * 100/ (select sum(total_price) from pizza_data) as decimal(10,2)) as PCT
from pizza_data
group by pizza_size 
order by Total_price desc;

--Total Pizzas Sold by Pizza Category						 
select pizza_category, sum(quantity) as Pizza_sold 
from pizza_data
group by pizza_category
order by Pizza_sold desc;

--Top 5 Pizzas by Revenue						 
select pizza_name, sum(total_price) as Total_price
from pizza_data
group by pizza_name
order by Total_price desc
limit 5;

--Bottom 5 Pizzas by Revenue						 
select pizza_name, sum(total_price) as Total_price
from pizza_data
group by pizza_name
order by Total_price asc
limit 5;

--Top 5 Pizzas by Quantity						 
select pizza_name, sum(quantity) as Total_quantity
from pizza_data
group by pizza_name
order by Total_quantity desc
limit 5;

--Bottom 5 Pizzas by Quantity						 
select pizza_name, sum(quantity) as Total_quantity
from pizza_data
group by pizza_name
order by Total_quantity asc
limit 5;

--Top 5 Pizzas by Total Orders						 
select pizza_name, count(distinct order_id) as Total_order
from pizza_data
group by pizza_name
order by Total_order desc
limit 5;

--Bottom 5 Pizzas by Total Orders						 
select pizza_name, count(distinct order_id) as Total_order
from pizza_data
group by pizza_name
order by Total_order asc
limit 5;