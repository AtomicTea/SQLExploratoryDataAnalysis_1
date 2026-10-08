-- =====================================================================================================
-- 			Initial Database Exploration
-- =====================================================================================================		
/*
-- Exploring all objects in the Database
SELECT * FROM INFORMATION_SCHEMA.TABLES

-- Exploring all columns in the Database
SELECT * FROM INFORMATION_SCHEMA.COLUMNS

-- Exploring a specific table's columns
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers'
*/
-- =====================================================================================================
-- 			Dimensions Exploration
-- =====================================================================================================	
-- Explore all Countries our customers come from / geographical spread
SELECT DISTINCT country FROM dwport1_gold.dim_customers;

-- Explore all Categories/major divisions and subcategories
SELECT DISTINCT category, subcategory, product_name FROM dwport1_gold.dim_products
ORDER BY category, subcategory, product_name;



-- =====================================================================================================
-- 			Data Exploration
-- =====================================================================================================
/* ******** Exploring Orders ********* */		
-- Find the date of the First and Last order
-- How many calendar years of sales data are available (elapsed time between first and last order dates)?
SELECT MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date,
YEAR(MAX(order_date)) - YEAR(MIN(order_date)) AS years_of_sales, -- these are calendar years, not actual years
TIMESTAMPDIFF(
        MONTH,
        MIN(order_date),
        MAX(order_date)
    ) AS months_of_sales
FROM dwport1_gold.fact_sales;

/* ******** Exploring Customers ********* */		
-- Find the youngest and oldest customers
SELECT
MIN(birthdate) AS oldest_birthdate,
TIMESTAMPDIFF(YEAR, MIN(birthdate), CURRENT_DATE()) AS oldest_age,
MAX(birthdate) AS youngest_birthdate,
TIMESTAMPDIFF(YEAR, MAX(birthdate), CURRENT_DATE())AS youngest_age
FROM dwport1_gold.dim_customers;




-- =====================================================================================================
-- 			Measures Exploration
-- =====================================================================================================		
-- Find the Total Sales
SELECT SUM(sales_amount) AS total_sales
FROM dwport1_gold.fact_sales;

-- Find how many items are sold
SELECT SUM(quantity) AS total_quantity
FROM dwport1_gold.fact_sales;

-- Find the Average Selling Price
SELECT AVG(price) AS avg_price
FROM dwport1_gold.fact_sales;

-- Find the Total number of Orders
SELECT COUNT(DISTINCT order_number) AS total_orders
FROM dwport1_gold.fact_sales;

-- Find the Total number of Products
SELECT COUNT(DISTINCT product_key) AS total_products
FROM dwport1_gold.dim_products;

-- Find the Total number of Customers
SELECT COUNT(DISTINCT customer_key) AS total_customers
FROM dwport1_gold.dim_customers;

-- Find the total number of customers who have placed an order
SELECT COUNT(DISTINCT customer_key) AS customer_orders
FROM dwport1_gold.fact_sales;

-- Report showing all key metrics of the business
SELECT 'Total Sales' AS measure_name,
 ROUND(SUM(sales_amount),2) AS measure_value
FROM dwport1_gold.fact_sales
UNION ALL
SELECT 'Total Quantity' AS measure_name, ROUND(SUM(quantity),2) AS measure_value
FROM dwport1_gold.fact_sales
UNION ALL
SELECT 'Average Price' AS measure_name, ROUND(AVG(price),2) AS measure_value
FROM dwport1_gold.fact_sales
UNION ALL
SELECT 'Total # Orders' AS measure_name, COUNT(DISTINCT order_number) AS measure_value
FROM dwport1_gold.fact_sales
UNION ALL
SELECT 'Total # Products' AS measure_name, COUNT(DISTINCT product_key) AS measure_value
FROM dwport1_gold.dim_products
UNION ALL
SELECT 'Total # Customers' AS measure_name, COUNT(DISTINCT customer_key) AS measure_value
FROM dwport1_gold.dim_customers
;


-- =====================================================================================================
-- 			Magnitude Exploration
-- =====================================================================================================		
-- Find the Total Customers by Country
SELECT 
country,
COUNT(customer_key) AS total_customers
FROM dwport1_gold.dim_customers
GROUP BY country
ORDER BY total_customers DESC; 

-- Find Total Customers by Gender
SELECT
gender,
COUNT(customer_key) AS total_customers
FROM dwport1_gold.dim_customers
GROUP BY gender
ORDER BY customer_gender DESC
; 

-- Find Total Products by Category
SELECT
category,
COUNT(product_key) AS total_products
FROM dwport1_gold.dim_products
GROUP BY category
ORDER BY total_products DESC;

-- What is the average cost in each category?
SELECT
category,
ROUND(AVG(cost),2) AS avg_cost
FROM dwport1_gold.dim_products
GROUP BY category
ORDER BY avg_cost DESC;

-- What is the total revenue generated for each category?
SELECT
p.category,
ROUND(SUM(f.sales_amount), 2) AS total_revenue
FROM dwport1_gold.fact_sales AS f
LEFT JOIN dwport1_gold.dim_products AS p ON p.product_key = f.product_key
GROUP BY p.category
ORDER BY total_revenue DESC
;

-- Find total revenue generated by each customer
SELECT
c.last_name,
c.first_name,
c.customer_key,
ROUND(SUM(f.sales_amount), 2) AS total_revenue
FROM dwport1_gold.fact_sales AS f
LEFT JOIN dwport1_gold.dim_customers AS c ON c.customer_key = f.customer_key
GROUP BY c.customer_key, c.last_name, c.first_name
ORDER BY total_revenue DESC
;

-- What is the distribution of sold items across countries?
SELECT 
    c.country,
    SUM(f.quantity) AS total_sold_items
FROM
    dwport1_gold.fact_sales AS f
        LEFT JOIN
    dwport1_gold.dim_customers AS c ON c.customer_key = f.customer_key
GROUP BY c.country
ORDER BY total_sold_items DESC
;



-- Totals of each category per country
SELECT 
c.country AS Country,
p.product_name AS product_name,
p.product_key AS product_key
FROM dwport1_gold.fact_sales AS f
LEFT JOIN dwport1_gold.dim_products AS p ON f.product_key = p.product_key
LEFT JOIN dwport1_gold.dim_customers AS c ON f.customer_key = c.customer_key
GROUP BY country, product_name, product_key
ORDER BY country  
;

-- =====================================================================================================
-- 			Ranking Analysis
-- =====================================================================================================		
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

-- Ranking the  top 5 products that generate the highest revenue?
SELECT *
FROM(
SELECT
p.product_name,
ROUND(SUM(f.sales_amount), 2) AS total_revenue,
ROW_NUMBER() OVER (ORDER BY SUM(f.sales_amount) DESC) AS rank_products
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

	
