use test_2026;


CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

INSERT INTO department VALUES (1, 'HR'), (2, 'IT'), (3, 'Finance'),(4, 'Sales');

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT,
    manager_id INT,
    dept_id INT,
    join_date DATE,
    FOREIGN KEY (manager_id) REFERENCES employee(emp_id),
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

INSERT INTO employee VALUES
(101, 'John',    80000, NULL, 2, '2023-01-10'),
(102, 'David',   60000, 101,  2, '2023-02-15'),
(103, 'Sara',    60000, 101,  2, '2023-03-20'),
(104, 'Mike',    75000, NULL, 1, '2022-12-01'),
(105, 'Anita',   50000, 104,  1, '2023-07-18'),
(106, 'Robert',  90000, NULL, 3, '2021-11-11'),
(107, 'Sophia',  70000, 106,  3, '2022-09-09'),
(108, 'James',   70000, 106,  3, '2023-10-05'),
(109, 'Linda',   40000, 104,  4, '2024-01-01'),
(110, 'David',   60000, 101,  2, '2024-02-01');










--1) Find the second highest salary

SELECT MAX(salary) FROM employee WHERE salary < (SELECT MAX(salary) FROM employee);


-- ROW_NUMBER() is a window function and it assigns a unique sequential number to each row
-- ORDER BY salary DESC → Sort salaries from highest to lowest

SELECT salary FROM (SELECT salary,ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn FROM employee) t
WHERE rn = 4;


--2) Find Nth highest salary

SELECT salary FROM (SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) rnk
    FROM employee) t WHERE rnk = 3;  -- 3rd highest

--3) Find duplicate records

 SELECT emp_name, COUNT(*) FROM employee GROUP BY emp_name HAVING COUNT(*) > 1;
 
--4) Delete duplicate records

  DELETE FROM employee WHERE emp_id NOT IN ( SELECT MIN(emp_id) FROM employee GROUP BY emp_name);

-- 5) Find employees earning more than their manager

SELECT e.emp_name, e.salary FROM employee e JOIN employee m ON e.manager_id = m.emp_id WHERE e.salary > m.salary;

--6) Find department wise highest salary

	SELECT dept_id, MAX(salary) FROM employee GROUP BY dept_id;

-- 7) Fetch last 3 records

	SELECT *FROM employee ORDER BY emp_id DESC LIMIT 3;

-- 8) Find employees who joined in last 30 days
	SELECT * FROM employee WHERE join_date >= CURRENT_DATE - INTERVAL '30' DAY;

-- 9) Find employees having same salary

SELECT salary FROM employee GROUP BY salary HAVING COUNT(*) > 1;

-- 10) Running total of salary

SELECT emp_name, salary, SUM(salary) OVER (ORDER BY emp_id) AS running_total FROM employee;

-- 11) Find gap in sequence
 SELECT e1.emp_id + 1 AS missing_id FROM employee e1 LEFT JOIN employee e2 ON e1.emp_id + 1 = e2.emp_id WHERE e2.emp_id IS NULL;
 
 
 
 -- **********************************************************Join Queries ********************************************
 -- 12) Get employee name with department name
 
 SELECT e.emp_name, d.dept_name FROM employee e JOIN department d ON e.dept_id = d.dept_id;

-- 13) Get employees who belong to IT department

SELECT e.* FROM employee e  JOIN department d ON e.dept_id = d.dept_id WHERE d.dept_name = 'IT';

-- 14) Get all departments even if no employees exist

SELECT d.dept_name, e.emp_name FROM department d LEFT JOIN employee e ON d.dept_id = e.dept_id;

-- 15) Self Join Questions (Very Important)

--  16) Get employee and their manager name

SELECT e.emp_name AS employee, m.emp_name AS manager FROM employee e LEFT JOIN employee m ON e.manager_id = m.emp_id;

-- Department-wise total salary

SELECT d.dept_name, SUM(e.salary) AS total_salary FROM employee e JOIN department d ON e.dept_id = d.dept_id GROUP BY d.dept_name;

-- Department-wise highest salary with employee name

SELECT d.dept_name, e.emp_name, e.salary FROM employee eJOIN department d ON e.dept_id = d.dept_id 
WHERE e.salary = (   SELECT MAX(salary)    FROM employee     WHERE dept_id = e.dept_id);

-- Get departments having more than 2 employees

SELECT d.dept_name, COUNT(e.emp_id) AS emp_count FROM department d JOIN employee e ON d.dept_id = e.dept_id GROUP BY d.dept_name HAVING COUNT(e.emp_id) > 2;


-- Get employees who do NOT have a manager

	SELECT * FROM employee WHERE manager_id IS NULL;
	SELECT e.* FROM employee e LEFT JOIN employee m ON e.manager_id = m.emp_id WHERE m.emp_id IS NULL;
	
	
	-- Find employees working in same department	
	SELECT e1.emp_name, e2.emp_name, e1.dept_id FROM employee e1 JOIN employee e2 ON e1.dept_id = e2.dept_id AND e1.emp_id < e2.emp_id;
	
	-- Find departments where no employees exist
	
	SELECT d.* FROM department d LEFT JOIN employee e ON d.dept_id = e.dept_id WHERE e.emp_id IS NULL;
	
	
	-- Get employee count under each manager
	SELECT m.emp_name AS manager, COUNT(e.emp_id) AS reportees FROM employee e JOIN employee m
	ON e.manager_id = m.emp_id GROUP BY m.emp_name;















