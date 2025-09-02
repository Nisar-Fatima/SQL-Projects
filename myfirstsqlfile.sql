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
SELECT bin_col, HEX(bin_col) ;
SELECT bin_col, LENGTH(bin_col) ;
SELECT BIN(bin_col) FROM binary_demo;
-- --------------case sensitivity in binary--------------------- 
CREATE TABLE demo_ci_unique (
    name VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci UNIQUE
);

INSERT INTO demo_ci_unique VALUES ('a');
INSERT INTO demo_ci_unique VALUES ('A'); -- ⚠️ yaha error ayega
-- ------------------------------------------------------

CREATE TABLE varbinary_demo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    token VARBINARY(32)  -- up to 32 bytes
);
-- 3. Insert plain string (MySQL will convert to binary automatically)
INSERT INTO varbinary_demo (token) VALUES ('hello');  

-- 4. Retrieve data
SELECT id, HEX(token) AS readable_token FROM varbinary_demo;

CREATE TABLE wrong_default (
    key_value VARBINARY(64) DEFAULT 'hello'
);
describe wrong_default

