-- CREATING THE DATABASE

CREATE DATABASE IF NOT EXISTS Sales;
-- or
CREATE SCHEMA IF NOT EXISTS Sales;

SHOW DATABASES;

USE Sales;

SHOW TABLES;

CREATE TABLE sales
(
	purchase_number INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	date_of_purchase DATE NOT NULL,
	customer_id INT,
	item_code VARCHAR(10) NOT NULL
);

-- //exercise
CREATE TABLE customer
(
	customer_id INT,
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	email_address VARCHAR(255),
	number_of_complaints INT
);
-- //

-- //exercise
USE Sales;
SELECT * FROM sales;

SELECT * FROM Sales.sales;
-- //

DROP TABLE sales;

CREATE TABLE sales
(
	purchase_number INT NOT NULL AUTO_INCREMENT,
	date_of_purchase DATE,
	customer_id INT,
	item_code VARCHAR(10),
PRIMARY KEY (purchase_number)
);


-- //exercise
DROP TABLE customer;

CREATE TABLE customers
(
	customer_id INT,
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	email_address VARCHAR(255),
	number_of_complaints INT,
PRIMARY KEY(customer_id)
);

CREATE TABLE items
(
	item_code VARCHAR(255),
	item VARCHAR(255),
	unit_price NUMERIC(10, 2),
	company_id VARCHAR(255),
PRIMARY KEY (item_code)
);

CREATE TABLE companies
(
	company_id VARCHAR(255),
	company_name VARCHAR(255),
	headquarters_phone_number INT(12),
PRIMARY KEY (company_id)
);
-- //
DROP TABLE sales;

CREATE TABLE sales
(
	purchase_number INT NOT NULL AUTO_INCREMENT,
	date_of_purchase DATE,
	customer_id INT,
	item_code VARCHAR(10),
PRIMARY KEY (purchase_number),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- if we forget to add the foreign key, 
-- then it is viable to alter the existing table.

DROP TABLE sales;

CREATE TABLE sales
(
	purchase_number INT NOT NULL AUTO_INCREMENT,
	date_of_purchase DATE,
	customer_id INT,
	item_code VARCHAR(10),
PRIMARY KEY (purchase_number)
);

ALTER TABLE sales
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE;

ALTER TABLE sales
DROP FOREIGN KEY sales_ibfk_1;

-- //exercise  
DROP TABLE sales;
DROP TABLE customers;
DROP TABLE items;
DROP TABLE companies;
-- 

CREATE TABLE customers (
    customer_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints INT,
PRIMARY KEY (customer_id),
UNIQUE KEY (email_address)
);

DROP TABLE customers;

CREATE TABLE customers (
    customer_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints INT,
PRIMARY KEY (customer_id)
);

-- the unique key can be added separately as well.
ALTER TABLE customers
ADD UNIQUE KEY (email_address);

ALTER TABLE customers
DROP INDEX email_address;

-- //exercise
DROP TABLE customers;

CREATE TABLE customers(
	customer_id INT AUTO_INCREMENT,
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	email_address VARCHAR(255),
	number_of_complaints INT,
PRIMARY KEY (customer_id)
);

ALTER TABLE customerscustomerscustomerscustomers
ADD COLUMN gender ENUM('M','F') AFTER last_name;

INSERT INTO customers(first_name, last_name, gender, 
email_address, number_of_complaints)
VALUES ('John', 'Mackinley', 'M', 'john.mckinley@365careers.com', 0);
-- //

ALTER TABLE customers
CHANGE COLUMN number_of_complaints number_of_complaints INT DEFAULT 0;

INSERT INTO customers(first_name, last_name, gender)
VALUES ('Peter', 'Figero', 'M');

ALTER TABLE customers
ALTER COLUMN number_of_complaints DROP DEFAULT;

-- // exercise
CREATE TABLE companies
(
	company_id VARCHAR(255),
    company_name VARCHAR(255),
    headquarters_phone_number VARCHAR(255) DEFAULT "X",
PRIMARY KEY (company_id),
UNIQUE KEY (headquarters_phone_number)
);

DROP TABLE companies;
-- //

CREATE TABLE companies
(
	company_id INT AUTO_INCREMENT,
    headquarters_phone_number VARCHAR(255),
    company_name VARCHAR(255) NOT NULL,
PRIMARY KEY (company_id)
);

ALTER TABLE companies
MODIFY company_name VARCHAR(255) NULL;

ALTER TABLE companies
CHANGE COLUMN company_name company_name VARCHAR(255) NOT NULL;

-- expect an error
-- INSERT INTO companies (headquarters_phone_number)
-- VALUES ('+1 (202) 555-0196');

INSERT INTO companies (headquarters_phone_number, company_name)
VALUES ('+1 (202) 555-0196', 'Company A');

-- //exercise
ALTER TABLE companies
CHANGE COLUMN headquarters_phone_number headquarters_phone_number VARCHAR(255) NOT NULL;

ALTER TABLE companies
MODIFY headquarters_phone_number VARCHAR(255) NULL;
-- //

