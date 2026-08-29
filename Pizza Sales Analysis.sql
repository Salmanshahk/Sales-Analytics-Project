SELECT * FROM pizza_sales;

--Total Revenue
SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales;

--Average Order Value
SELECT SUM(total_price)/COUNT(DISTINCT(order_id)) AS AVG 
FROM pizza_sales;

--Total Pizzas Sold
SELECT SUM(quantity) AS Total_quantity 
from pizza_sales;

--Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_order 
from pizza_sales;


--Average Pizzas Per Order:
SELECT 
	CAST(CAST(SUM(quantity) AS decimal(10,2)) / 
	CAST(COUNT(DISTINCT order_id) AS decimal(10,2)) AS decimal(10,2))AS AVG_order
FROM pizza_sales;


--Hourly Trend for Total Pizzas Sold
SELECT 
	DATEPART(HOUR, order_time) AS order_hour, 
	SUM(quantity) as Total_pizza_sold 
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)


--Weekly Trend for Total Orders

SELECT 
	DATEPART(ISO_WEEK, order_date) as WEEK_Number,
	YEAR(order_date) as Order_year,
	COUNT(DISTINCT order_id) as Total_orders
From pizza_sales
GROUP BY DATEPART(ISO_WEEK, order_date),YEAR(order_date)
ORDER BY DATEPART(ISO_WEEK, order_date),YEAR(order_date)

--Percentage of Sales by Pizza Category

SELECT 
	pizza_category, 
	SUM (total_price) as Total_Sales,
	SUM(total_price) * 100 / 
		(SELECT SUM(total_price) FROM pizza_sales) AS PCT
FROM pizza_sales
--WHERE MONTH(order_date) = 1			#It will filter the record where month is 'JANUARY'
GROUP BY pizza_category

--Percentage of Sales by Pizza Size

SELECT 
	pizza_size, 
	CAST(SUM (total_price)AS DECIMAL(10,2)) as Total_Sales ,
	CAST(SUM(total_price) * 100 / 
		(SELECT SUM(total_price) FROM pizza_sales) AS decimal(10,2)) AS PCT
FROM pizza_sales
--WHERE DATEPART(quarter, order_date) = 1		#Filter by Quarter using where clause
GROUP BY pizza_size


--Top 5 Best Sellers by Revenue

SELECT 
	TOP 5 pizza_name, 
	SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
Order BY Total_Revenue DESC

--Top 5 Best Sellers by Total Quantity

SELECT 
	TOP 5 pizza_name, 
	SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
Order BY Total_Quantity DESC

--Top 5 Best Sellers by Total Orders

SELECT 
	TOP 5 pizza_name, 
	COUNT(DISTINCT order_id) AS Total_Order
FROM pizza_sales
GROUP BY pizza_name
Order BY Total_Order DESC


--Bottom 5 Best Sellers by Revenue

SELECT 
	TOP 5 pizza_name, 
	SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
Order BY Total_Revenue ASC

--Bottom 5 Best Sellers by Total Quantity

SELECT 
	TOP 5 pizza_name, 
	SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
Order BY Total_Quantity ASC

--Bottom 5 Best Sellers by Total Orders

SELECT 
	TOP 5 pizza_name, 
	COUNT(DISTINCT order_id) AS Total_Order
FROM pizza_sales
GROUP BY pizza_name
Order BY Total_Order ASC



1.29