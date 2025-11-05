USE ass3_schema

#create table for Customers
CREATE TABLE Customers (
customer_id INT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
loyalty_points DECIMAL(10, 2) NOT NULL,
registration_date DATE,
age DECIMAL(10, 2) NOT NULL
);

#Create table for Transactions
CREATE TABLE Transactions (
transaction_id INT PRIMARY KEY,
customer_id INT,
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
amount_spent DECIMAL(10, 2) NOT NULL,
transaction_date DATE
);

#Create table for Products
CREATE TABLE Products (
product_id INT PRIMARY KEY,
product_name VARCHAR(100) NOT NULL,
price DECIMAL(10, 2) NOT NULL,
category VARCHAR(100) NOT NULL
);

#Insert data in the Customers Table
INSERT INTO Customers (customer_id, name, loyalty_points, registration_date, age)
VALUES
(101, 'Shehu Salihu', 150, '2019-05-15', 35),
(201, 'Adman Salihu', 200, '2020-06-20', 42),
(305, 'Agnes Pam', 300, '2018-08-10', 29),
(405, 'Esther James', 120, '2022-01-15', 50),
(509, 'Larry Adams', 250, '2021-10-12', 32);

#Insert data in the Transactions Table
INSERT INTO Transactions (transaction_id, customer_id, amount_spent, transaction_date)
VALUES
(1, 101, 100, '2023-05-10'),
(2, 201, 200, '2023-05-11'),
(3, 305, 300, '2023-05-12'),
(4, 405, 400, '2023-05-13'),
(5, 509, 150, '2023-05-14'),
(6, 305, 500, '2023-05-15');

#Insert data in the Products  Table
INSERT INTO Products  (product_id, product_name, price, category)
VALUES
(102, 'Laptop', 200000, 'Electronics'),
(201, 'Smartphone', 500000, 'Electronics'),
(203, 'Blender', 120000, 'Home Appliance'),
(104, 'Sofa', 450000, 'Furniture'),
(107, 'Desk Lamp', 350000, 'Furniture');


#The total amount spent by customers below 40 years old.
SELECT c.age,
	        SUM(CASE WHEN t.amount_spent <= 40 THEN t.amount_spent ELSE 0 END) AS low
FROM Customers c
JOIN Transactions t
ON c.customer_id = t.customer_id 
GROUP BY c.age;

#Create an index on the transaction_date column in the Transactions table.
CREATE INDEX idx_transaction_id ON Transactions(transaction_id);
SELECT *
FROM Transactions
WHERE transaction_id = 3;

# A query to display the total sales (amount_spent) and the number of transactions for each customer. • Use the GROUP BY clause.
SELECT c.customer_id, c.name AS CustomerName,
    SUM(t.amount_spent) AS Total_Sales,
    COUNT(t.transaction_id) AS Number_of_Transactions
FROM Transactions t
JOIN Customers c ON t.customer_id = c.customer_id
GROUP BY c.customer_id, c.name;