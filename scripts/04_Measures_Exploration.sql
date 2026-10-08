/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions/Set Operators Used:
    - COUNT(), SUM(), AVG()
    - UNION ALL
===============================================================================
*/

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

