USE [Pizza DB]

SELECT * FROM pizza_sales

-- Data cleaning 

SELECT * FROM pizza_sales
WHERE
	pizza_id IS NULL
	OR 
	order_id IS NULL
	OR 
	order_date IS NULL 
	OR 
	order_time IS NULL 
	OR 
	total_price IS NULL 
	OR 
	pizza_size IS NULL
	OR 
	pizza_category IS NULL

-- Data exploration 

-- Total order

SELECT COUNT(DISTINCT order_id) AS total_order
FROM pizza_sales

-- Total pizza sold 

SELECT SUM(quantity) AS total_pizzal_sold
FROM pizza_sales 

-- Pizza Category 

SELECT DISTINCT pizza_category 
FROM pizza_sales

-- Data Analysis & Business Key Problems & Answer

-- My Analysis & Findings

-- Q1. What is the total revenue generated from all pizza sales?
-- Q2. Which pizza categories bring the highest revenue?
-- Q3. What is the average number of orders per day?
-- Q4. What is the average number of pizzas sold per order?
-- Q5. What is the average revenue per order?
-- Q6. What is the total sales revenue for each month?
-- Q7. Which pizza size generates the highest total revenue?
-- Q8. On which day of the week does the store receive the highest number of orders?
-- Q9. How do sales vary by time of day (Morning, Afternoon, Evening)?
-- Q10. Which are the Top 5 best-selling pizzas?
-- Q11. Which are the Top 5 least sold pizzas?
-- Q12. Which pizzas generate the highest total revenue?
-- Q13. Which pizzas generate the lowest revenue?



-- Q1. What is the total revenue generated from all pizza sales?

SELECT ROUND(SUM(total_price), 2) AS total_revenue
FROM pizza_sales

-- Q2. Which pizza categories bring the highest revenue? 

SELECT pizza_category, ROUND(SUM(total_price), 2) AS total_revenue
FROM pizza_sales
GROUP BY pizza_category

-- Q3. What is the average number of orders per day?

SELECT COUNT(DISTINCT order_id)/ COUNT(DISTINCT order_date) AS avg_order_per_day
FROM pizza_sales

-- Q4. What is the average number of pizzas sold per order?

SELECT SUM(quantity)/COUNT(DISTINCT order_id) AS avg_pizza_per_order 
FROM pizza_sales 

-- Q5. What is the average revenue per order?

SELECT ROUND(SUM(total_price)/COUNT(DISTINCT order_id),2) AS avg_revenue_per_order
FROM pizza_sales

-- Q6. What is the total sales revenue for each month?

SELECT 
    DATENAME(MONTH, order_date) AS Month_Name,
    MONTH(order_date) AS Month_Number,
    ROUND(SUM(total_price), 2) AS Total_Revenue
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date), MONTH(order_date)
ORDER BY Month_Number

-- Q7. Which pizza size generates the highest total revenue?

SELECT pizza_size, ROUND(SUM(total_price), 2) AS total_revenue, COUNT(DISTINCT order_id) AS total_order
FROM pizza_sales
GROUP BY pizza_size
ORDER BY total_revenue DESC

-- Q8. On which day of the week does the store receive the highest number of orders?
SELECT DATENAME(DW, order_date) AS Order_Day, COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

-- Q9. How do sales vary by time of day (Morning, Afternoon, Evening)?

WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN DATEPART(hour, order_time) < 12 THEN 'Morning'
            WHEN DATEPART(hour, order_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM pizza_sales
)
SELECT 
    shift,
    COUNT(*) AS total_order
FROM hourly_sale
GROUP BY shift
ORDER BY total_order DESC

-- Q10. Which are the Top 5 best-selling pizzas?

SELECT TOP 5 pizza_name, SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity DESC 

-- Q11. Which are the Top 5 least sold pizzas?

SELECT TOP 5 pizza_name, SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity ASC 

-- Q12. Which pizzas generate the highest total revenue?

SELECT TOP 5 pizza_name, ROUND(SUM(total_price), 2) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC 

-- Q13. Which pizzas generate the lowest revenue?

SELECT TOP 5 pizza_name, ROUND(SUM(total_price), 2) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC


-- END OF PROJECT 