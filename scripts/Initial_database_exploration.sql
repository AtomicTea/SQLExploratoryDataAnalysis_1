-- =====================================================================================================
-- 			Initial Database Exploration
-- =====================================================================================================		

-- Exploring all objects in the Database
SELECT * FROM INFORMATION_SCHEMA.TABLES

-- Exploring all columns in the Database
SELECT * FROM INFORMATION_SCHEMA.COLUMNS

-- Exploring a specific table's columns
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers'
