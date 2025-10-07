show databases;
USE world;
SHOW TABLES;
CREATE TABLE Employee (
    id INT PRIMARY KEY,
    fname VARCHAR(50),
    lname VARCHAR(50),
    Age INT,
    emailID VARCHAR(100) UNIQUE,
    PhoneNo VARCHAR(20),
    City VARCHAR(50)
);
INSERT INTO Employee (id, fname, lname, Age, emailID, PhoneNo, City) VALUES
(1, 'Ali', 'Raza', 28, 'ali@gmail.com', '111', 'Lahore'),
(2, 'Sara', 'Khan', 26, 'sara@gmail.com', '222', 'Karachi'),
(3, 'Bilal', 'Ahmad', 30, 'bilal@gmail.com', '333', 'Islamabad'),
(4, 'Ayesha', 'Tariq', 25, 'ayesha@gmail.com', '444', 'Faisalabad'),
(5, 'Hamza', 'Sheikh', 27, 'hamza@gmail.com', '555', 'Multan'),
(6, 'Nida', 'Malik', 29, 'nida@gmail.com', '666', 'Peshawar');   -- client linked nahi hoga

SELECT * FROM Employee;
CREATE TABLE Client (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    emailID VARCHAR(100) UNIQUE,
    PhoneNo VARCHAR(20),
    City VARCHAR(50),
    empID INT,
    FOREIGN KEY (empID) REFERENCES Employee(id)
);
INSERT INTO Client (id, first_name, last_name, age, emailID, PhoneNo, City, empID) VALUES
(1, 'John', 'Smith', 40, 'john@gmail.com', '777', 'London', 1),   -- Ali ka client
(2, 'Emma', 'Jones', 35, 'emma@gmail.com', '888', 'New York', 2), -- Sara ka client
(3, 'David', 'Brown', 32, 'david@gmail.com', '999', 'Sydney', 3), -- Bilal ka client
(4, 'Sophia', 'Wilson', 29, 'sophia@gmail.com', '4444', 'Dubai', 5), -- Hamza ka client
(5, 'Chris', 'Evans', 31, 'chris@gmail.com', '5555', 'Toronto', NULL); -- koi employee link nahi

SELECT * FROM Client;

CREATE TABLE Project (
    id INT PRIMARY KEY,
    empID INT,
    name VARCHAR(50),
    startdate DATE,
    clientID INT,
    FOREIGN KEY (empID) REFERENCES Employee(id),
    FOREIGN KEY (clientID) REFERENCES Client(id)
);
INSERT INTO Project (id, empID, name, startdate, clientID) VALUES
(1, 1, 'ERP System', '2024-01-15', 1),   -- Ali + John
(2, 2, 'E-Commerce', '2024-02-20', 2),   -- Sara + Emma
(3, 3, 'Banking App', '2024-03-10', 3),  -- Bilal + David
(4, 5, 'CRM Tool', '2024-04-05', 4),     -- Hamza + Sophia
(5, 4, 'Hospital Mgmt', '2024-05-12', NULL); -- Ayesha ka project, client missing

SELECT * FROM Project;
-- inner join
SELECT e.fname, e.lname, c.first_name, c.last_name
FROM Employee e
INNER JOIN Client c
ON e.id = c.empID;

SELECT e.*,  
       c.* 
FROM Employee AS e
INNER JOIN Client AS c
    ON e.id = c.empID;
--     left join
    SELECT e.*,  
       c.* 
FROM Employee AS e
LEFT JOIN Client AS c
    ON e.id = c.empID;
 --     right  join   
        SELECT e.*,  
       c.* 
FROM Employee AS e
RIGHT JOIN Client AS c
    ON e.id = c.empID;
    
    SELECT e.fname, e.lname, c.first_name AS client_name, p.name AS project_name
FROM Employee e
RIGHT JOIN Project p ON e.id = p.empID
RIGHT JOIN Client c ON p.clientID = c.id;

-- full join
SELECT e.fname, e.lname, c.first_name, c.last_name
FROM Employee e
LEFT JOIN Client c
ON e.id = c.empID
UNION
SELECT e.fname, e.lname, c.first_name, c.last_name
FROM Employee e
RIGHT JOIN Client c
ON e.id = c.empID;
-- Cross join--
SELECT e.*,  
       c.*
FROM Employee AS e
CROSS JOIN Client AS c;
-- -------------------------------------------------------------
-- self join
CREATE TABLE EmployeeForSelfJoin (
    id INT PRIMARY KEY,
    fname VARCHAR(50),
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES Employee(id)
);
INSERT INTO EmployeeForSelfJoin (id, fname, manager_id) VALUES
(1, 'Ali', NULL),      -- CEO (no manager)
(2, 'Sara', 1),        -- Sara ka manager Ali
(3, 'Ahmed', 1),       -- Ahmed ka manager Ali
(4, 'Fatima', 2),      -- Fatima ka manager Sara
(5, 'Hassan', 2),      -- Hassan ka manager Sara
(6, 'Nida', 3);        -- Nida ka manager Ahmed
select * from EmployeeForSelfJoin;

SELECT e.fname AS Employee, m.fname AS Manager
FROM EmployeeForSelfJoin e
LEFT JOIN EmployeeForSelfJoin m
ON e.manager_id = m.id;


SELECT e.fname AS Employee, m.fname AS Manager
FROM EmployeeForSelfJoin e
RIGHT JOIN EmployeeForSelfJoin m
ON e.manager_id = m.id;

SELECT e.fname AS Employee, m.fname AS Manager
FROM EmployeeForSelfJoin e
INNER JOIN EmployeeForSelfJoin m
ON e.manager_id = m.id;


