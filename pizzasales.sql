SHOW TABLES FROM pizza_db;
USE pizza_db;
RENAME TABLE pizza_sale_data TO pizzaSales;

-- Total Revenue
select round(sum(total_price),2) as Total_Revenue
from pizzaSales;

-- Average order value
select round((sum(total_price)/count(distinct order_id)),2) as Average_order_value
from pizzaSales;

-- Total pizza sold
select sum(quantity) as Total_Pizza_Sold
from pizzasales;

-- Total orders
select count(distinct order_id) as Total_Orders
from pizzasales;

-- Average pizzas per order
select round(sum(quantity)/ count(distinct order_id),2) as average_pizza_per_order
from pizzasales;
-- another way by using CAST function
select cast(cast(sum(quantity) as decimal (10,2)) / cast(count(distinct order_id) as decimal(10,2)) 
as decimal(10,2)) as average_pizza_per_order
from pizzasales;

-- for checking data type of specific column in the table
SELECT data_type
FROM information_schema.columns
WHERE table_schema = 'pizza_db' -- Replace 'your_database_name' with your actual database name
  AND table_name = 'pizzasales'
  AND column_name = 'order_date';    -- Replace 'your_column_name' with your actual column name

-- Daily trend for total orders
SELECT DAYNAME(order_date) AS Weeknames, 
       COUNT(DISTINCT order_id) AS total_order
FROM pizzasales
WHERE order_date IS NOT NULL
GROUP BY DAYNAME(order_date)
order by total_order Desc;

-- Monthly trend for total orders
select monthname(order_date) as MonthNames, count(distinct order_id) as Total_orders
from pizzasales
group by MonthNames
order by Total_orders desc;

-- Percentage of sales by pizza category 
SELECT pizza_category,
       round(SUM(total_price)) AS total_sales,
       round(SUM(total_price) * 100 / (select sum(total_price) from pizzasales),2)AS percentage_sales
FROM pizzasales    
GROUP BY pizza_category
order by percentage_sales desc;

-- Percentage of sale by pizza size
select pizza_size,round(sum(total_price))as total_sales,
round(sum(total_price) * 100 / (select sum(total_price) from pizzasales),2)as percentage_sales
from pizzasales
group by pizza_size
order by percentage_sales desc;

-- total pizzas sold by pizza category
select pizza_category, sum(quantity) as total_pizzas_sold
from pizzasales
group by pizza_category;

-- top 5 best sellers by revenue
select pizza_name,
sum(total_price) as total_revenue 
from pizzasales
group by pizza_name
order by total_revenue desc
limit 5;

-- top 5 best sellers by total quantity
select pizza_name, sum(quantity) as total_Quantity
from pizzasales
group by pizza_name
order by total_Quantity desc 
limit 5;

-- top 5 best sellers by total orders
select pizza_name, count(distinct order_id) as total_orders
from pizzasales
group by pizza_name
order by total_orders desc 
limit 5;

-- bottom 5 best sellers by revenue 
select pizza_name,
sum(quantity*unit_price) as total_revenue 
from pizzasales
group by pizza_name
order by total_revenue asc
Limit 5;

















