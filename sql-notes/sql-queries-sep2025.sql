use sqllearning;

create table employee(emp_id int, emp_name varchar(20), DOB date);

drop table employee;

ALTER table employee add emp_salary long;

ALTER table employee drop DOB;


INSERT into employee(emp_id, emp_name, emp_salary, department, location) values(101,'Srini', 99999, 'IT', 'GNT');
INSERT into employee(emp_id, emp_name, emp_salary, department, location) values(102,'Venki', 199999, 'IT', 'SAP');
INSERT into employee(emp_id, emp_name, emp_salary,department, location) values(103,'Pavani', 299999, 'FINANCE', 'SAP');
INSERT into employee(emp_id, emp_name, emp_salary,department, location) values(104,'Arun', 399999, 'FINANCE', 'NRT');
INSERT into employee(emp_id, emp_name, emp_salary,department, location) values(105,'Syamala', 699999,'ADMIN', 'GNT');



select emp_name,emp_salary from employee where emp_id=102;

SET SQL_SAFE_UPDATES = 0; 

rollback;

update employee set emp_salary=199999 where emp_id=102;
select * from employee;
delete from employee where emp_id=101;
commit;

--  *****************Day-2 session *****************************************

select * from employee order by emp_name, emp_salary ;

select * from employee order by emp_salary  ;

select * from employee;

Alter table employee add department varchar(20);

Alter table employee add location varchar(20);

TRUNCATE table employee;

-- group by

select department, sum(emp_salary)  from employee group by department;

select department, avg(emp_salary) from employee group by department;

select location, count(*) as employee_count from employee group by location;


-- Having cluse

SELECT 
    department, SUM(emp_salary) AS Total_Salary
FROM
    employee
GROUP BY department
HAVING SUM(emp_salary) > 299999;

select location, count(*) as employee_count from employee group by location having employee_count>1;


--  ********************************Session-3**************************************************************

CREATE TABLE CUSTOMERS(
ID INT NOT NULL,
NAME VARCHAR (20) NOT NULL,
AGE INT NOT NULL,
ADDRESS CHAR (25) ,
SALARY DECIMAL (18, 2),
PRIMARY KEY (ID)
);


INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (1, 'Ramesh', 32, 'Ahmedabad', 2000.00 );
INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (2, 'Khilan', 25, 'Delhi', 1500.00 );
INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (3, 'kaushik', 23, 'Kota', 2000.00 );
INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (4, 'Chaitali', 25, 'Mumbai', 6500.00 );
INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (5, 'Hardik', 27, 'Bhopal', 8500.00 );
INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (6, 'Komal', 22, 'MP', 4500.00 );
INSERT INTO CUSTOMERS
VALUES (7, 'Muffy', 24, 'Indore', 10000.00 );


select * from customers where NAME ='srini';

select * from customers where NAME like '%r%';

select * from customers where SALARY like '%_%';

select * from customers where SALARY like '2______';

select * from customers where SALARY like '6______';

select * from customers where salary like '1_______';

select * from customers limit 3;  -- this command is for MySQL DB


select id, NAME, SALARY from customers where NAME='Ramesh' AND SALARY=2000;

select id,name, SALARY from customers where NAME='srini' OR SALARY=2000;


select distinct salary from customers;

select distinct salary from customers;


select c.name, c.salary, c.age, c.address from customers c;

alter table customers change id customer_id int;

select * from customers;


CREATE TABLE ORDERS(
ORDER_ID INT,
ORDER_NAME VARCHAR (20),
ORDER_VALUE INT,
CUSTOMER_ID int
);

insert into ORDERS(ORDER_ID, ORDER_NAME, ORDER_VALUE,CUSTOMER_ID) values(10, 'LAPTOP', 50000, 1);

insert into ORDERS(ORDER_ID, ORDER_NAME, ORDER_VALUE,CUSTOMER_ID) values(11, 'MOBILE', 60000, 2);

insert into ORDERS(ORDER_ID, ORDER_NAME, ORDER_VALUE,CUSTOMER_ID) values(13, 'PENDRIVE', 500, 3);

insert into ORDERS(ORDER_ID, ORDER_NAME, ORDER_VALUE,CUSTOMER_ID) values(14, 'KEYBOARD', 700, 4);

insert into ORDERS(ORDER_ID, ORDER_NAME, ORDER_VALUE,CUSTOMER_ID) values(15, 'IPAD', 80000, 5);

insert into ORDERS(ORDER_ID, ORDER_NAME, ORDER_VALUE,CUSTOMER_ID) values(17, 'CHAIR', 6000, 6);

insert into ORDERS(ORDER_ID, ORDER_NAME, ORDER_VALUE,CUSTOMER_ID) values(18, 'TABLE', 9000, 7);

insert into ORDERS(ORDER_ID, ORDER_NAME, ORDER_VALUE,CUSTOMER_ID) values(19, 'CHARGER', 8000, 8);

select * from orders;

delete from orders where order_id in(15,17);


---- joins

SELECT     customers.customer_id,    customers.NAME,    customers.AGE,
    orders.order_id,    orders.order_name FROM
    customers inner join orders on customers.customer_id=orders.customer_id; 
    
    --- Left join
    SELECT     customers.customer_id,    customers.NAME,    customers.AGE,
    orders.order_id,    orders.order_name FROM
    customers left join orders on customers.customer_id=orders.customer_id; 
    
    --- right join
    SELECT     customers.customer_id,    customers.NAME,    customers.AGE,
    orders.order_id,    orders.order_name FROM
    customers right join orders on customers.customer_id=orders.customer_id; 
    
    
    -- Full join
    
    SELECT     customers.customer_id,    customers.NAME,    customers.AGE,
    orders.order_id,    orders.order_name FROM
    customers left join orders on customers.customer_id=orders.customer_id
    
UNION
    SELECT     customers.customer_id,    customers.NAME,    customers.AGE,
    orders.order_id,    orders.order_name FROM
    customers right join orders on customers.customer_id=orders.customer_id; 
    
    
 --  ********************************Session-3**************************************************************   
    
    
    -- self join
-- Create employees table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    manager_id INT,
    salary DECIMAL(10,2),
    department VARCHAR(50)
);

-- Insert data into employees table
INSERT INTO employees (emp_id, emp_name, manager_id, salary, department) VALUES
(1, 'Arun', NULL, 100000, 'CEO'),
(2, 'Venkatesh', 1, 80000, 'Engineering'),
(3, 'Syamala', 1, 75000, 'Marketing'),
(4, 'Pavani', 2, 60000, 'Engineering'),
(5, 'Srini', 2, 65000, 'Engineering');

select * from employees;


-- ********************************** Session -4  *********************************************


-- Create current_employees table
CREATE TABLE current_employees (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50)
);

-- Create former_employees table
CREATE TABLE former_employees (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50)
);

commit;

-- Insert data into current_employees
INSERT INTO current_employees VALUES
(1, 'Arun', 'Engineering'),
(2, 'Venkatesh', 'Marketing'),
(3, 'Syamala', 'Engineering'),
(4, 'Pavani', 'HR');

-- Insert data into former_employees
INSERT INTO former_employees VALUES
(2, 'Venkatesh', 'Marketing'),  -- Duplicate name
(5, 'Rahul', 'Engineering'),
(6, 'Priya', 'Finance'),
(7, 'Anita', 'HR');


select * from current_employees;

select * from former_employees;

select emp_id, emp_name, department from current_employees
union 
select emp_id, emp_name, department from former_employees;


select emp_id, emp_name, department from current_employees
union all
select emp_id, emp_name, department from former_employees;

-- constraints

drop table employees;

-- NOT NULL

create table employees(emp_id int, emp_name varchar(20) not null);

insert into employees(emp_id, emp_name) values(1,'Srini');

select * from employees;


create table Accounts(acc_id int, account_name varchar(20), account_status varchar(20) DEFAULT 'active');

insert into accounts(acc_id,account_name ) values(101, 'SAVINGS');

insert into accounts(acc_id,account_name, account_status ) values(101, 'SAVINGS', 'inactive');

select * from accounts;

-- UNIQUE

create table users (user_id int unique, user_name varchar(20) unique);

insert into users(user_id, user_name) values(101,'Arun');

insert into users(user_id, user_name) values(102,'Srini');

select * from users;

truncate table users;

drop table users;


-- ****************************Session-5 ***********************************************************

CREATE TABLE Customers (
    ID INT PRIMARY KEY,
    Name VARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(ID)
);

select * from customers;

insert into customers (id, name) values(101, 'Srini');

insert into orders (orderID, customerID) values(2, 102); 

select * from orders;

drop table customers;

drop table orders;

select * from employees;

select * from employee;

create view IT_Employees as select emp_id, emp_name, emp_salary from employee where department in ('IT');

select * from IT_Employees;

create view public_employees as select emp_id, emp_name, department, location from employee;

select * from public_employees;


select * from employee;

alter table employee drop department;

alter table employee add dept_id int;

update employee set dept_id=1 where emp_id=101;
update employee set dept_id=2 where emp_id=102;
update employee set dept_id=3 where emp_id=103;

update employee set dept_id=4 where emp_id=104;
update employee set dept_id=5 where emp_id=105;

create table department(dept_id int primary key, dept_name varchar(20));

insert into department(dept_id, dept_name) values(1, 'IT');
insert into department(dept_id, dept_name) values(2, 'ADMIN');
insert into department(dept_id, dept_name) values(3, 'FINANCE');
insert into department(dept_id, dept_name) values(4, 'IT');
insert into department(dept_id, dept_name) values(5, 'FINANCE');

select * from department;
drop table department;


SELECT 
    emp_id, emp_name, emp_salary, location
FROM  employee WHERE
    dept_id IN (SELECT dept_id FROM department WHERE dept_name = 'IT');
    
    
    select * from employees;
    
    select FIRST(emp_name) from employee;
    
    
    --   PL/SQL   *********************************************************************************
    
    -- Functions
    
    use sqllearning;

CREATE TABLE Employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

INSERT INTO Employees (id, name, department, salary) VALUES (1, 'Srini', 'IT', 50000);
INSERT INTO Employees (id, name, department, salary) VALUES (2, 'Pavani', 'HR', 40000);
INSERT INTO Employees (id, name, department, salary) VALUES (3, 'Syamala', 'IT', 60000);
INSERT INTO Employees (id, name, department, salary) VALUES (4, 'Venki', 'HR', 45000);
INSERT INTO Employees (id, name, department, salary) VALUES (5, 'Arun', 'Sales', 55000);

-- Functions ********************************************************

--  **************** find Area Of rectangle by writing function  ****************
DELIMITER //
CREATE FUNCTION rectangle_area(length DOUBLE, width DOUBLE)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
    DECLARE area DOUBLE;
    SET area = length * width;
    RETURN area;
END;
//
DELIMITER ;

select rectangle_area(20,10);

select * from employees;

--  **************** Get Annual salary of the employee ****************
DELIMITER //
CREATE FUNCTION calculate_annual_salary( monthly_salary DECIMAL(10,2)) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE annual_salary DECIMAL(10,2);
    SET annual_salary = monthly_salary * 12;
    RETURN annual_salary;
END //
DELIMITER ;

-- Usage:
SELECT name, salary as Monthly_Salary, calculate_annual_salary(salary) AS annual_salary FROM employees;


--  **************** Get grade of the employee based on salary  ****************

DELIMITER //
CREATE FUNCTION get_salary_grade(
    emp_salary DECIMAL(10,2)
) 
RETURNS VARCHAR(20)
  DETERMINISTIC
BEGIN
    DECLARE grade VARCHAR(20);
    
    IF emp_salary >= 55000 THEN
        SET grade = 'Grade A';
    ELSEIF emp_salary >= 50000 THEN
        SET grade = 'Grade B';
    ELSEIF emp_salary >= 40000 THEN
        SET grade = 'Grade C';
    ELSE
        SET grade = 'Grade D';
    END IF;
    
    RETURN grade;
END //
DELIMITER ;

-- Usage:
SELECT name, salary, get_salary_grade(salary) AS salary_grade FROM employees;

--  *******************************Get Employee bouns based on employee performance and department ********

DELIMITER //

CREATE FUNCTION calculate_bonus(
    employee_id INT,
    performance_rating DECIMAL(3,1)
) 
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE emp_salary DECIMAL(10,2);
    DECLARE bonus_amount DECIMAL(10,2);
    DECLARE dept_bonus_rate DECIMAL(5,2);
    
    -- Get employee salary
    SELECT salary INTO emp_salary
    FROM employees 
    WHERE id = employee_id;
    
    -- Determine department bonus rate
    SELECT 
        CASE 
            WHEN department = 'IT' THEN 0.15
            WHEN department = 'Sales' THEN 0.20
            WHEN department = 'HR' THEN 0.12
            ELSE 0.10
        END INTO dept_bonus_rate
    FROM employees 
    WHERE id = employee_id;
    
    -- Calculate bonus based on performance and department
    SET bonus_amount = emp_salary * dept_bonus_rate * (performance_rating / 5);
    
    -- Ensure minimum bonus
    IF bonus_amount < 1000 THEN
        SET bonus_amount = 1000;
    END IF;
    
    RETURN bonus_amount;
END //

DELIMITER ;

-- Usage (assuming we have performance_rating column):
SELECT id, name,department,  salary, calculate_bonus(id, 4.5) AS calculated_bonus FROM employees;



-- **************************************** Procedures

use sqllearning;

select * from employees;

DELIMITER //
CREATE PROCEDURE sp_add_employee(
    IN p_id INT,   IN p_name VARCHAR(50),    IN p_department VARCHAR(50),    IN p_salary INT)
BEGIN
    INSERT INTO Employees (id, name, department, salary)
    VALUES (p_id, p_name, p_department, p_salary);    
    SELECT CONCAT('Employee ', p_name, ' added successfully!') AS result;
END //
DELIMITER ;

CALL sp_add_employee(6, 'Anusha', 'IT', 75000);

--  Update employee 

DELIMITER //
CREATE PROCEDURE sp_update_department(IN p_id INT,    IN p_new_department varchar(20))
BEGIN
    UPDATE Employees  SET department = p_new_department   WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT CONCAT('department updated for employee ID: ', p_id) AS result;
    ELSE
        SELECT 'Error: Employee not found' AS result;
    END IF;
END //
DELIMITER ;

 CALL sp_update_department(7, 'Sales');
 
 select * from Employees;
 
 
 -- delete employee
 
 DELIMITER //
CREATE PROCEDURE sp_delete_employee(IN p_id INT)
BEGIN
    DELETE FROM Employees WHERE id = p_id;
    
    IF ROW_COUNT() > 0 THEN
        SELECT CONCAT('Employee ID ', p_id, ' deleted successfully!') AS result;
    ELSE
        SELECT 'Error: Employee not found' AS result;
    END IF;
END //
DELIMITER ;

CALL sp_delete_employee(6);

-- get employee details

DELIMITER //
CREATE PROCEDURE sp_get_employees_by_dept(IN p_department VARCHAR(50))
BEGIN
    SELECT * FROM Employees 
    WHERE department = p_department 
    ORDER BY salary DESC;
END //
DELIMITER ;

CALL sp_get_employees_by_dept('IT');

--  Apply Department-wide Salary Increase

DELIMITER //
CREATE PROCEDURE sp_apply_department_raise(IN p_department VARCHAR(50), IN p_raise_percentage DECIMAL(5,2))
BEGIN
    DECLARE affected_rows INT;    
    UPDATE Employees SET salary = salary * (1 + p_raise_percentage/100)
    WHERE department = p_department;    
    SET affected_rows = ROW_COUNT();    
    SELECT 
        CONCAT('Raise applied to ', affected_rows, ' employees in ', p_department) AS message,
        p_raise_percentage AS raise_percentage;
END //
DELIMITER ;

SET SQL_SAFE_UPDATES = 0; 

CALL sp_apply_department_raise('Sales', 15.0);


--   **********************************************   Triggers-----

use sqllearning;


CREATE TABLE Employees2 (
    EmpID INT PRIMARY KEY AUTO_INCREMENT,
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);
CREATE TABLE Employee_Audit_2 (
    AuditID INT PRIMARY KEY AUTO_INCREMENT,
    EmpID INT ,
    ActionType VARCHAR(10),
    ActionTime DATETIME
);


DELIMITER $$
CREATE TRIGGER After_employee_insert
AFTER INSERT ON Employees2
FOR EACH ROW
BEGIN
    INSERT INTO Employee_Audit_2 (EmpID, ActionType, ActionTime)
    VALUES (NEW.EmpID, 'INSERT', NOW());
END$$

DELIMITER ;

SELECT * FROM employee_audit_2;

select * from employees2;

INSERT INTO Employees2 (EmpName, Department, Salary)
VALUES ('Arun', 'IT', 185000);














    
    
    
    

  














    
    
    
    
    
    
    





















