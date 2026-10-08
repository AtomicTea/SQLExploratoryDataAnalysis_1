# SQLExploratoryDataAnalysis_1

# Exploratory Data Analysis (EDA) Project

## Overview

This project explores customer, product, and sales data within a MySQL data warehouse to understand the structure of the dataset, identify key business patterns, and establish a foundation for more detailed analysis.

Using SQL, I examined customer demographics, product characteristics, order activity, and sales trends to understand what the data reveals about the business. The analysis focuses on summarizing the data, identifying patterns, and answering foundational business questions.

This project demonstrates how structured data can be prepared and explored to support business reporting and decision-making.

## Objectives

* Understand the structure and scope of the available customer, product, and sales data.
* Identify key metrics, including customer counts, product counts, order activity, and sales totals.
* Explore customer demographics and purchasing behavior.
* Examine product characteristics and distribution.
* Evaluate the time span covered by the sales data.
* Practice writing SQL queries that support exploratory analysis and inform future business questions.

## Tools & Technologies

* **MySQL** — querying, aggregation, and exploratory data analysis
* **MySQL Workbench** — SQL development and query execution
* **SQL techniques** — aggregate functions, joins, subqueries, Common Table Expressions (CTEs), window functions, date functions, and conditional logic


## Data Sources

The analysis uses the Gold layer of a <a href="https://github.com/AtomicTea/SQl-data-warehouse-project-1" target="new">MySQL data warehouse project</a> I completed previously, which contains business-ready views built from cleaned and transformed data in the Silver layer.

The primary datasets are:

* **'dim_customers'** — customer attributes and demographic information
* **'dim_products'** — product attributes and product classifications
* **'fact_sales'** — sales transactions and order-related information

Together, these datasets provide a foundation for exploring customer, product, and sales activity.

## Analysis Performed

### 1. Database Exploration

* Examined the available tables and views.
* Identified the data fields and relationships relevant to the analysis.
* Reviewed the scope and time coverage of the sales data.
* Explored geographical spread of customers and sales

### 2. Customer Exploration

* Counted customers and examined demographic characteristics.
* Identified the oldest and youngest recorded customer birthdates and calculated ages.
* Explored order frequency to identify customers who placed only one order.

### 3. Product Exploration

* Counted available products, including by category and subcategory.
* Examined product attributes and classifications.
* Explored the distribution of products across relevant categories and subcategories.

### 4. Sales Exploration

* Examined the first and last order dates.
* Found average selling prices, items sold, total number of orders and other pertinent sales information.
* Calculated the time span represented by the sales data.
* Explored order activity and basic sales metrics.

## Key SQL Skills Demonstrated

* Aggregate functions: 'COUNT()', 'SUM()', 'MIN()', and 'MAX()'
* Grouping and filtering: 'GROUP BY', 'ORDER BY', 'WHERE', and 'HAVING'
* Joining related datasets using LEFT JOIN, UNION ALL
* Subqueries and derived tables
* Window functions, including 'ROW_NUMBER()' and aggregate window calculations
* Date calculations and date functions
* Conditional logic using 'CASE'
* Distinct counts and customer-level metrics

## Project Outcomes

This project demonstrates how SQL can be used to investigate a business dataset, summarize its key characteristics, and answer foundational questions about customers, products, and sales.

The exploratory analysis also establishes a starting point for more focused analytics, including customer segmentation, product performance, and changes in sales over time.

## Key Findings
>```text
> Sales Coverage
>The sales dataset covers approximately 4 years, from 12/29/2010 through 01/28/2014.
>
> Customer Base
>The customer base includes 18484 unique customers and the product catalog contains 295 products.
>Most customers are located in 6 countries - USA, Australia, Canada, Germany, United Kingdom, and France.
>The customer population ranges from 40 to 110 years old.
>
>Product catalog
>There are 295 distinct products in the catalog with an approximate average price of $486.
>
>Customer Purchasing Behavior
>Overwhelmingly, the most popular category of product sales are mountain bikes.
>Total sales overall equal $29,356,250, encompassing 27659 orders.
>```

## Next Steps

The next stage of the portfolio will build on this foundation through more targeted customer and product reporting, including:

* Changes-over-time analysis
* Cumulative sales analysis
* Product and customer performance analysis
* Part-to-whole analysis
* Customer segmentation

These analyses will move beyond describing the dataset toward evaluating business performance and identifying actionable patterns.


## Repository Structure

> [!NOTE]
>```text
>exploratory-data-analysis/
>├── scripts/
>│   └── exploratory_data_analysis.sql
>└── README.md
>```


