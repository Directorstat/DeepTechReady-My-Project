USE ass2_schema

#create table for Order 
CREATE TABLE Order_table (
OrderID INT PRIMARY KEY,
CustomerName VARCHAR(100) NOT NULL,
OrderDate DATE,
Product VARCHAR(50) NOT NULL,
Quantity DECIMAL(10, 2) NOT NULL,
Price DECIMAL(10, 2) NOT NULL,
State VARCHAR(50) NOT NULL
);

#Create Payments table
CREATE TABLE Payments (
PaymentID INT PRIMARY KEY,
OrderID INT,
FOREIGN KEY (OrderID) REFERENCES Order_table(OrderID),
PaymentDate DATE,
PaymentAmount DECIMAL(10, 2) NOT NULL,
PaymentMethod VARCHAR(50) NOT NULL
);

#Insert data in the Order table
INSERT INTO Order_table (OrderID, CustomerName, OrderDate, Product, Quantity, Price, State)
VALUES
(1, 'Gabriel Aliyu', '2023-01-15', 'Laptop', 2, 350000, 'Sokoto'),
(2, 'Brown Abu', '2023-02-10', 'Phone', 5, 250000, 'Cross River'),
(3, 'Janet Ugo', '2023-03-20', 'Tablet', 3, 700000, 'Imo'),
(4, 'Abi Jude', '2023-01-20', 'Phone', 1, 150000, 'Kogi'),
(5, 'Garba Shehu', '2023-04-05', 'Laptop', 1, 500000, 'Borno');

#Insert data in the Order table
INSERT INTO Payments (PaymentID, OrderID,PaymentDate, PaymentAmount, PaymentMethod)
VALUES
(101, 1, '2023-01-16', 700000, 'Card'),
(102, 2, '2023-02-11', 1250000, 'Cash'),
(103, 3, '2023-03-21', 2100000, 'Bank Transfer'),
(104, 4, '2023-01-21', 150000, 'Card'),
(105, 5, '2023-04-06', 500000, 'Cash');

#Calculate the total amount spent by each customer across orders, including the customer's name, and sort the result by the total amount using CTE
WITH OrderAmount AS (
    SELECT o.OrderID, o.CustomerName, SUM(p.PaymentAmount) AS TotalAmount
    FROM Payments p
	JOIN Order_table o 
    ON p.OrderID = o.OrderID
    GROUP BY o.OrderID, o.CustomerName
)
SELECT oa.CustomerName, oa.TotalAmount
FROM OrderAmount oa
ORDER BY oa.TotalAmount DESC;

##Use GROUPING SETS, ROLLUP, or CUBE to analyze the total revenue grouped by State and Product, and include subtotals for each state and product combination.
SELECT State, Product, SUM(Quantity * Price) AS Total_Revenue
FROM Order_table o
GROUP BY State, Product WITH ROLLUP;

##Extract the year and month from the OrderDate column in the Orders Table and display them as OrderYear and OrderMonth
SELECT OrderID, CustomerName, OrderDate,
    YEAR(OrderDate) AS OrderYear,
    MONTH(OrderDate) AS OrderMonth
FROM Order_table;