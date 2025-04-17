SELECT
	YEAR(order_date) AS Order_year,
	MONTH(order_date) AS Order_Month,
	SUM(sales_amount) AS Total_Sales,
	COUNT(DISTINCT customer_key) AS Total_Customers,
	SUM(quantity) AS Total_quantity
FROM
	gold.fact_sales
WHERE MONTH(order_date) IS NOT NULL
GROUP BY YEAR(order_date),MONTH(order_date)
ORDER BY YEAR(order_date),MONTH(order_date)



SELECT
	DATETRUNC(MONTH, order_date) AS Order_date,
	SUM(sales_amount) AS Total_Sales,
	COUNT(DISTINCT customer_key) AS Total_Customers,
	SUM(quantity) AS Total_quantity
FROM
	gold.fact_sales
WHERE MONTH(order_date) IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date)
ORDER BY DATETRUNC(MONTH, order_date)