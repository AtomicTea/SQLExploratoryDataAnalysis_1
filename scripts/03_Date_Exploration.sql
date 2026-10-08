/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/

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

