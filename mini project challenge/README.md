# The Great Pizza Analytics Challenge

### Welcome to the **Great Pizza Analytics Challenge**!

Think as a data analyst for **IDC Pizza**, tasked with transforming raw pizza sales data into actionable insights.

Our goal is to answer a series of questions **using SQL**

- Database creation & table design
- Filtering & operators (`WHERE`, `IN`, `BETWEEN`, `LIKE`, `AND/OR/NOT`)
- Aggregations (`SUM`, `AVG`, `COUNT`, `MIN`, `MAX`, `GROUP BY`, `HAVING`)
- Joins (`INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL OUTER JOIN`, `SELF JOIN`)
- Data cleaning (`DISTINCT`, `COALESCE`, handling NULLs)
-------------------------------------------------------------------------------------------------------------------------------------------------
## Source Information
There are 4 files which we are going to use
1. pizzas.csv[link](./pizzas.csv)
2. pizza_types_fixed.csv[link](./pizza_types_fixed.csv)
3. orders.csv[link](./orders.csv)
4. order_details.csv[link](./order_details.csv)

-------------------------------------------------------------------------------------------------------------------------------------------------
## Database creation and table Loading
Create a database and tables by running the attached code in your MySQL Workbench.[Link](./Mini%20Project_table%20creation.sql)</br>
Once the above step is complete, load the above data using the **Table Import Wizard**.

But order_details.csv may not load because it's a large file. Load it using the syntax below:

SET GLOBAL local_infile = 1;</br>

LOAD DATA LOCAL INFILE '[Filepath>]'</br>
INTO TABLE [table_name]</br>
CHARACTER SET utf8mb4</br>
FIELDS TERMINATED BY ','</br>
OPTIONALLY ENCLOSED BY '"'</br>
LINES TERMINATED BY '\n'</br>
IGNORE 1 LINES;

-------------------------------------------------------------------------------------------------------------------------------------------------

## Questions

**Phase 1: Foundation & Inspection**

1. List all unique pizza categories (`DISTINCT`).
2. Display `pizza_type_id`, `name`, and ingredients, replacing NULL ingredients with `"Missing Data"`. Show first 5 rows.
3. Check for pizzas missing a price (`IS NULL`).

**Phase 2: Filtering & Exploration**

1. Orders placed on `'2015-01-01'`.
2. List pizzas with `price` descending.
3. Pizzas sold in sizes `'L'` or `'XL'`.
4. Pizzas priced between $15.00 and $17.00.
5. Pizzas with `"Chicken"` in the name.
6. Orders on `'2015-02-15'` or placed after 8 PM.

**Phase 3: Sales Performance**

1. Total quantity of pizzas sold.
2. Average pizza price.
3. Total order value per order.
4. Total quantity sold per pizza category.
5. Categories with more than 5,000 pizzas sold.
6. Pizzas were never ordered.
7. Price differences between different sizes of the same pizza.

**Add on**
1. Day-wise total quantity of pizza sold, total orders placed
2. Price range-wise, the quantity of pizza ordered
3. Month-on-month total sales
