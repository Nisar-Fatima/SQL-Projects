use mysql;
show tables;
describe Customer;
CREATE  TABLE Order_Details(
order_id INT PRIMARY KEY,
delivery_date DATE,
order_placed_date DATE,
cust_id INT,
FOREIGN KEY (cust_id) references Customer(id)
);
CREATE  TABLE Order_Details(
order_id INT PRIMARY KEY,
delivery_date DATE,
order_placed_date DATE,
cust_id INT,
FOREIGN KEY (cust_id) references Customer(id)
);
-- ALTER Operations (Schema Change ke liye)(DDL)
ALTER TABLE Customer ADD phone VARCHAR(20) UNIQUE;
SELECT * from Customer;

ALTER TABLE Customer modify age tinyint;
describe customer;

ALTER TABLE Customer change column last_name surname varchar(50);
describe customer;

ALTER TABLE Customer drop column phone;
describe customer;

ALTER TABLE Customer RENAME TO Customer_Details;
describe customer; -- yha pr error a jayee ga kio k customer table exist nahi krta kio ab us ka name customer_Details hai

ALTER TABLE Customer_Details RENAME COLUMN first_name TO name;
describe Customer_Details;

-- DML(insert keyword)
use mysql;
INSERT INTO Customer_Details ( name, surname, email, age, gender)
VALUES ( 'Ali', 'Khan', 'ali@example.com', 25, 'M');
select * from Customer_Details;

INSERT INTO Customer_Details (name, surname, email, age, gender)
VALUES
('Usman', 'Shaikh', 'usman@example.com', 28, 'M'),
('Zara', 'Ali', 'zara@example.com', 21, 'F'),
('Bilal', NULL, 'bilal@example.com', 35, 'M');
select * from Customer_Details;

INSERT INTO Customer_Details (name, email, age)
VALUES ('Sara', 'sara@example.com', 30);
select * from Customer_Details;

use mysql;
INSERT INTO Customer_Details (name, surname, email, age, gender)
SELECT first_name, last_name, email, age, gender FROM temp.Customer_Backup;
select * from Customer_Details;

INSERT INTO Order_Details (order_id, delivery_date, order_placed_date, cust_id) VALUES
(101, '2025-09-20', '2025-09-15', 4), -- Ali ka order
(102, '2025-09-22', '2025-09-16', 4), -- Sara ka order
(103, '2025-09-25', '2025-09-17', 5), -- Ali ka 2nd order
(104, '2025-09-30', '2025-09-18', 6), -- Ahmad ka order
(105, '2025-10-05', '2025-09-19', 6); -- Hina ka order
-- DML(update keyword)
SET SQL_SAFE_UPDATES=0;

UPDATE Customer_Details
SET age = 26, surname = 'Ahmad'
WHERE id = 1;
select * from Customer_Details;

UPDATE Customer_Details
SET gender = 'F'
WHERE age < 25;
select * from Customer_Details;

UPDATE Customer_Details
SET age = age + 1;
select * from Customer_Details;

UPDATE Customer_Details
SET age = age + 1
ORDER BY id
LIMIT 5;
select * from Customer_Details;

UPDATE Customer_Details
SET age = age - 1
ORDER BY id
LIMIT 5;
select * from Customer_Details;

UPDATE Customer_Details
SET age = CASE
            WHEN age < 25 THEN 18
            WHEN age = 36 THEN 30
            ELSE age
          END;
select * from Customer_Details;
-- -----ON UPDATE CASCADE------
use mysql;
CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100)
);
CREATE TABLE Student (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
        ON UPDATE CASCADE
);
-- Departments
INSERT INTO Department (dept_id, dept_name) VALUES
(1, 'Computer Science'),
(2, 'Electrical Engineering');

-- Students linked to departments
INSERT INTO Student (roll_no, name, dept_id) VALUES
(101, 'Ali', 1),
(102, 'Sara', 1),
(103, 'Usman', 2);

select * from Student;

UPDATE Department
SET dept_id = 10
WHERE dept_id = 1;

select * from Student;
-- ------------on delete cascade-----------
ALTER TABLE order_details
DROP FOREIGN KEY order_details_ibfk_1;

ALTER TABLE Order_Details
ADD CONSTRAINT order_details_ibfk_1
FOREIGN KEY (cust_id) REFERENCES Customer_Details(id)
ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM Customer_Details WHERE id = 4;
select * from Customer_Details;
select * from order_details;
----- on delete null
CREATE TABLE Customer_Details1 (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);
INSERT INTO Customer_Details1 (id, name) VALUES
(1, 'Ali'),
(2, 'Sara'),
(3, 'Usman'),
(4, 'Ayesha');
CREATE TABLE Order_Details1 (
    order_id INT PRIMARY KEY,
    delivery_date DATE,
    order_placed_date DATE,
    cust_id INT,
    FOREIGN KEY (cust_id) REFERENCES Customer_Details1(id) ON DELETE SET NULL
);
INSERT INTO Order_Details1 (order_id, delivery_date, order_placed_date, cust_id)
VALUES
(101, '2025-09-10', '2025-09-05', 1),  -- Ali
(102, '2025-09-11', '2025-09-06', 4),  -- Ayesha
(103, '2025-09-12', '2025-09-07', 4),  -- Ayesha
(104, '2025-09-13', '2025-09-08', 2);  -- Sara
select * from Customer_Details1;
select * from Order_Details1;
delete from Customer_Details1 where id =1;
select * from Customer_Details1;
select * from Order_Details1;




CREATE TABLE Customer3 (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);
INSERT INTO Customer3 (id, name, city) VALUES
(1, 'Ali', 'Lahore'),
(2, 'Sara', 'Karachi');

select * from customer3;
replace INTO Customer3 (id, name,city) VALUES
(1, 'Ahamd', 'faisalabad');
select * from customer3;



-- 3 syntax of relace keyword
replace INTO Customer3 (id, name) VALUES (1, 'Ahamd');

replace into customer set id='1', name='Ahmad',city='Faisalabad';
replace into customer(id,name,city)

select id,cnme,city from customer_backup where id=4;



