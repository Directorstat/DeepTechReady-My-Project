USE ass1

##Create table for Customer
CREATE TABLE customer (
customer_id INT PRIMARY KEY,
Name VARCHAR(100) NOT NULL,
State VARCHAR(50) NOT NULL,
Income DECIMAL(10, 2) NOT NULL
);

##Create table for Transaction
CREATE TABLE transactions (
Transaction_id INT PRIMARY KEY, 
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

CREATE TABLE transactions (
Transaction_id INT PRIMARY KEY, 
Amount DECIMAL(10, 2) NOT NULL, 
Transaction_Type VARCHAR(100) NOT NULL,
Transcation_date DATE,
customer_id INT,
FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);
##Insert data in the transactions table
INSERT INTO transactions (Transaction_id, Amount, Transaction_Type, Transcation_date, customer_id)
VALUES
('T001', 8000, 300000, 3021),
(10021, 'Alice udo', 100000, 102),
(10031, 'Agape Sam', 80000, 101),
(10041, 'Adams Eva', 350000, 105),
(10051, 'John Abi', 20000, 103),
(10061, 'John Joseph', 300000, 102);

## Total salaries paid by department
SELECT d.department_id, d.department_name, SUM(e.salary) AS TotalSalary
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name;

##Identify Department with employeess earn above #290,000
SELECT DISTINCT d.department_id, d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE e.salary > 290000

##Retrieve employees names with toatl department payment
SELECT e.name AS Employee_name, d.department_name AS Department_name, SUM(e.salary) AS TotalSalarypayment
FROM employees e
JOIN departments d
ON e.department_id = d.department_id 
GROUP BY e.name, d.department_name; 


#Insert data to departments table
INSERT INTO departments(department_id, department_name)
VALUES
(1061, '');

#Insert data to employees table
INSERT INTO employees(employee_id, name, salary)
VALUES 
(10062, 'Job Ugo', 60000);

#Find employees with their department name
SELECT e.name, d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;

#List of all employees their departments, even if some are not assigned
SELECT e.name, d.department_name, d.department_id
FROM employees e
LEFT JOIN departments d
ON d.department_id = d.department_name;

#List of all departments their employees, even if some departments have no employees
SELECT d.department_name, e.name
FROM employees e
RIGHT JOIN departments d
ON d.department_id = e.department_id;

#Combine employees and departments data, showing all records from both tables 
SELECT e.name, d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id

UNION

SELECT e.name, d.department_name
FROM employees e
RIGHT JOIN departments d
ON e.department_id = d.department_id;

