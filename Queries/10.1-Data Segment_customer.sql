-- Customer segmention & its lifespan
WITH customer_spend AS(
SELECT
	c.customer_key,
	MIN(s.order_date) AS first_order,
	MAX(s.order_date) AS last_order,
	SUM(s.sales_amount) AS total_spend,
	DATEDIFF(MONTH,MIN(order_date), MAX(order_date)) AS lifespan 
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
GROUP BY c.customer_key
),
Cust_group AS(
SELECT
	customer_key,
	total_spend,
	lifespan,
	CASE WHEN lifespan >=12 AND total_spend > 5000 THEN 'VIP'
		WHEN lifespan >= 12 AND total_spend <=5000 THEN 'Regular'
		ELSE 'New'
	END customer_segment
FROM customer_spend
)
SELECT
	customer_segment,
	COUNT(customer_key) AS total_customers
FROM Cust_group
GROUP BY customer_segment
ORDER BY total_customers DESC



