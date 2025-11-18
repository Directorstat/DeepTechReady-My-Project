USE query1

##Create table for department
CREATE TABLE departments (
department_id INT PRIMARY KEY,
department_name VARCHAR(50) NOT NULL
);

##Create table for employee
CREATE TABLE employees (
employee_id INT PRIMARY KEY, 
name VARCHAR(100) NOT NULL,
salary DECIMAL(10, 2) NOT NULL, 
department_id INT,
FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

#Insert data in the department table
INSERT INTO departments (department_id, department_name)
VALUES
(101, 'HR'),
(102, 'IT'),
(103, 'Finance'),
(104, 'Logistics'),
(105, 'Procurement');

##Insert data in the employees table
INSERT INTO employees (employee_id, name, salary, department_id)
VALUES
(1001, 'John Oga', 300000, 104),
(1002, 'Alice udo', 100000, 102),
(1003, 'Agape Sam', 80000, 101),
(1004, 'Adams Eva', 350000, 105),
(1005, 'John Abi', 20000, 103),
(1006, 'John Joseph', 300000, 102);

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

##Retrieve employees names with total department payment
SELECT e.name AS Employee_name, d.department_name AS Department_name, SUM(e.salary) AS TotalSalarypayment
FROM employees e
JOIN departments d
ON e.department_id = d.department_id 
GROUP BY e.name, d.department_name; 

#Insert data to departments table
INSERT INTO departments(department_id, department_name)
VALUES
(106, '');

#Insert data to employees table
INSERT INTO employees(employee_id, name, salary)
VALUES 
(1007, 'Job Ugo', 60000);

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

#Find employees earn more than average salary in their department
SELECT e.name, salary
FROM employees e
WHERE salary > (
		SELECT AVG(salary) 
        FROM employees
        WHERE department_id = e.department_id
			);
            
#List all unique departments ids in employees table
SELECT department_id AS departmentIDS FROM departments
UNION
SELECT name AS EmployeeNames FROM employees;

#List departments names not associated with employees
SELECT d.department_name
FROM departments d
WHERE NOT EXISTS (
			SELECT 1
            FROM employees e
            WHERE e.department_id = d.department_id
            );
            
#Find the total salary by department, but split it into salaries above 100,000 and below 100,000
SELECT d.department_name,
		SUM(CASE WHEN e.salary >= 100000 THEN e.salary ELSE 0 END) AS high_salaries,
        SUM(CASE WHEN e.salary <= 100000 THEN e.salary ELSE 0 END) AS low_salaries
FROM employees e
JOIN departments d
ON e.department_id = d.department_id 
GROUP BY d.department_name;

##Create an index on employee_id to improve query performance 
CREATE INDEX idx_employee_id ON employees(employee_id);
SELECT *
FROM employees
WHERE employee_id = 1001;

##Use EXPLAIN to analyze a query that retrieves employee details by department
EXPLAIN ANALYZE SELECT e.name, d.department_name 
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;



