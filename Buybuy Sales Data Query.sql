FOLLOW THE FOLLOWING STEPS TO COPY YOUR DATASETS INTO YOUR PGADMIN

/* STEP 1: Create a new database for your company */
CREATE DATABASE Buybuy_company;


/* STEP 2: Execute the following code to create a new table in your database */
CREATE TABLE sales_data (
    sales_date date,
    sales_year varchar,
    cus_id varchar,
	cus_age int,
    cus_gender varchar,
    cus_country text,
    cus_state text,
    prod_category varchar,
    prod_subcategory varchar,
    product varchar,
    ord_quantity int,
    unit_cost int,
    unit_price int,
    cost int,
    revenue int
    );


/* STEP 3: Execute the following code to copy CSV data into your database */
COPY sales_data 
FROM 'D:\DATASETS\CompanyX_sales_dataset.csv'
DELIMITER ',' CSV 
HEADER;

/* STEP 4:Execute the following code to display the newly imported data in your database */
SELECT *
FROM sales_data;

/* Time-Profit Analysis: 
a. Query to calculate the total profit made by BuyBuy from 1Q11 to 4Q16 
(all quarters of every year): */
SELECT SUM(revenue - cost) AS total_profit
FROM sales_data
WHERE sales_year >= '2011' AND sales_year <= '2016';

/* b. Queries to calculate the total profit made by BuyBuy in Q2 of every year from 2011 to 2016: */
SELECT sales_year, SUM(revenue - cost) AS q2_profit
FROM sales_data
WHERE sales_date >= '2011-04-01' AND sales_date <= '2016-06-30'
GROUP BY sales_year;

/* c. Query to calculate the annual profit made by BuyBuy from the year 2011 to 2016: */
SELECT sales_year, SUM(revenue - cost) AS annual_profit
FROM sales_data
WHERE sales_year >= '2011' AND sales_year <= '2016'
GROUP BY sales_year;

/* To create a chart visualising the data from the analysis in 1(b), 
which is the total profit made by BuyBuy in Q2 of every year from 2011 to 2016 */
SELECT EXTRACT(YEAR FROM sales_date) AS year, SUM(revenue - cost) AS profit
FROM sales_data
WHERE EXTRACT(QUARTER FROM sales_date) = 2 AND EXTRACT(YEAR FROM sales_date) BETWEEN 2011 AND 2016
GROUP BY year
ORDER BY year;

/* Region-Profit Analysis:
a. Queries to return the countries where BuyBuy has made the most and least profit of all time: */
SELECT cus_country, SUM(revenue - cost) AS total_profit
FROM sales_data
GROUP BY cus_country
ORDER BY total_profit DESC
LIMIT 1; -- Most profitable country

SELECT cus_country, SUM(revenue - cost) AS total_profit
FROM sales_data
GROUP BY cus_country
ORDER BY total_profit ASC
LIMIT 1; -- Least profitable country

/* b. Query to show the top 10 most profitable countries for BuyBuy sales operations from 2011 to 2016: */
SELECT cus_country, SUM(revenue - cost) AS total_profit
FROM sales_data
WHERE sales_year >= '2011' AND sales_year <= '2016'
GROUP BY cus_country
ORDER BY total_profit DESC
LIMIT 10;

/* c. Query to show the all-time top 10 least profitable countries for BuyBuy sales operations: */
SELECT cus_country, SUM(revenue - cost) AS total_profit
FROM sales_data
GROUP BY cus_country
ORDER BY total_profit ASC
LIMIT 10;

/* a chart to visualize the top 10 most profitable countries (2(b)) */
SELECT cus_country, SUM(revenue - cost) AS profit
FROM sales_data
WHERE EXTRACT(YEAR FROM sales_date) BETWEEN 2011 AND 2016
GROUP BY cus_country
ORDER BY profit DESC
LIMIT 10;

/* Product-Revenue Analysis:
a. Query to rank all product categories sold by BuyBuy based on the all-time revenue generated: */
SELECT prod_category, SUM(revenue) AS total_revenue
FROM sales_data
GROUP BY prod_category
ORDER BY total_revenue;

/* b. Query to return the top 2 product categories offered by BuyBuy with the highest number of units sold: */
SELECT prod_category, SUM(ord_quantity) AS total_units_sold
FROM sales_data
GROUP BY prod_category
ORDER BY total_units_sold DESC
LIMIT 2;

/* c. Query to show the top 10 highest-grossing products sold by BuyBuy based on all-time profits: */
SELECT product, SUM(revenue - cost) AS total_profit
FROM sales_data
GROUP BY product
ORDER BY total_profit DESC
LIMIT 10;

/* d. Creating a chart to visualize the top 2 product categories with the highest number of units sold (3(b)): */
SELECT prod_category, SUM(ord_quantity) AS total_units_sold
FROM sales_data
GROUP BY prod_category
ORDER BY total_units_sold DESC
LIMIT 2;

