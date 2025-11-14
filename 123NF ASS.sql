## Create 1NF, 2NF and 3NF
## Create employees table
CREATE TABLE employees (
		emp_id INT AUTO_INCREMENT PRIMARY KEY,
        emp_name VARCHAR (100),
        salary DECIMAL(10, 2),
        department_name VARCHAR(100)
        );

## Insert values into employees table 
INSERT INTO employees (emp_id, emp_name, salary, department_name)
VALUES
(101, 'Umar Adamu', 50000, 'HR'),
(102, 'Jane Abu', 60000, 'IT'),
(103, 'Caroline Agu', 55000, 'Finance'),
(104, 'Shehu Umar', 48000, 'Logistics'),
(105, 'Mohammed Bello', 53000, 'Procurement'),
(106, 'Frank Ewu', 62000, 'IT');


## Create departments table
CREATE TABLE departments (
	department_name VARCHAR(100),
    deparrtment_location VARCHAR(100)
    );

## Insert values into departments table
INSERT INTO departments (department_name, deparrtment_location)
VALUES
('HR', 'Lokoja'),
('IT', 'Cross River'),
('Finance', 'Sokoto'),
('Logistics', 'Zamfara'),
('Procurement', 'Jigawa'),
('IT', 'Delta');

CREATE TABLE managers (
	manager_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100)
); 

## Insert manager values
INSERT INTO managers (manager_id, department_name)
VALUES
(201, 'HR'),
(202, 'IT'),
(203, 'Finance'),
(204, 'Logistics'),
(205, 'Procurement'),
(206, 'IT');

SELECT * 
FROM employees;

SET SQL_SAFE_UPDATES = 1;

## Transform the data by updating employee salaries with a 10% increase for employees in the IT department.
UPDATE employees
SET salary = salary * 1.10
WHERE department_name = 'IT';