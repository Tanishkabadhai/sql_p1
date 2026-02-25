CREATE DATABASE sql_project_p1;

USE sql_project_p1;

-- CREATING TABLE
CREATE TABLE retail_sales(
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(20),
age INT,
category VARCHAR(20),
quantiy INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);

--DELETING NULL VALUES

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

-- DATA EXPLORATION


--	HOW MANY SALES DO WE HAVE ?
SELECT COUNT(*) AS total_sale 
FROM retail_sales;

--HOW MANY UNIQUE CUSTOMERS DO WE HAVE ?
SELECT COUNT(DISTINCT customer_id) AS customers 
FROM retail_sales;

--HOW MANY CATEGORIES DO WE HAVE ?
 SELECT COUNT(DISTINCT category) FROM retail_sales;

-- NAME OF THE CATEGORIES AVAILABLE 
 SELECT DISTINCT category FROM retail_sales;



 -- DATA ANALYSIS AND BUSINESS KEY PROBLEMS AND ANSWERS

  --Q1 WRITE A SQL QUERY TO RETRIVE ALL COLUMN FOR SALES MADE ON '2022-11-05'

  SELECT * 
  FROM retail_sales
  WHERE sale_date = '2022-11-05';


  --Q2 WRITE A SQL QUERY TO RETRIVE ALL  TRANSACTIONS WHERE CATEGORY IS CLOTHING AND QUANTITY SOLD IS MORE THAN OR EQUALS TO 4 IN MONTH OF NOV-2022?

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
  

 --Q3 WRITE A SQL QUERY TO CALCULATE TOTAL SALES FOR EACH CATEGORY 
 
 SELECT category ,SUM(total_sale)
 AS TOTAL_SALES
 FROM retail_sales 
 GROUP BY category;


 --Q4  WRITE A SQL QUERY TO FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM 'BEAUTY' CATEGORY 

 SELECT category,AVG(age) AS average_age
 FROM retail_sales
 WHERE category='Beauty'
 GROUP BY category;


 --Q5 WRITE A SQL QUERY TO FIND ALL TRANSACTIONS WHERE total_sale IS GREATER THAN 1000

 SELECT * FROM retail_sales
 WHERE total_sale>1000;


 --Q6 WRITE A SQL QUERY TO FIND THE TOTAL NUMBER OF TRANSACTIONS (transaction_id) MADE BY EACH GENDER IN EACH CATEGORY

 SELECT category,gender,count(transactions_id)
 FROM retail_sales
 GROUP BY category , gender;


 --Q7 WRITE A SQL QUERY TO CALCULATE THE AVERAGE SALE FOR EACH MONTH , FIND OUT BEST SELLING MONTH IN EACH YEAR		
  
 
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


--Q8 WRITE A SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON THE HIGHEST TOTAL SALES

SELECT TOP 5
  customer_id,
  SUM(total_sale) AS totalsale
FROM retail_sales
GROUP BY customer_id
ORDER BY totalsale DESC;


--Q9 WRITE A SQL QUERY TO FIND NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY 

SELECT count( DISTINCT customer_id) AS no_of_customers,category 
FROM retail_sales
GROUP BY category;

 
 --Q10 WRITE A SQL QUERY TO CREATE EACH  SHIFT AND NUMBER OF ORDERS( EXAMPLE MORNING <=12, AFTERNOON BETWEEN 12 AND 17, EVENING >17)
 
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


--END OF THE PROJECT