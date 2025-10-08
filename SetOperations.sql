show databases;
use bankingsystem;
-- Employees table (Parent table)
CREATE TABLE employee1 (
  id INT PRIMARY KEY,
  name VARCHAR(50)
);

-- Projects table (Child table)
CREATE TABLE project1 (
  project_id INT PRIMARY KEY,
  project_name VARCHAR(50),
  emp_id INT
);
-- Employees
INSERT INTO employee1 VALUES
(1, 'Ali'),
(2, 'Ayesha'),
(3, 'Ahmed');

-- Projects (each employee can have multiple projects)
INSERT INTO project1 VALUES
(101, 'ProjEase', 1),
(102, 'Goal Tracker', 1),
(103, 'School ERP', 2),
(104, 'AI Assistant', 2),
(105, 'Portfolio Website', 3);

SELECT e.id, e.name, p.project_name
FROM employee1 AS e
INNER JOIN project1 AS p
ON e.id = p.emp_id;

SELECT DISTINCT e.name
FROM employee1 e
INNER JOIN project1 p
ON e.id = p.emp_id;

CREATE TABLE employee_pk (
  id INT,
  name VARCHAR(50),
  city VARCHAR(50)
);

CREATE TABLE employee_branch (
  id INT,
  name VARCHAR(50),
  city VARCHAR(50)
);

INSERT INTO employee_pk VALUES
(1, 'Ali', 'Lahore'),
(2, 'Ayesha', 'Karachi'),
(3, 'Ahmed', 'Faisalabad'),
(4, 'Sara', 'Islamabad');

INSERT INTO employee_branch VALUES
(2, 'Ayesha', 'Karachi'),
(3, 'Ahmed', 'Faisalabad'),
(5, 'Zara', 'Multan');


SELECT e1.name, e1.city
FROM employee_pk AS e1
LEFT JOIN employee_branch AS e2
ON e1.name = e2.name AND e1.city = e2.city
WHERE e2.name IS NULL;


CREATE TABLE employee_pk (
  id INT,
  name VARCHAR(50),
  city VARCHAR(50)
);

CREATE TABLE employee_branch (
  id INT,
  name VARCHAR(50),
  city VARCHAR(50)
);
INSERT INTO employee_pk VALUES
(1, 'Ali', 'Lahore'),
(2, 'Ayesha', 'Karachi'),
(3, 'Ahmed', 'Faisalabad'),
(4, 'Sara', 'Islamabad');

INSERT INTO employee_branch VALUES
(2, 'Ayesha', 'Karachi'),
(3, 'Ahmed', 'Faisalabad'),
(5, 'Zara', 'Multan');

SELECT d1.name, d1.city
FROM employee_pk AS d1
LEFT JOIN employee_branch AS d2
USING (id, name, city)
WHERE d2.id IS NULL;

SELECT name, city FROM employee_pk
UNION ALL
SELECT name, city FROM employee_branch;


