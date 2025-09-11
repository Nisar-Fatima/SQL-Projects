SHOW DATABASES;
USE temp;
SHOW TABLES;
CREATE TABLE person(
id INT,
name CHAR(10) ,
fathername VARCHAR(5)
);
CREATE TABLE char_demo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    country_code CHAR(3)   -- always 3 characters
);
INSERT INTO char_demo (country_code) VALUES ('PK');   -- stored as 'PK ' (with space)
INSERT INTO char_demo (country_code) VALUES ('USA');  -- exact 3 chars
SELECT * FROM char_demo;
-- Error / Special Situations
INSERT INTO char_demo (country_code) VALUES ('PAKISTAN');
-- ------------------------------------------------------------------------


-- VARCHAR Example
CREATE TABLE varchar_demo (
    name VARCHAR(50)  -- Stores up to 50 characters (variable length)
);
INSERT INTO varchar_demo (name) VALUES ('Ali');  -- Stored as 'Ali'
INSERT INTO varchar_demo (name) VALUES (REPEAT('a', 50));  -- ✅ Stored 50 chars
SELECT * FROM varchar_demo;
INSERT INTO varchar_demo (name) VALUES (REPEAT('a', 60)); -- ❌ Error: Data too long
-- ------------------------------------------------------------------------


-- binary_demo Example
CREATE TABLE binary_demo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    bin_col BINARY(5)   -- fixed length 5 bytes
);
-- Case 1: Insert 3 bytes (shorter than size 5)
INSERT INTO binary_demo (bin_col) VALUES ('abc');
-- Storage: 'abc\0\0'   (null bytes added till length = 5)

-- Case 2: Insert exact size
INSERT INTO binary_demo (bin_col) VALUES ('12345');
-- Storage: '12345'
-- Case 3: Insert longer than size → ❌ Error (truncate + warning/error depending on SQL mode)
INSERT INTO binary_demo (bin_col) VALUES ('abcdef');

-- HEX and LENGTH BIN fuction
-- SELECT bin_col, HEX(bin_col) ;
SELECT bin_col, LENGTH(bin_col) ;
SELECT (bin_col) FROM binary_demo;

-- ------------------------------------------------------

CREATE TABLE varbinary_demo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    token VARBINARY(32)  -- up to 32 bytes
);
-- 3. Insert plain string (MySQL will convert to binary automatically)
INSERT INTO varbinary_demo (token) VALUES ('hello');  

-- 4. Retrieve data
SELECT 
    id, 
    token,                 -- original binary column
    HEX(token) AS readable_token  -- hex readable form
FROM varbinary_demo;


CREATE TABLE wrong_default (
    key_value VARBINARY(64) DEFAULT 'hello'
);
describe wrong_default;
-- -----------------------------------------------------------------
CREATE TABLE tinyblob_demo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    icon TINYBLOB
);

-- Insert binary data (small string stored as binary)
INSERT INTO tinyblob_demo (icon) VALUES ('abc');
-- Retrieve in readable form
SELECT id, HEX(icon) AS hex_value
FROM tinyblob_demo;
-- --------------------------------------------------------------------
CREATE TABLE enum_demo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    gender ENUM('male', 'female', 'other')
);

-- ✅ Valid inserts
INSERT INTO enum_demo (gender) VALUES ('male');
INSERT INTO enum_demo (gender) VALUES ('female');

-- ❌ Invalid insert
INSERT INTO enum_demo (gender) VALUES ('unknown');
-- Stores '' (empty string) and raises a warning

-- Retrieve
SELECT id, gender FROM enum_demo;
-- ------------------------------------------------------------
CREATE TABLE default_enum (
    role ENUM('admin','user','guest','') DEFAULT 'user'
);
INSERT INTO default_enum (role) VALUES (''); -- insert without role
-- ---------------------------------------------------------
CREATE TABLE user_profiles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    hobbies SET('reading','sports','music','travel','gaming')
);
DROP TABLE IF EXISTS user_profiles;
CREATE TABLE user_profiles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    hobbies SET('reading','sports','music','travel','gaming')
);
describe user_profiles;
INSERT INTO user_profiles (name, hobbies)
VALUES ('Ali', 'reading');
INSERT INTO user_profiles (name, hobbies)
VALUES ('Sara', 'reading,music');
INSERT INTO user_profiles (name, hobbies)
VALUES ('Ahmed', '');
SELECT id, name, hobbies FROM user_profiles;
INSERT INTO user_profiles (name, hobbies)
VALUES ('Zara', 'dancing');
INSERT INTO user_profiles (name, hobbies)
VALUES ('Usman', 'reading,reading');
INSERT INTO user_profiles (name, hobbies)
VALUES ('Nida', 'Reading');
INSERT INTO user_profiles (name, hobbies)
VALUES ('Hina', 'reading,dancing');
INSERT INTO user_profiles (name, hobbies)
VALUES ('Nida', 'READING');


CREATE TABLE demo_set_bin (
  hobbies SET('reading','music','sports') CHARACTER SET utf8 COLLATE utf8_bin
);

INSERT INTO demo_set_bin VALUES ('READING');
INSERT INTO demo_set_bin VALUES ('reading');

SELECT * FROM demo_set_bin 

