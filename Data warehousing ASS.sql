-- Data warehousing is a centralized location for storing vast amount of data

##Write an SQL View that retrieves customers who have spent more than 300,000 Naira in total purchases.
USE datawarehousing
## Import Customer Table
CREATE TABLE customers (
	customer_id INT PRIMARY KEY,
	name VARCHAR(100),
	location VARCHAR(100),
	age DECIMAL(10, 2),
	gender VARCHAR(100)
);

## Insert values into customer table
INSERT INTO customers (customer_id, name, location, age, gender)
VALUES
(1, 'John Doe', 'Lagos', 30, 'Male'),
(2, 'Jane Smith', 'Abuja', 28, 'Female'),
(3, 'Peter Adams', 'Port Harcourt', 4, 'Male'),
(4, 'Sarah Johnson', 'Kano', 35, 'Female');

##insert Product table
CREATE TABLE products (
	product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(100),
    price DECIMAL(10, 2)
);

## Insert values into product table
INSERT INTO products (product_id, product_name, category, price)
VALUES
(101, 'Laptop', 'Electronics', 350000),
(102, 'Phone', 'Electronics', 150000),
(103, 'Printer', 'Office', 85000);

#Insert sales table
CREATE TABLE sales (
	sale_id INT PRIMARY KEY,
    total_amount DECIMAL(10, 2),
    sales_date DATE,
    quantity DECIMAL(10, 2),
    customer_id INT,
    product_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
	FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO sales (sale_id, total_amount, sales_date, quantity, customer_id, product_id)
VALUES
(5001, 350000, '2024-01-10', 1, 1, 101),
(5002, 300000, '2024-02-15', 2, 2, 102),
(5003, 85000, '2024-03-20', 1, 3, 103),
(5004, 350000, '2024-03-25', 1, 4, 101);

## Write an SQL View that retrieves customers who have spent more than 300,000 Naira in total purchases.
SELECT DISTINCT c.customer_id, c.name 
FROM customers c
JOIN sales s
ON c.customer_id = s.customer_id
WHERE s.total_amount > 300000;

SELECT *
FROM sales;



## Create a Materialized View that summarizes total sales per month
## Create the sales_summary table
CREATE TABLE sales_summary (
	customer_id INT PRIMARY KEY, 
    total_amount DECIMAL(10, 2),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

## Create a procedure to refresh the materialized view

DELIMITER $$

CREATE PROCEDURE refresh_materialized_view ()
BEGIN

	REPLACE INTO sales_summary (customer_id, total_amount)
    SELECT customer_id, sum(total_amount)
    FROM sales s
    WHERE customer_id IS NOT NULL
    GROUP BY customer_id;
END $$
DELIMITER ;

CALL refresh_materialized_view();
SELECT * FROM sales_summary;

## Write a stored procedure called update_product_price that increases the price of Phones by 10%.
DELIMITER $$
CREATE PROCEDURE update_product_price()
BEGIN
	UPDATE products
    SET price = price * 1.10
    WHERE product_name ='Phone';
END $$
DELIMITER ;
