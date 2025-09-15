use mysql;
CREATE TABLE Customer (
    id INT PRIMARY KEY AUTO_INCREMENT,        -- PRIMARY KEY
    first_name VARCHAR(50) NOT NULL,          -- NOT NULL (empty nahi reh sakta)
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,                -- UNIQUE (duplicate email not allowed)
    age INT CHECK (age > 12),                 -- CHECK (age must be > 12)
    gender CHAR(1) DEFAULT 'M'                -- DEFAULT (agar na do to 'M')
);
CREATE  TABLE Order_Details(
order_id INT PRIMARY KEY,
delivery_date DATE,
order_placed_date DATE,
cust_id INT,
FOREIGN KEY (cust_id) references Customer(id)
);
INSERT INTO Customer (first_name, last_name, email, age, gender)
VALUES ('Ali', 'Khan', 'ali.khan@example.com', 25, 'M');
SELECT * FROM Customer;

-- ❌ 3. Age < 12 (CHECK constraint fail karega
INSERT INTO Customer (first_name, last_name, email, age, gender)
VALUES ('Baby', 'Khan', 'baby.khan@example.com', 5, 'F');

-- ❌ 4. Duplicate email (UNIQUE constraint fail karega)
INSERT INTO Customer (first_name, last_name, email, age, gender)
VALUES ('Ahmed', 'Raza', 'ali.khan@example.com', 28, 'M');

-- ❌ 5. first_name missing (NOT NULL constraint fail karega)
INSERT INTO Customer (last_name, email, age, gender)
VALUES ('Sheikh', 'sheikh@example.com', 22, 'M');

INSERT INTO Order_Details (order_id, delivery_date, order_placed_date, cust_id)
VALUES (101, '2025-09-20', '2025-09-15', 1);  

SELECT * FROM Order_Details;