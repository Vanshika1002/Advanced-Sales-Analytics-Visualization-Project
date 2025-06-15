-- Create the database
CREATE DATABASE IF NOT EXISTS sn_corporation;
USE sn_corporation;

-- Create the orders table
CREATE TABLE IF NOT EXISTS list_of_orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_name VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100),
    state VARCHAR(100),
    region VARCHAR(50),
    segment VARCHAR(50),
    ship_mode VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(200),
    cost INT,
    sales INT,
    profit INT,
    quantity INT
);
SELECT * FROM list_of_orders LIMIT 10;

-- Q1: What is the average sales per order?
SELECT AVG(sales) AS avg_sales_per_order 
FROM list_of_orders;

-- Q2: Which product category generates highest sales?
SELECT category, SUM(sales) AS total_sales
FROM list_of_orders
GROUP BY category
ORDER BY total_sales DESC;

-- Q3: Which region contributes the most to sales?
SELECT region, SUM(sales) AS total_sales
FROM list_of_orders
GROUP BY region
ORDER BY total_sales DESC;

-- Q4: Who are the top 5 customers by sales?
SELECT customer_name, SUM(sales) AS total_sales
FROM list_of_orders
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 5;

-- Q5: What is the overall profit margin percentage?
SELECT (SUM(profit)/SUM(sales))*100 AS profit_margin_percentage 
FROM list_of_orders;

-- Q6: Which orders resulted in losses?
SELECT * 
FROM list_of_orders 
WHERE profit < 0;

-- Q7: Customers who bought same product multiple times
SELECT customer_name, product_name, COUNT(*) AS purchase_count
FROM list_of_orders
GROUP BY customer_name, product_name
HAVING COUNT(*) > 1
ORDER BY purchase_count DESC;

-- Q8: Product pairs bought together in same order
SELECT a.order_id, a.product_name AS product_1, b.product_name AS product_2
FROM list_of_orders a
JOIN list_of_orders b 
ON a.order_id = b.order_id 
AND a.product_name < b.product_name
ORDER BY a.order_id
LIMIT 100;

-- Q9: Customer who generated highest profit
SELECT customer_name, SUM(profit) AS total_profit
FROM list_of_orders
GROUP BY customer_name
ORDER BY total_profit DESC
LIMIT 1;

-- Q10: What is the year-wise sales growth?
SELECT YEAR(order_date) AS year, SUM(sales) AS total_sales
FROM list_of_orders
GROUP BY year
ORDER BY year;


