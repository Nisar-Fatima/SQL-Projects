show databases;
CREATE TABLE IF NOT EXISTS student;
CREATE  TABLE student(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50),
age INT ,
course VARCHAR(50)
);
SELECT * from student;

ALTER TABLE student ADD email VARCHAR(50);
SELECT * from student;

ALTER TABLE student MODIFY age SMALLINT;
DESCRIBE student;

ALTER TABLE student RENAME COLUMN course TO subject;
SELECT * from student;

ALTER TABLE student DROP COLUMN email;
SELECT * from student;

INSERT INTO student(name, age, subject) VALUES
 ('nisar fatima',23,'DBMS'),
('Sara', 22, 'Physics'),
('Usman', 21, 'Chemistry');
SELECT * from student;

TRUNCATE student;
SELECT * from student;

RENAME TABLE student TO learners;
DESCRIBE learners;

ALTER TABLE learners RENAME COLUMN course TO subject;
SELECT * from learners;

INSERT INTO learners (name, age, subject) VALUES
('Ali Khan', 20, 'Computer Science'),
('Sara Ahmed', 22, 'Mathematics'),
('Bilal Hussain', 19, 'Physics'),
('Ayesha Noor', 21, 'Chemistry'),
('Usman Malik', 23, 'English Literature'),
('Fatima Zahra', 20, 'Biology'),
('Hamza Ali', 24, 'Economics'),
('Zainab Raza', 22, 'Statistics'),
('Omar Farooq', 21, 'History'),
('Hira Shah', 19, 'Psychology');
-- -------------------------------------------
SELECT * from learners;
SELECT name, subject from learners;
SELECT * from learners WHERE age=20;
SELECT * from learners order by age ;
SELECT * from learners order by name DESC;
SELECT subject, COUNT(*) FROM learners GROUP BY subject;
SELECT AVG(age) FROM learners;
SELECT COUNT(*) FROM learners;
SELECT * from learners;
SELECT 55+13;
SELECT ucase('nisar');
SELECT lcase('NISAR');

-- ----------------------------------------------
UPDATE learners
SET subject = 'Software Engineering', age = 22
WHERE id = 1;
UPDATE learners
SET age = 25
WHERE name = 'Sara';
SELECT * from learners;

DELETE FROM learners WHERE id = 3;
SELECT * from learners;
DELETE FROM learners WHERE name = 'Sara';
DELETE FROM learners WHERE subject = 'Computer Science' AND age < 21;
SELECT * from learners;
-- ---------------------------------------------------
CREATE TABLE accounts (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    balance INT
);

INSERT INTO accounts (id, name, balance) VALUES
(1, 'Account A', 1000),
(2, 'Account B', 500),
(3, 'Account C', 300);
SELECT * from accounts; 

START TRANSACTION;
-- Step 1: Transfer 200 from A → B
UPDATE accounts SET balance = balance - 200 WHERE id = 1;
UPDATE accounts SET balance = balance + 200 WHERE id = 2;
SAVEPOINT sp1;   -- ✅ checkpoint ban gaya

-- Step 2: Transfer 100 from A → C
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 3;
SAVEPOINT sp2;   -- ✅ second checkpoint

-- Oops! mistake -> rollback to sp1 (ignore step 2)
ROLLBACK TO sp1;

COMMIT;
SELECT * from accounts; 
-- ---------------------------------------------------------------
DROP TABLE IF EXISTS Worker;
CREATE TABLE Worker (
    WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    FIRST_NAME CHAR(25),
    LAST_NAME CHAR(25),
    SALARY INT,
    JOINING_DATE DATETIME,
    DEPARTMENT CHAR(25)
);
INSERT INTO Worker 
    (FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT)
VALUES
    ('Nisar',  'Fatima',   100000, '2014-02-20 09:00:00', 'HR'),
    ('Arooba','Asif',    80000, '2014-06-11 09:00:00', 'Admin'),
    ('Hamna',  'Asif',  300000, '2014-02-20 09:00:00', 'HR'),
    ('Fatima', 'Tahir',   500000, '2014-02-20 09:00:00', 'Admin'),
    ('Zarnab',   'Khan',    500000, '2014-06-11 09:00:00', 'Admin'),
    ('Tayyiba ',   'Rafique',    200000, '2014-06-11 09:00:00', 'Account'),
    ('Hafsa',  'Zafar',    75000, '2014-01-20 09:00:00', 'Account'),
    ('Laiba', 'Arraik',  90000, '2014-04-11 09:00:00', 'Admin');
SELECT * from Worker;
CREATE TABLE Bonus (
    BONUS_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    WORKER_REF_ID INT,
    BONUS_AMOUNT INT(10),
    BONUS_DATE DATETIME,
    FOREIGN KEY (WORKER_REF_ID) 
        REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

-- Insert into Bonus table
INSERT INTO Bonus (WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
(1, 5000, '2016-02-20'),
(2, 3000, '2016-06-11'),
(3, 4000, '2016-02-20'),
(1, 4500, '2016-02-20'),
(2, 3500, '2016-06-11');
SELECT * from Bonus;
-- Title Table (child table - references Worker)
CREATE TABLE Title (
    WORKER_REF_ID INT,
    WORKER_TITLE CHAR(25),
    AFFECTED_FROM DATETIME,
    FOREIGN KEY (WORKER_REF_ID) 
        REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);
INSERT INTO Title (WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
(1, 'Manager',       '2016-02-20 00:00:00'),
(2, 'Executive',     '2016-06-11 00:00:00'),
(8, 'Executive',     '2016-06-11 00:00:00'),
(5, 'Manager',       '2016-06-11 00:00:00'),
(4, 'Asst. Manager', '2016-06-11 00:00:00'),
(7, 'Executive',     '2016-06-11 00:00:00'),
(6, 'Lead',          '2016-06-11 00:00:00'),
(3, 'Lead',          '2016-06-11 00:00:00');
SELECT * from Title;
SELECT * from Worker WHERE DEPARTMENT ='HR';
SELECT * from Worker WHERE SALARY >50000;
-- --BETWEEN 
SELECT * from Worker WHERE SALARY BETWEEN 80000 AND 3000000;
SELECT * FROM EMPLOYEE WHERE age BETWEEN 25 AND 50;
-- --AND,OR,NOT -- 
SELECT * 
FROM Worker 
WHERE DEPARTMENT IN ('HR', 'Admin');

SELECT * 
FROM Worker 
WHERE DEPARTMENT  NOT IN ('HR', 'Admin');

SELECT * FROM Worker
WHERE DEPARTMENT = 'HR'
  AND SALARY > 150000;
  
--   IS NULLL  
INSERT INTO Worker (FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT)
VALUES ('Sara', 'Khan', NULL, '2015-03-15 09:00:00', 'IT');
SELECT * from Worker;
-- Find all workers whose salary is NULL
SELECT * FROM Worker
WHERE SALARY IS NULL;
DELETE from Worker WHERE WORKER_ID=25;
SELECT * from Worker;

-- wild cards
SELECT * FROM Worker
WHERE FIRST_NAME LIKE 'N%';
SELECT * FROM Worker
WHERE FIRST_NAME LIKE 'N____';
SELECT * FROM Worker
WHERE FIRST_NAME LIKE 'N_';

-- order by
SELECT * from Worker ORDER BY SALARY DESC;
SELECT * from Worker ORDER BY FIRST_NAME DESC;
SELECT FIRST_NAME from Worker ORDER BY SALARY DESC;

-- distinct
SELECT DISTINCT DEPARTMENT
FROM Worker;
SELECT DEPARTMENT from Worker  GROUP BY DEPARTMENT;
-- Group by
SELECT COUNT(*) AS total_employees
FROM Worker;
SELECT DEPARTMENT ,COUNT(*) AS total_employees
FROM Worker
GROUP BY DEPARTMENT;

SELECT AVG(SALARY) from Worker;
SELECT DEPARTMENT ,avg(SALARY)  from Worker GROUP BY DEPARTMENT;

SELECT DEPARTMENT ,MIN(SALARY)   from Worker GROUP BY DEPARTMENT;
SELECT MIN(SALARY) from Worker;

SELECT DEPARTMENT ,MAX(SALARY)   from Worker GROUP BY DEPARTMENT;
SELECT MAX(SALARY) from Worker;

SELECT DEPARTMENT ,SUM(SALARY)   from Worker GROUP BY DEPARTMENT;
SELECT SUM(SALARY) from Worker;

-- group by having
SELECT DEPARTMENT ,count(*) from Worker GROUP BY DEPARTMENT HAVING COUNT(*)> 6;
SELECT DEPARTMENT ,count(DEPARTMENT) from Worker GROUP BY DEPARTMENT HAVING COUNT(DEPARTMENT)> 6;    