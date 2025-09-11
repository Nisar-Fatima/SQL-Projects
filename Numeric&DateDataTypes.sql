CREATE TABLE bit_demo (
    id INT PRIMARY KEY,
    flag BIT(1)        -- single bit (true/false)
);

INSERT INTO bit_demo VALUES (1, b'1');   -- binary literal (true)
INSERT INTO bit_demo VALUES (2, b'0');   -- binary literal (false)

SELECT id, flag FROM bit_demo;

CREATE TABLE bitmask_demo (
    id INT PRIMARY KEY,
    permissions BIT(4)   -- 4 bits
);

-- Insert using binary literals
INSERT INTO bitmask_demo VALUES (1, b'1001');  -- read+delete
INSERT INTO bitmask_demo VALUES (2, b'1111');  -- all permissions
INSERT INTO bitmask_demo VALUES (3, b'0000');  -- no permissions

-- Select with HEX/ BIN for readability
SELECT id, BIN(permissions+0) AS bin_value, HEX(permissions) AS hex_value
FROM bitmask_demo;

CREATE TABLE wrong_size (
    flag BIT(70)   -- ❌ Only 1–64 allowed
);
CREATE TABLE small_bit (
    val BIT(3)   -- only 3 bits (max b'111' = 7 decimal)
);

INSERT INTO small_bit VALUES (b'1111');  -- ❌ 4 bits
CREATE TABLE wrong_insert (
    flag BIT(2)
);

INSERT INTO wrong_insert VALUES ('11');   -- ❌ MySQL treats this as string
-- -------------------------------------------------------------------
CREATE TABLE bool_demo (
    id INT PRIMARY KEY,
    is_active BOOLEAN   -- alias for TINYINT(1)
);

INSERT INTO bool_demo VALUES (1, TRUE);   -- MySQL stores as 1
INSERT INTO bool_demo VALUES (2, FALSE);  -- MySQL stores as 0
INSERT INTO bool_demo VALUES (3, 5);      -- Any nonzero = true

SELECT id, is_active FROM bool_demo;

CREATE TABLE strict_bool (
    id INT PRIMARY KEY,
    flag BOOLEAN CHECK (flag IN (0,1))
);

INSERT INTO strict_bool VALUES (1, 1);   -- ✅
INSERT INTO strict_bool VALUES (2, 0);   -- ✅
INSERT INTO strict_bool VALUES (3, 2);   -- ❌ not allowed

CREATE TABLE wrong_bool (
    flag BOOL(5)   -- ❌ length not allowed
);
CREATE TABLE bool_text (
    id INT PRIMARY KEY,
    flag BOOLEAN
);

INSERT INTO bool_text VALUES (1, 'yes');  -- ❌ invalid value

CREATE TABLE user_accounts (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    is_active BOOLEAN CHECK (is_active IN (0,1)),     -- only 0 or 1 allowed
    is_verified BOOLEAN CHECK (is_verified IN (0,1))  -- only 0 or 1 allowed
);

-- ✅ Valid inserts
INSERT INTO user_accounts VALUES (1, 'Ali', 1, 0);   -- active, not verified
INSERT INTO user_accounts VALUES (2, 'Sara', 0, 1);  -- inactive, verified
INSERT INTO user_accounts VALUES (3, 'Fatima', 1, 1);-- active, verified
SELECT user_id, username, is_active, is_verified
FROM user_accounts;

-- -------------------------------------------------------------------
CREATE TABLE int_demo (
    id INT PRIMARY KEY,
    tiny_col TINYINT,
    small_col SMALLINT,
    medium_col MEDIUMINT,
    int_col INT,
    big_col BIGINT
);

INSERT INTO int_demo VALUES
(1, 127, 32767, 8388607, 2147483647, 9223372036854775807); -- max signed values
SELECT * FROM int_demo;

CREATE TABLE tinyint_demo (
    val TINYINT
);
INSERT INTO tinyint_demo VALUES (200);   -- ❌ 200 > 127

CREATE TABLE smallint_unsigned_demo (
    val SMALLINT UNSIGNED
);
INSERT INTO smallint_unsigned_demo VALUES (-100);  -- ❌ not allowed

CREATE TABLE big_demo (
    val BIGINT
);
INSERT INTO big_demo VALUES (99999999999999999999); -- ❌ too big
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,                   -- Employee unique ID (INT: 2B range)
    age TINYINT UNSIGNED CHECK (age BETWEEN 18 AND 65),  
        -- TINYINT UNSIGNED (0–255), age only 18–65 allowed

    years_of_service SMALLINT UNSIGNED,       
        -- SMALLINT (0–65k) enough for service years

    salary INT UNSIGNED,                      
        -- INT UNSIGNED (0–4B), salary must be positive

    bonus BIGINT UNSIGNED                     
        -- BIGINT (huge range, used for lifetime bonus or big payouts)
);

-- ✅ Valid inserts
INSERT INTO employees VALUES (1, 25, 2, 50000, 100000);
INSERT INTO employees VALUES (2, 40, 15, 120000, 5000000);

-- ❌ Invalid inserts
-- Age out of range
INSERT INTO employees VALUES (3, 70, 20, 100000, 200000);

-- Negative salary
INSERT INTO employees VALUES (4, 30, 5, -5000, 1000);

-- Salary too large
INSERT INTO employees VALUES (5, 28, 2, 99999999999, 0);
SELECT emp_id, age, years_of_service, salary, bonus 
FROM employees;
-- --------------------------------------------------------- 
CREATE TABLE salaries (
    id INT,
    salary DECIMAL(8,2)   -- max = 999,999.99
);

INSERT INTO salaries VALUES
(1, 12345.67),
(2, 999999.99);   -- ✅ max allowed
select * from salaries;

INSERT INTO salaries VALUES
(3, 1000000.00);   -- ❌ ERROR (out of range, > 999,999.99)

INSERT INTO salaries VALUES
(4, 123.456);   -- ❌ ERROR (only 2 digits after decimal allowed)
CREATE TABLE default_decimal (
    val DECIMAL
);

INSERT INTO default_decimal VALUES
(1234567890);   -- ✅ DECIMAL(10,0)
INSERT INTO default_decimal VALUES
(123.45);       -- ❌ ERROR (scale=0, decimals not allowed)
select * from default_decimal;

CREATE TABLE prices (
    price DECIMAL(6,2) UNSIGNED
);

INSERT INTO prices VALUES (123.45);   -- ✅
INSERT INTO prices VALUES (-99.99);   -- ❌ ERROR (negative not allowed)
select * from prices;

CREATE TABLE invoice (
    id INT(4) ZEROFILL,
    amount DECIMAL(6,2) ZEROFILL
);

INSERT INTO invoice VALUES (12, 45.6);
select * from invoice;
-- -------------------------------
CREATE TABLE employee_dates (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    dob DATE,          -- Date of Birth
    joining_date DATE  -- Date of Joining
);

-- ✅ Valid Inserts
INSERT INTO employee_dates (name, dob, joining_date)
VALUES ('Ali', '1999-12-15', '2022-06-01');

INSERT INTO employee_dates (name, dob, joining_date)
VALUES ('Sara', '2001-03-25', '2023-01-10');

-- 👀 View Data
SELECT * FROM employee_dates;
-- ----------------------------------------
CREATE TABLE event_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    event_name VARCHAR(50),
    created_at DATETIME(3) DEFAULT CURRENT_TIMESTAMP(3),
    updated_at DATETIME(6) DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6)
);

-- ✅ Valid Inserts
INSERT INTO event_logs (event_name, created_at)
VALUES ('Login', '2025-09-10 16:30:45.123');

INSERT INTO event_logs (event_name)
VALUES ('File Upload');  -- created_at auto CURRENT_TIMESTAMP set karega

SELECT * FROM event_logs;
-- -----------------------------------------
CREATE TABLE user_activity (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50),
    login_time TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP(3),
    last_action TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6)
);

-- ✅ Valid Insert
INSERT INTO user_activity (username, login_time)
VALUES ('alice', '2025-09-10 14:30:15.321');

-- ✅ Auto current timestamp (login_time auto set hoga)
INSERT INTO user_activity (username)
VALUES ('bob');

-- ✅ Auto ON UPDATE test
UPDATE user_activity
SET username = 'bob_updated'
WHERE id = 2;

SELECT * FROM user_activity;
-- Show UTC vs local time
SELECT UTC_TIMESTAMP(), NOW();
--  --------------------------------------------------
CREATE TABLE work_shifts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(50),
    shift_start TIME(0),
    shift_end TIME(0),
    break_duration TIME(2)
);

-- ✅ Valid Inserts
INSERT INTO work_shifts (employee_name, shift_start, shift_end, break_duration)
VALUES ('Alice', '09:00:00', '17:00:00', '01:30:00');

INSERT INTO work_shifts (employee_name, shift_start, shift_end, break_duration)
VALUES ('Bob', '08:15:00', '16:45:00', '00:45:30.25');

SELECT * FROM work_shifts;
-- -------------------------------------------------------- 
CREATE TABLE vehicles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    model_name VARCHAR(50),
    model_year YEAR
);

-- ✅ Valid Inserts
INSERT INTO vehicles (model_name, model_year)
VALUES ('Toyota Corolla', 2025);

INSERT INTO vehicles (model_name, model_year)
VALUES ('Honda Civic', 2005);

INSERT INTO vehicles (model_name, model_year)
VALUES ('Old Unknown Model', 0000);
INSERT INTO vehicles (model_name, model_year)
VALUES ('Empty Test', '');
SELECT * FROM vehicles;


