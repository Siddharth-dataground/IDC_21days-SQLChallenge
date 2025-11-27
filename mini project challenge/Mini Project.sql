CREATE DATABASE IDC_Pizza;
USE IDC_Pizza;

-- 1. Create the pizza_types table (No Foreign Keys)
CREATE TABLE pizza_types (
    pizza_type_id VARCHAR(50) PRIMARY KEY, -- e.g., 'bbq_ckn'
    name VARCHAR(100),                      -- e.g., 'The Barbecue Chicken Pizza'
    category VARCHAR(50),                   -- e.g., 'Chicken'
    ingredients TEXT                        -- e.g., 'Barbecued Chicken, Red Peppers, ...'
);

-- 2. Create the pizzas table (FK to pizza_types)
CREATE TABLE pizzas (
    pizza_id VARCHAR(50) PRIMARY KEY,   -- e.g., 'bbq_ckn_s'
    pizza_type_id VARCHAR(50) REFERENCES pizza_types(pizza_type_id),
    size VARCHAR(10),                   -- e.g., 'S', 'M', 'L'
    price NUMERIC(5, 2)                 -- e.g., 12.75
);

-- 3. Create the orders table (No Foreign Keys)

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    date DATE,
    time TIME
);

-- 4. Create the order_details table (FK to orders and pizzas)
CREATE TABLE order_details (
    order_details_id INT PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    pizza_id VARCHAR(50) REFERENCES pizzas(pizza_id),
    quantity INT
);


SHOW TABLES;


-- To load the data details faster this way for order_details

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE '/Users/siddharthshreekumar/Downloads/order_details.csv'
INTO TABLE order_details
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Rest CSV files loaded using table import wizard
-- --------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------

-- Lets check all tables and column types.
SELECT * FROM order_details;
DESC order_details;

SELECT * FROM orders;
DESC orders;

SELECT * FROM pizzas;
DESC pizzas;

SELECT * FROM pizza_types;
DESC pizza_types;


-- ------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------

-- Phase 1: Foundation & Inspection
-- List all unique pizza categories (DISTINCT).

SELECT 
DISTINCT `category` 
FROM pizza_types;

-- SO in our brand there are 4 unique types: [ 'Chicken', 'Classic', 'Supreme', 'Veggie' ]


-- Display pizza_type_id, name, and ingredients, replacing NULL ingredients with "Missing Data". Show first 5 rows.

SELECT 
`pizza_type_id`,`name`,
IFNULL(`ingredients`, 'Missing data') AS 'ingredients'
FROM pizza_types
LIMIT 5;

-- Also our data maintained well as there are no missing data in Ingredients. 
-- anaother way we can say standard SOP (standard operation procedure) maintained properly.

-- Check for pizzas missing a price (IS NULL).
SELECT 
* 
FROM 
pizzas 
WHERE `price` IS NULL;


-- It means also price tag is not missing for any pizza, that means it will ok from operation point of view.

-- -----------------------------------------------------------------------------------------------------------------------
-- Phase 2: Filtering & Exploration
-- Orders placed on '2015-01-01' (SELECT + WHERE).

SELECT * FROM orders
WHERE `date` = '2015-01-01';

-- We all know how exciting is NEW year, and there total 69 orders on that day only.

-- List pizzas with price in descending order.

SELECT 
`name`, `size`, `price`
FROM
pizzas
INNER JOIN
pizza_types 
USING (`pizza_type_id`)
ORDER BY `price` DESC;

-- Pizzas sold in sizes 'L' or 'XL'. Show the names and size in output

SELECT pt.`name`, p.`size`
FROM pizzas AS p
RIGHT JOIN pizza_types AS pt
USING (`pizza_type_id`)
WHERE `size` IN ('L','XL');


-- Pizzas priced between $15.00 and $17.00.

SELECT 
pt.`name`, p.`size`
FROM
pizzas AS p
INNER JOIN
pizza_types AS pt USING (`pizza_type_id`)
WHERE
`price` BETWEEN 15.00 AND 17.00;

-- Pizzas with "Chicken" in the name.

SELECT DISTINCT `name` 
FROM pizza_types
WHERE `name` LIKE '%Chicken%';

-- Orders on '2015-02-15' or placed after 8 PM.

SELECT 
* 
FROM orders 
WHERE `date` = '2015-02-12' OR `time` >'8:00:00';

-- ------------------------------------------------------------------------------------------------------------------------
-- Phase 3: Sales Performance
-- Total quantity of pizzas sold (SUM).

SELECT 
SUM(`quantity`) AS 'Total Quantty' 
FROM order_details;

-- Average pizza price (AVG).

SELECT 
ROUND(AVG(`price`),2) AS 'avg_pizza_price' 
FROM pizzas;

-- Total order value per order (`JOIN`, `SUM`, `GROUP BY`).
-- per order we want to know how much quantity, and price

SELECT
o.`order_id`,
SUM(o.`quantity`*p.`price`) AS 'order value'
FROM
order_details as o
INNER JOIN
pizzas AS p
USING(pizza_id)
GROUP BY order_id
ORDER BY order_id;

-- Total quantity sold per pizza category (JOIN, GROUP BY)
-- WE CAN do the below by multiple join at once but that will increase time

WITH t1 AS
( -- This CTE will pizza_type_id wise quantity
-- I did this CTE to reduce row before joining, so that it can be faster.
SELECT
`pizza_type_id`, SUM(`quantity`) AS 't_quantity'
FROM
pizzas
INNER JOIN
order_details 
USING (pizza_id)
GROUP BY `pizza_type_id`
)
SELECT `category`, SUM(`t_quantity`) AS 'Total quantity'
FROM t1
INNER JOIN
pizza_types
USING(`pizza_type_id`)
GROUP BY `category`;

-- Categories with more than 5,000 pizzas sold (HAVING).
WITH t1 AS
(
SELECT
`pizza_type_id`, SUM(`quantity`) AS 't_quantity'
FROM
pizzas
INNER JOIN
order_details 
USING (pizza_id)
GROUP BY `pizza_type_id`
)
SELECT `category`, SUM(`t_quantity`) AS 'Total quantity'
FROM t1
INNER JOIN
pizza_types
USING(`pizza_type_id`)
GROUP BY `category`
HAVING `Total quantity` >5000;

-- Pizzas never ordered (LEFT/RIGHT JOIN).

SELECT `name` FROM pizza_types WHERE pizza_type_id IN 
(
SELECT 
`pizza_type_id`
FROM
pizzas
LEFT JOIN
order_details
USING(`pizza_id`)
WHERE `order_details_id` IS NULL);

-- Price differences between different sizes of the same pizza (SELF JOIN).

SELECT 
p1.`pizza_type_id`, p1.`size` AS 'Size 1', p1.`price` AS 'Price for size 1', 
p2.`size` AS 'Size 2',p2.`price` AS 'Price for size 1',
(p2.`price` - p1.`price`) AS 'Difference (Size 2 - Size 1'
FROM 
pizzas AS p1
CROSS JOIN
pizzas AS p2
USING(pizza_type_id)
WHERE p1.`size` != p2.`size` AND p1.`size` = 's'
ORDER BY p1.pizza_type_id, p1.size;


-- Day wise  total quantity pizza sold,total orders placed

SELECT 
o.`date`, SUM(od.`quantity`)  AS 'Total_quantity', COUNT(DISTINCT o.`order_id`) AS 'Total Orders'
FROM
orders AS o
INNER JOIN
order_details AS od
USING (order_id)
GROUP BY o.`date`
ORDER BY `date` ASC;


-- Which Price range have more quantity of pizza ordered

SELECT 
DISTINCT p.`price`, SUM(od.`quantity`) AS 'Total no. of Pizza'
FROM pizzas AS p
INNER JOIN
order_details AS od
USING(`pizza_id`)
GROUP BY `price`
ORDER BY `Total no. of Pizza` DESC;


-- Month on month total sales

WITH temp AS 
( -- order_id wise total sales.
-- This CTE I made to minimize the rows so that join will faster further 
SELECT
od.`order_id`, SUM(od.`quantity`*p.`price`) AS 'Total Sales'
FROM
order_details AS od
INNER JOIN
pizzas AS p
USING(`pizza_id`)
GROUP BY od.`order_id`
)
SELECT
MONTH(o.`date`) AS 'Month' , SUM(t.`Total Sales`) AS 'Total Sales'
FROM 
temp  AS t
INNER JOIN 
orders AS o
USING(`order_id`)
GROUP BY MONTH(o.`date`)
ORDER BY `Month`;
