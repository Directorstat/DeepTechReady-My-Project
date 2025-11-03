USE ass_schema

##Create table for Customer
CREATE TABLE customer (
customer_id INT PRIMARY KEY,
Name VARCHAR(100) NOT NULL,
State VARCHAR(50) NOT NULL,
Income DECIMAL(10, 2) NOT NULL
);

##Create table for Transaction
CREATE TABLE transactions (
Transaction_id VARCHAR(100) NOT NULL, 
Amount DECIMAL(10, 2) NOT NULL, 
Transaction_Type VARCHAR(100) NOT NULL,
Transcation_date DATE,
customer_id INT,
FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

#Insert data in the Customer table
INSERT INTO customer (customer_id, Name, State, Income)
VALUES
(3021, 'Kolawale Saidu', 'Lagos', 85000),
(3028, 'Ade Abu', 'Edo', 120000),
(3067, 'Imabong Udo', 'Akwa Ibom ', 65000),
(3078, 'Diana Ross', 'Cross River', 95000),
(3097, 'Adullahi Usman', 'Yobe', 70000),
(3043, 'Jefferson Chris', 'Taraba', 51000),
(3056, 'Chidinma Ikena', 'Abia ', 67000);

##Insert data in the transactions table
INSERT INTO transactions (Transaction_id, Amount, Transaction_Type, Transcation_date, customer_id)
VALUES
('T001', 8000, 'Credit', '2024-01-12', 3021),
('T002', 1000, 'Debit', '2024-02-12', 3028),
('T003', 4000, 'Credit', '2024-03-12', 3078),
('T004', 1500, 'Credit', '2024-03-12', 3067),
('T005', 15000, 'Debit', '2024-04-12', 3021),
('T006', 30000, 'Debit', '2024-05-12', 3097),
('T007', 90000, 'Credit', '2024-05-12', 3028),
('T008', 7600, 'Debit', '2024-06-12', 3056),
('T009', 5800, 'Credit', '2024-06-12', 3043);

## Total Transcation Amount by Customer name
SELECT c.customer_id, c.name, SUM(t.Amount) AS TotalAmount
FROM customer c
JOIN transactions t
ON t.customer_id = c.customer_id
GROUP BY c.customer_id, c.Name;

#combine the list from lagos and edo using UNION
SELECT c.Name, t.customer_id
FROM customer c
LEFT JOIN transactions t
ON c.customer_id = t.customer_id

UNION

SELECT c.Name, t.customer_id
FROM customer c
RIGHT JOIN transactions t
ON c.customer_id = t.customer_id;

#Assign a rank on each transaction based on transaction Amount
SELECT customer_id, Amount,
		RANK() OVER (PARTITION BY customer_id ORDER BY Amount DESC) ranking
FROM transactions t;

#use LEAD and LAG to display the next and previous transaction amounts for each transaction, ordered by date
SELECT 
		t.Transaction_id,
        t.customer_id,
        t.Amount, 
        LAG(t.Amount) OVER (PARTITION BY t.customer_id ORDER BY t.Transcation_date DESC) AS Previous_Amount,
        LEAD(t.Amount) OVER (PARTITION BY t.customer_id ORDER BY t.Transcation_date DESC) AS Next_Amount
FROM transactions t;
