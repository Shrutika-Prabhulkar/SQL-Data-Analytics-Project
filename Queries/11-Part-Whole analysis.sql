-- Which categories contribute the most to overall sales?

WITH Category_sales AS (
SELECT
	p.category,
	SUM(s.sales_amount) AS cat_totalSales
FROM gold.dim_products p
LEFT JOIN gold.fact_sales s
ON p.product_key = s.product_key
WHERE p.category IS NOT NULL
GROUP BY p.category
--ORDER BY cat_totalSales DESC
)
SELECT
	category,
	cat_totalSales,
	SUM(cat_totalSales) OVER() AS overallSales,
	CONCAT(ROUND((CAST(cat_totalSales AS FLOAT) / SUM(cat_totalSales) OVER()) * 100,2), '%') AS percentage_total	
FROM Category_sales
ORDER BY cat_totalSales DESC