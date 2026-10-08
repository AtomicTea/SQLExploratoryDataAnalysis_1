/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), ROW_NUMBER()
    - Clauses: GROUP BY, ORDER BY
=============================================================================== */
-- Which 5 products generate the highest revenue?
SELECT
p.product_name,
ROUND(SUM(f.sales_amount), 2) AS total_revenue
FROM dwport1_gold.fact_sales AS f
LEFT JOIN dwport1_gold.dim_products AS p ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 5
;

-- Simple ranking what are the top 5 products that generate the highest revenue?
SELECT *
FROM(
SELECT
p.product_name,
ROUND(SUM(f.sales_amount), 2) AS total_revenue,
ROW_NUMBER() OVER (
    ORDER BY SUM(f.sales_amount) DESC, p.product_key ASC
) AS rank_products
FROM dwport1_gold.fact_sales AS f
LEFT JOIN dwport1_gold.dim_products AS p ON p.product_key = f.product_key
GROUP BY p.product_key, p.product_name ) AS t
WHERE rank_products <= 5
;

-- True Ranking the top 5 products that generate the highest revenue?
SELECT *
FROM(
SELECT
p.product_name,
ROUND(SUM(f.sales_amount), 2) AS total_revenue,
RANK() OVER (ORDER BY SUM(f.sales_amount) DESC) AS rank_products
FROM dwport1_gold.fact_sales AS f
LEFT JOIN dwport1_gold.dim_products AS p ON p.product_key = f.product_key
GROUP BY p.product_name ) AS t
WHERE rank_products <= 5
;

-- What are the 5 worst-performing products in terms of sales?
SELECT
p.product_name,
ROUND(SUM(f.sales_amount), 2) AS total_revenue
FROM dwport1_gold.fact_sales AS f
LEFT JOIN dwport1_gold.dim_products AS p ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue ASC
LIMIT 5
;


-- What are the 5 best-performing sub-categories in terms of sales?
SELECT
p.subcategory,
ROUND(SUM(f.sales_amount), 2) AS total_revenue
FROM dwport1_gold.fact_sales AS f
LEFT JOIN dwport1_gold.dim_products AS p ON p.product_key = f.product_key
GROUP BY p.subcategory
ORDER BY total_revenue DESC
LIMIT 5
;

-- Who are our top 10 highest revenue customers?
SELECT *
FROM 
(SELECT
c.customer_key,
c.last_name,
c.first_name,
ROW_NUMBER() OVER(ORDER BY SUM(f.sales_amount) DESC) AS customer_rank,
ROUND(SUM(f.sales_amount), 2) AS total_revenue
FROM dwport1_gold.fact_sales AS f
LEFT JOIN dwport1_gold.dim_customers AS c ON c.customer_key = f.customer_key
GROUP BY c.customer_key, c.last_name, c.first_name) AS top
WHERE customer_rank <= 10
;

-- Who are the bottom three customers that generated the least amount of revenue?
SELECT *
FROM 
(SELECT
c.customer_key,
c.last_name,
c.first_name,
ROW_NUMBER() OVER(ORDER BY SUM(f.sales_amount) ASC) AS customer_rank,
ROUND(SUM(f.sales_amount), 2) AS total_revenue
FROM dwport1_gold.fact_sales AS f
LEFT JOIN dwport1_gold.dim_customers AS c ON c.customer_key = f.customer_key
GROUP BY c.customer_key, c.last_name, c.first_name) AS top
WHERE customer_rank <= 3
;

-- Which customers have only ever placed one order?
SELECT *
FROM 
(SELECT
c.customer_key,
c.last_name,
c.first_name,
ROW_NUMBER() OVER(ORDER BY COUNT(DISTINCT f.order_number) ASC) AS customer_rank,
COUNT(DISTINCT f.order_number) AS total_orders
FROM dwport1_gold.fact_sales AS f
LEFT JOIN dwport1_gold.dim_customers AS c ON c.customer_key = f.customer_key
GROUP BY c.customer_key, c.last_name, c.first_name
)
 AS fewest_orders
WHERE total_orders < 2
;

-- How many people are one-order customers?
SELECT COUNT(*)
FROM (SELECT *
FROM 
(SELECT
c.customer_key,
c.last_name,
c.first_name,
ROW_NUMBER() OVER(ORDER BY COUNT(DISTINCT f.order_number) ASC) AS customer_rank,
COUNT(DISTINCT f.order_number) AS total_orders
FROM dwport1_gold.fact_sales AS f
LEFT JOIN dwport1_gold.dim_customers AS c ON c.customer_key = f.customer_key
GROUP BY c.customer_key, c.last_name, c.first_name
)
 AS fewest_orders
WHERE total_orders = 1
) AS total_one_count
;

	
