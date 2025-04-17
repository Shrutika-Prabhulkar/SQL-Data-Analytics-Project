-- Calculate the total sales/ month
-- Running total sales over time

SELECT
	order_month,
	Total_sales,
	SUM(Total_sales) OVER(PARTITION BY order_month ORDER BY order_month) AS Running_TotalSales
FROM 
(
SELECT
	DATETRUNC(MONTH,order_date) AS order_month,
	SUM(sales_amount) AS Total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH,order_date)
) t

----------------------------------------------------------------
-- Calculate the total sales/ year
-- Running total sales over time

SELECT
	order_year,
	Total_sales,
	SUM(Total_sales) OVER(ORDER BY order_year) AS Running_totalSales,
	AVG(Avg_price) OVER(ORDER BY order_year) AS Moving_AvgPrice
FROM
(
SELECT
	DATETRUNC(YEAR,order_date) AS order_year,
	SUM(sales_amount) AS Total_sales,
	AVG(price) AS Avg_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR,order_date)
) t