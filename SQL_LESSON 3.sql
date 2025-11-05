#Using the given SQL Script, explain how money is transferred between two accounts using a transaction

## Create a table for account
CREATE TABLE accounts(
	account_id INT AUTO_INCREMENT PRIMARY KEY,
    account_holder VARCHAR(100) NOT NULL,
    balance DECIMAL(10,2)
    );

## Insert records into accounts
INSERT INTO accounts(account_holder, balance)
VALUES
('Alice', 2000),
('Bob', 2500);

## Create a procedure to transfer

DELIMITER $$
CREATE PROCEDURE transfer_money(IN sender_id INT, receiver_id INT, IN amount DECIMAL(10,2))
BEGIN
	DECLARE sender_balance DECIMAL(10,2);
-- Start transaction 
START TRANSACTION;
-- Get the sender balance
SELECT balance INTO sender_balance FROM accounts WHERE account_id = sender_id;
-- Check if the sender has enough balance
IF sender_balance < amount THEN 
-- Rollback if insufficient
	ROLLBACK;
ELSE
-- Deduct amount from senders account 
UPDATE accounts SET balance = balance -amount WHERE account_id = sender_id;
-- Add amount to the receiver account 
UPDATE accounts SET balance = balance + amount WHERE account_id = receiver_id;
-- Commit the transaction
COMMIT;
END IF;
END $$
DELIMITER ;

CALL transfer_money(1, 2, 500);

SELECT *
FROM accounts;

## Let's consider a scenerio where you are trying to divide a number by zero, which is against the law.

DELIMITER $$
CREATE PROCEDURE DivideNumbers()
BEGIN
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
    BEGIN 
		SELECT 'Error: Division by zero occurred!' AS Errormessage;
	END;
    -- Attempt division by zero
    SELECT 5/0 AS Results;
END $$
DELIMITER ;

CALL DivideNumbers();


## Create a secondary index on the department column to speed up these queries.

CREATE INDEX idx_department ON employees(department_id);

SELECT *
FROM employees WHERE department_id = 101;

## Horizontal partition
CREATE TABLE employees_horizontal_partition(
	employee_id INT NOT NULL,
    name VARCHAR(100),
    department_id INT NOT NULL,
    salary DECIMAL(10, 2),
    PRIMARY KEY (employee_id, department_id)
    )
    PARTITION BY RANGE(department_id) (
    PARTITION p1 VALUES LESS THAN (10),
    PARTITION p2 VALUES LESS THAN (20),
    PARTITION p3 VALUES LESS THAN (30),
    PARTITION p4 VALUES LESS THAN MAXVALUE
    );

## Insert records into employees_horizontal_partition 
INSERT INTO employees_horizontal_partition(employee_id, name, department_id, salary)
VALUES
(1, 'Garba Job', 5, 60000),
(2, 'Esther Adog', 8, 55000),
(3, 'Seun Adum', 12, 70000),
(4, 'Chidinma Ugo', 18, 75000),
(5, 'Eva Adam', 25, 80000),
(6, 'Frank Bob', 28, 65000),
(7, 'Grace Tall', 35, 90000);

EXPLAIN 
SELECT * FROM employees_horizontal_partition WHERE department_id = 18;

## Partition data based on keys
CREATE TABLE employees_key_partition (
employee_id INT NOT NULL,
    name VARCHAR(100),
    department_id INT NOT NULL,
    salary DECIMAL(10, 2),
    PRIMARY KEY (employee_id)
    )
    PARTITION BY KEY(employee_id)
    PARTITIONS 4;

## Insert into our employees_key_partition

INSERT INTO employees_key_partition(employee_id, name, department_id, salary)
VALUES
(1, 'Garba Job', 5, 60000),
(2, 'Esther Adog', 8, 55000),
(3, 'Seun Adum', 12, 70000),
(4, 'Chidinma Ugo', 18, 75000),
(5, 'Eva Adam', 25, 80000),
(6, 'Frank Bob', 28, 65000),
(7, 'Grace Tall', 35, 90000);

EXPLAIN
SELECT * FROM employees_key_partition WHERE employee_id = 1;

## Hash  partition 
CREATE TABLE employee_hash_partition (
employee_id INT NOT NULL,
    name VARCHAR(100),
    department_id INT NOT NULL,
    salary DECIMAL(10, 2),
    PRIMARY KEY (employee_id, department_id)
    )
    PARTITION BY HASH (department_id) 
    PARTITIONS 4;
    
## Insert into our employees_hash_partition

INSERT INTO employee_hash_partition(employee_id, name, department_id, salary)
VALUES
(1, 'Garba Job', 5, 60000),
(2, 'Esther Adog', 8, 55000),
(3, 'Seun Adum', 12, 70000),
(4, 'Chidinma Ugo', 18, 75000),
(5, 'Eva Adam', 25, 80000),
(6, 'Frank Bob', 28, 65000),
(7, 'Grace Tall', 35, 90000);

EXPLAIN 
SELECT * FROM employee_hash_partition WHERE department_id = 8;


## Round-Robin Partition
CREATE TABLE employee_round_robin (
employee_id INT NOT NULL,
    name VARCHAR(100),
    department_id INT NOT NULL,
    salary DECIMAL(10, 2),
    PARTITIONID INT GENERATED ALWAYS AS (MOD(employee_id, 4)) STORED,
    PRIMARY KEY (employee_id, department_id)
    );

## Insert into our employee_round_robin

INSERT INTO employee_round_robin(employee_id, name, department_id, salary)
VALUES
(1, 'Garba Job', 5, 60000),
(2, 'Esther Adog', 8, 55000),
(3, 'Seun Adum', 12, 70000),
(4, 'Chidinma Ugo', 18, 75000),
(5, 'Eva Adam', 25, 80000),
(6, 'Frank Bob', 28, 65000),
(7, 'Grace Tall', 35, 90000);

SELECT * FROM employee_round_robin WHERE PARTITIONID = 3;
SELECT PARTITIONID, COUNT(*) FROM employee_round_robin GROUP BY PARTITIONID;