-- Create database 
CREATE DATABASE IF NOT EXISTS amazon_online_sales;


-- Create amazon_sales table
CREATE TABLE IF NOT EXISTS amazon_sales (
    Order_id VARCHAR(30) NOT NULL PRIMARY KEY,
    date DATETIME NOT NULL,
    quantity INT NOT NULL,
    amount FLOAT NOT NULL,
    sales_channel VARCHAR(50) NOT NULL,
    B2B BOOLEAN NOT NULL
);

-- Create second table of the database
CREATE TABLE IF NOT EXISTS amazon_product (
    Order_id VARCHAR(30) NOT NULL PRIMARY KEY,
    category VARCHAR(30) NOT NULL,
    size VARCHAR(30) NOT NULL,
    style VARCHAR(30) NOT NULL,
    fulfilment VARCHAR(30) NOT NULL,
    asin VARCHAR(30) NOT NULL
);

-- Create third table of the database
CREATE TABLE IF NOT EXISTS amazon_shipping (
    Order_id VARCHAR(20) NOT NULL PRIMARY KEY,
    order_status VARCHAR(200) NOT NULL,
    ship_service VARCHAR(200) NOT NULL,
    ship_city VARCHAR(200) NOT NULL,
    ship_state VARCHAR(200) NOT NULL,
    zipcode VARCHAR(30) NOT NULL
);
-- ---------------------- Adding Necessary Columns -------------------------------------



-- Add the revenue column to  amazon_sales table 
ALTER TABLE amazon_sales ADD COLUMN revenue DECIMAL(12,2);

UPDATE amazon_sales
SET revenue = quantity * amount;


-- Add the year column to  amazon_sales table 
ALTER TABLE amazon_sales ADD COLUMN year VARCHAR(4);

UPDATE amazon_sales
SET year= year(date);

-- Add the month column to  amazon_sales table 
ALTER TABLE amazon_sales ADD COLUMN calendar_month VARCHAR(10);

UPDATE amazon_sales
SET calendar_month = MONTHNAME(date);

-- ----------------------------- Product Analysis-------------------------------------------
-- 1. What is the total revenue, total quantify sold, and average revenue?
SELECT 
    SUM(s.revenue) AS Total_Revenue,
    SUM(s.quantity) AS Total_Quantity,
    AVG(s.revenue) AS Average_Revenue
FROM
    amazon_online_sales.amazon_sales s
        JOIN
    amazon_online_sales.amazon_product p ON s.Order_id = p.Order_id
        JOIN
    amazon_online_sales.amazon_shipping d ON s.Order_id = d.Order_id;


-- 2. What are the top 5 best-selling product categories overall?
SELECT 
    p.category, SUM(s.quantity) AS total_sold, sum(s.revenue)

FROM
    amazon_online_sales.amazon_sales s
        JOIN
        
        
    amazon_online_sales.amazon_product p ON s.Order_id = p.Order_id
GROUP BY p.category
ORDER BY total_sold DESC;

-- 3. Can you identify any trends in the sales of products?
SELECT 
    s.calendar_month, p.category, SUM(s.quantity) AS total_sold
FROM
    amazon_online_sales.amazon_sales s
        JOIN
    amazon_online_sales.amazon_product p ON p.Order_id = s.Order_id
GROUP BY p.category , s.calendar_month
ORDER BY p.category , total_sold DESC;

-- 4. Which product categories generate the highest revenue?

SELECT 
    p.category, SUM(s.revenue) AS total_revenue
FROM
    amazon_online_sales.amazon_sales s
        JOIN
    amazon_online_sales.amazon_product p ON p.Order_id = s.Order_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- 5. Are there any product categories that are consistently underperforming?
-- total_revenue below average revenue is the metric we will use to measure under performance.
SELECT 
    s.calendar_month, p.category, SUM(s.revenue) AS total_revenue
FROM
    amazon_online_sales.amazon_sales s
        JOIN
    amazon_online_sales.amazon_product p ON p.Order_id = s.Order_id
GROUP BY p.category, s.calendar_month
HAVING SUM(s.revenue) < (SELECT 
        AVG(s.revenue)
    FROM
        amazon_online_sales.amazon_sales s)
ORDER BY total_revenue;


-- The above query returns product categories that have total revenue  below average in each month.
-- To see the numbers per month for each product category, we run the query below

SELECT 
    s.calendar_month,
    p.category,
    SUM(s.revenue) AS total_revenue
FROM
    amazon_online_sales.amazon_sales s
        JOIN
    amazon_online_sales.amazon_product p ON p.Order_id = s.Order_id
GROUP BY p.category , s.calendar_month
ORDER BY CASE s.calendar_month
    WHEN 'March' THEN 1
    WHEN 'April' THEN 2
    WHEN 'May' THEN 3
    ELSE 4
END;


-- 6. Do certain product sizes sell better than others?

SELECT 
    p.size, SUM(s.quantity) AS total_sold
FROM
    amazon_online_sales.amazon_sales s
        JOIN
    amazon_online_sales.amazon_product p ON p.Order_id = s.Order_id
GROUP BY p.size
ORDER BY total_sold DESC;

-- 7. Are there any correlations between product size and revenue?

SELECT 
    p.size, SUM(s.revenue) AS total_revenue
FROM
    amazon_online_sales.amazon_sales s
        JOIN
    amazon_online_sales.amazon_product p ON p.Order_id = s.Order_id
GROUP BY p.size
ORDER BY total_revenue DESC;

-- 8. Which is the most prefered fulfilment?

SELECT 
    p.fulfilment,
    COUNT(*) AS total_orders,
    ROUND(COUNT(*) * 100.0 / (SELECT 
                    COUNT(*)
                FROM
                    amazon_online_sales.amazon_shipping),
            2) AS percentage
FROM
    amazon_online_sales.amazon_shipping d
        JOIN
    amazon_online_sales.amazon_product p ON d.Order_id = p.Order_id
GROUP BY p.fulfilment;



-- --------------------------- Sales Analysis -----------------------------------------------

-- 1. Is there a significant difference in revenue between B2B and B2C sales?

SELECT 
    s.B2B, SUM(revenue) AS total_revenue
FROM
    amazon_online_sales.amazon_sales s
GROUP BY s.B2B;

-- 2. Are there any trends or patterns in order quantity over time?

SELECT 
    s.date, SUM(s.quantity) AS total_quantity
FROM
    amazon_online_sales.amazon_sales s
GROUP BY date
ORDER BY date;

-- 3. How has revenue changed over time?

SELECT 
    s.date, SUM(s.revenue) AS total_revenue
FROM
    amazon_online_sales.amazon_sales s
GROUP BY date
ORDER BY date;

-- --------------------------- Shipping Analysis ---------------------------------------------

-- 1. What are the frequencies of the items in  order status per month?

SELECT 
    d.order_status,
    COUNT(*) AS status_count
FROM 
    amazon_online_sales.amazon_shipping d 
GROUP BY 
    d.order_status
ORDER BY 
    d.order_status;


-- 2. Which cities/states have the highest number of orders?

SELECT 
    d.ship_city, d.ship_state, COUNT(*) AS total_orders
FROM
    amazon_online_sales.amazon_shipping d
        JOIN
    amazon_online_sales.amazon_sales s ON d.Order_id = s.Order_id
GROUP BY d.ship_city , d.ship_state
ORDER BY total_orders DESC;


-- 3. What percentage of orders use different shipping services?

SELECT 
    ship_service,
    COUNT(*) AS total_orders,
    ROUND(COUNT(*) * 100.0 / (SELECT 
                    COUNT(*)
                FROM
                    amazon_online_sales.amazon_shipping),
            2) AS percentage
FROM
    amazon_online_sales.amazon_shipping 
GROUP BY ship_service;
