# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_project_p1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sql_project_p1`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Category Names** : Names of the categories available 
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql

SELECT COUNT(*) AS total_sale 
FROM retail_sales;

SELECT COUNT(DISTINCT customer_id) AS customers 
FROM retail_sales;

SELECT COUNT(DISTINCT category) FROM retail_sales;

SELECT DISTINCT category FROM retail_sales;

SELECT * 
FROM retail_sales
WHERE 
transactions_id IS NULL
OR 
sale_date  IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
OR
gender	IS NULL
OR
age IS NULL
OR
category IS NULL
OR
quantiy IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL


DELETE FROM retail_sales
WHERE 
transactions_id IS NULL
OR 
sale_date  IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
OR
gender	IS NULL
OR
age IS NULL
OR
category IS NULL
OR
quantiy IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL

```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql

  SELECT * 
  FROM 
  retail_sales
  WHERE sale_date = '2022-11-05';


```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT *
FROM retail_sales
WHERE 
 category= 'Clothing' 
 AND 
 sale_date>='2022-11-01'
 AND
 sale_date<'2022-12-01'
 AND 
 quantiy>='4';
```

 --Q3 WRITE A SQL QUERY TO CALCULATE TOTAL SALES FOR EACH CATEGORY 

 ```sql
 SELECT
 category ,
 SUM(total_sale)
 AS TOTAL_SALES
 FROM 
 retail_sales 
 GROUP BY
 category;
```


 --Q4  WRITE A SQL QUERY TO FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM 'BEAUTY' CATEGORY 
```sql
 SELECT
 category,AVG(age) AS average_age
 FROM
 retail_sales
 WHERE 
 category='Beauty'
 GROUP BY category;
```

 --Q5 WRITE A SQL QUERY TO FIND ALL TRANSACTIONS WHERE total_sale IS GREATER THAN 1000

```sql
 SELECT * FROM retail_sales
 WHERE total_sale>1000;
```

 --Q6 WRITE A SQL QUERY TO FIND THE TOTAL NUMBER OF TRANSACTIONS (transaction_id) MADE BY EACH GENDER IN EACH CATEGORY

```sql
 SELECT 
 category,
 gender,count(transactions_id)
 FROM 
 retail_sales
 GROUP BY 
 category ,
 gender;
```

 --Q7 WRITE A SQL QUERY TO CALCULATE THE AVERAGE SALE FOR EACH MONTH , FIND OUT BEST SELLING MONTH IN EACH YEAR		
  
 ```sql
 WITH monthly_avg AS (
    SELECT
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sales
    FROM retail_sales
    GROUP BY
        YEAR(sale_date),
        MONTH(sale_date)
),
ranked_data AS (
    SELECT
        year,
        month,
        avg_sales,
        RANK() OVER (PARTITION BY year ORDER BY avg_sales DESC) AS rnk
    FROM monthly_avg
)

SELECT *
FROM ranked_data
WHERE rnk = 1;

```
--Q8 WRITE A SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON THE HIGHEST TOTAL SALES

```sql

SELECT TOP 5
  customer_id,
  SUM(total_sale) AS totalsale
FROM retail_sales
GROUP BY customer_id
ORDER BY totalsale DESC;

```
--Q9 WRITE A SQL QUERY TO FIND NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY 


```sql
SELECT count( DISTINCT customer_id) AS no_of_customers,category 
FROM retail_sales
GROUP BY category;
```
 
 --Q10 WRITE A SQL QUERY TO CREATE EACH  SHIFT AND NUMBER OF ORDERS( EXAMPLE MORNING <=12, AFTERNOON BETWEEN 12 AND 17, EVENING >17)
 ```sql
 WITH hourly_sales AS
 (
 SELECT * ,
 CASE 
 WHEN DATEPART(HOUR ,sale_time)<=12 THEN 'Morning'
 WHEN DATEPART (HOUR,sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
 ELSE 'Evening'
 END AS shift 
 FROM retail_sales
)

SELECT
shift,
count(*) AS TOTAL_0RDERS
FROM hourly_sales
GROUP BY shift;

```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Run the Queries**: Use the SQL queries provided in the `SQLQuery.sql` file to perform your analysis.
3. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.


