use pizza_sales_project;
select * from pizza_sales_excel_project;

-- Add a new date column
ALTER TABLE pizza_sales_excel_project
ADD new_order_date DATE;

-- Update the new date column with the correctly formatted date values
UPDATE pizza_sales_excel_project
SET new_order_date = STR_TO_DATE(order_date, '%m/%d/%Y');

-- Optionally, drop or rename the old text column
-- Drop the old column
ALTER TABLE pizza_sales_excel_project
DROP COLUMN order_date;

desc pizza_sales_excel_project;
-- Total revenue
select sum(total_price) as Total_Revenue from pizza_sales_excel_project;

-- AVG order value

select sum(total_price) / sum(quantity) as Avg_amount_per_order
from pizza_sales_excel_project; 

select sum(total_price) / count(distinct order_id) as Avg_order_value
from pizza_sales_excel_project; 

-- total orders
select count(distinct order_id) as Total_orders from pizza_sales_excel_project;

-- total quantity of pizzas sold

select sum(quantity) as quantity_sold
from pizza_sales_excel_project;

-- Avg pizzas per order 

select cast( cast(sum(quantity) as decimal (10,2)) / cast( count(distinct order_id) as decimal (10,2)) as decimal (10,2))
as Avg_pizza_per_orders
from pizza_sales_excel_project;

-- TOTAL ORDERS OF PIZZA PER DAY
SELECT dayNAME(new_order_date) AS day_of_week, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales_excel_project
GROUP BY DAYOFWEEK(new_order_date)
ORDER BY total_orders DESC;

-- TOTAL ORDERS OF PIZZA PER MONTHS
SELECT monthname (new_order_date)AS Month_of_year, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales_excel_project
GROUP BY monthname(Month_of_year)
ORDER BY total_orders ;


SELECT DATE_FORMAT(new_order_date, '%m') AS months, 
COUNT(DISTINCT order_id) as Total_orders
FROM pizza_sales_excel_project
GROUP BY months 
ORDER BY Total_orders desc; 

-- total sales for differnt pizza catagories
-- For percentage we will take the sum of total sales of pizza and  multiply with 100 
-- will divide whole quesry with again selecting the sum of total price of all pizza catagoeries ALL TOGETHER

select pizza_category,pizza_name ,sum(total_price)as total_sales, (SUM(total_price) / (SELECT SUM(total_price)
FROM pizza_sales_excel_project)) * 100 AS percentage
FROM pizza_sales_excel_project 
GROUP BY pizza_category 
order by percentage desc;

-- Total saels by pizza size
-- we used cast for both percetage and total sales to get values upto 2 decimal points
select pizza_size,pizza_name ,cast((total_price ) as decimal (10,2))as total_sales,
cast(SUM(total_price) * 100 / (SELECT SUM(total_price) AS percentage
FROM pizza_sales_excel_project)as decimal (10,2))  AS percentage
FROM pizza_sales_excel_project
GROUP BY pizza_size
order By percentage asc;

-- Best selling pizza in terms of revenue and orders

select  pizza_name_id, cast(sum(total_price)as decimal (10,2)) as total_revenue
FROM pizza_sales_excel_project
group by pizza_name_id
order by total_revenue desc
limit 5; -- Limit function we use in order to get the top 5 pizzs with best revenues

select  pizza_name_id, cast(sum(total_price)as decimal (10,2)) as total_revenue
FROM pizza_sales_excel_project
group by pizza_name_id
order by total_revenue asc
limit 5; -- Limit function we use in order to get the top 5 pizzs with in terms of worst revenues

-- In terms of quantity

select  pizza_name, cast(sum(quantity)as decimal(10,2))as total_quantity
FROM pizza_sales_excel_project
group by pizza_name
order by total_quantity desc
limit 5; -- Limit function we use in order to get the top 5 pizzs with best quantity

select  pizza_name, cast(sum(quantity)as decimal(10,2))as total_quantity
FROM pizza_sales_excel_project
group by pizza_name
order by total_quantity asc
limit 5; -- Limit function we use in order to get the top 5 pizzs with worst quantity

-- In terms of orders
-- these are names in terms of getting worst numbers of orders
select  pizza_name,count(distinct order_id)as total_orders
FROM pizza_sales_excel_project
group by pizza_name
order by total_orders asc
limit 5;  

-- these are names in terms of getting best numbers of orders    
select  pizza_name,count(distinct order_id)as total_orders
FROM pizza_sales_excel_project
group by pizza_name
order by total_orders desc
limit 5;  














