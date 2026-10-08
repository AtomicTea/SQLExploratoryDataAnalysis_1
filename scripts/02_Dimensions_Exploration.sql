/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/

-- Explore all Countries our customers come from / geographical spread
SELECT DISTINCT country 
FROM dwport1_gold.dim_customers
ORDER BY country;

-- Explore all Categories/major divisions and subcategories
SELECT DISTINCT 
  category, 
  subcategory, 
  product_name 
FROM dwport1_gold.dim_products
ORDER BY category, subcategory, product_name;
