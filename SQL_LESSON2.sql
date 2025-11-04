USE hrms

#Create Employees Table with teo foreign key
CREATE TABLE employees(
employee_id INT PRIMARY KEY,
employee_name VARCHAR(100),
department_id INT,
manager_id INT,
FOREIGN KEY (department_id) REFERENCES departments(department_id),
FOREIGN KEY (manager_id) REFERENCES managers(manager_id)
);

#INSERT INTO employees table 
INSERT INTO employees(employee_id, employee_name, department_id, manager_id)
VALUES
(101, 'Charles Eze', 1001, 201),
(102, 'Martins Ozg', 1002, 202),
(103, 'Job Ola', 1001, 201),
(1004, 'David Matines', 1003, 203);

#Create department table
CREATE TABLE departments (
department_id INT PRIMARY KEY,
department_name VARCHAR(100),
department_location VARCHAR(100)
);

#INSERT INTO deprtment table
INSERT INTO departments( department_id, department_name, department_location)
VALUES
(1001, 'IT', 'Kano'),
(1002, 'HR', 'Anambra'),
(1003, 'IT', 'Ogun'),
(1004, 'Finance', 'Bayeisa');

#Create manager table
CREATE TABLE managers (
manager_id INT PRIMARY KEY,
department_id INT,
FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

#INSEERT INTO managers table
INSERT INTO managers( manager_id, department_id)
VALUES
(201, 1001),
(202, 1002),
(203, 1003),
(204, 1004);

##Extract data from CSV into department database
SELECT *
FROM departments;

#Handling missing data in our departments table
UPDATE departments
SET department_location = "UNKNOWN"
WHERE department_id = 107;
UPDATE departments
SET department_location = "UNKNOWN"
WHERE department_id = 108;


#Final department table
CREATE TABLE finaldepartments(
				department_id INT PRIMARY KEY,
                department_name VARCHAR(50),
                department_location VARCHAR(50)
                );

##Load our clear data into our department final table
INSERT INTO finaldepartments(department_id, department_name, department_location)
SELECT * FROM departments;

SELECT *
FROM finaldepartments;