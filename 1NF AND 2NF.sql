#Create an employees phone number 
CREATE TABLE employeesphonenumber (
			id INT AUTO_INCREMENT PRIMARY KEY,
            employee_id INT,
            phone_number VARCHAR(15),
            FOREIGN KEY(employee_id) REFERENCES employees(employee_id)
            );
            
INSERT INTO  employeesphonenumber (employee_id, phone_number)
VALUES
(1001, 89000000000),
(1001, 79000000000),
(1002, 70300000000),
(1002, 60500000000),
(1003, 50000000000);

SELECT *
FROM employeesphonenumber

