-- Use your existing database or create a new one
CREATE DATABASE companyDB;
USE companyDB;

-- ===========================
-- EMPLOYEE TABLE
-- ===========================
CREATE TABLE Employee (
  id INT PRIMARY KEY,
  fname VARCHAR(50),
  lname VARCHAR(50),
  age INT,
  emailID VARCHAR(100),
  phoneNo VARCHAR(20),
  city VARCHAR(50)
);

INSERT INTO Employee (id, fname, lname, age, emailID, phoneNo, city) VALUES
(1, 'Aman', 'Proto', 32, 'aman@gmail.com', '898', 'Delhi'),
(2, 'Yagya', 'Narayan', 44, 'yagya@gmail.com', '222', 'Palam'),
(3, 'Rahul', 'BD', 22, 'rahul@gmail.com', '444', 'Kolkata'),
(4, 'Jatin', 'Hermit', 31, 'jatin@gmail.com', '666', 'Raipur'),
(5, 'PK', 'Pandey', 21, 'pk@gmail.com', '555', 'Jaipur');

-- ===========================
--  PROJECT TABLE
-- ===========================
CREATE TABLE Project (
  id INT PRIMARY KEY,
  empID INT,
  name VARCHAR(50),
  startdate DATE,
  clientID INT,
  FOREIGN KEY (empID) REFERENCES Employee(id)
);
ALTER TABLE Project
ADD CONSTRAINT fk_client
FOREIGN KEY (clientID) REFERENCES Client(id);

INSERT INTO Project (id, empID, name, startdate, clientID) VALUES
(1, 1, 'A', '2021-04-21', 3),
(2, 2, 'B', '2021-03-12', 1),
(3, 3, 'C', '2021-01-16', 5),
(4, 3, 'D', '2021-04-27', 2),
(5, 5, 'E', '2021-05-01', 4);
 select * from project;
-- ===========================
--  CLIENT TABLE
-- ===========================
CREATE TABLE Client (
  id INT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  age INT,
  emailID VARCHAR(100),
  phoneNo VARCHAR(20),
  city VARCHAR(50),
  empID INT,
  FOREIGN KEY (empID) REFERENCES Employee(id)
);

INSERT INTO Client (id, first_name, last_name, age, emailID, phoneNo, city, empID) VALUES
(1, 'Mac', 'Rogers', 47, 'mac@hotmail.com', '333', 'Kolkata', 3),
(2, 'Max', 'Poirier', 27, 'max@gmail.com', '222', 'Kolkata', 3),
(3, 'Peter', 'Jain', 24, 'peter@abc.com', '111', 'Delhi', 1),
(4, 'Sushant', 'Aggarwal', 23, 'sushant@yahoo.com', '45454', 'Hyderabad', 4),
(5, 'Pratap', 'Singh', 36, 'p@xyz.com', '77767', 'Mumbai', 2);


SELECT fname, age
FROM employee
WHERE age > (SELECT AVG(age) FROM employee);

SELECT fname, lname
FROM employee
WHERE id IN (
    SELECT empID
    FROM project
    WHERE clientID IN (
        SELECT id FROM client WHERE age > 35
    )
);

SELECT fname, lname
FROM employee
WHERE id NOT IN (SELECT empID FROM project);

use companyDB;

SELECT
  e.fname,
  (SELECT COUNT(*) FROM project p WHERE p.empID = e.id) AS total_projects
FROM employee e;

select * from employee where id in(select empID from Project group by empID having count(empID) > 1);

select max(age)from (select * from employee where fname like '%a%') as temp;

SELECT
  e.fname,
  (SELECT p.name
   FROM project p
   WHERE p.empID = e.id
   LIMIT 1) AS project_name
FROM employee e;

SELECT *
FROM Employee e1
WHERE 3 = (
    SELECT COUNT(e2.age)
    FROM Employee e2
    WHERE e2.age >= e1.age
);
show databases;
-- ---------------- views----------------
create view view_custom as select fname ,age from employee;
select * from view_custom;
alter view view_custom as select fname ,age,city from employee;

CREATE VIEW project_summary AS
SELECT e.fname AS employee_name, p.name
FROM employee e
JOIN project p ON e.id = p.empId;

select * from Project_summary
