######################################## mySQL by Prashant ################################################

# ------------------------------------------------------CONNECTING---------------------------------------------------------------
# go in sql mode from js mode
\sql

# connecting to the server
\connect root@localhost

# --------------------------------------------------ENTERING QUERIES---------------------------------------------------------------
# checking version number of the server
SELECT VERSION(), CURRENT_DATE

# using as a simple calculator
SELECT 4*(9+2)

# Entering multiline queries
SELECT VERSION(); SELECT NOW()

# Getting the user
SELELCT USER()

# Prompt	Meaning
# mysql>	Ready for new query
# ->	Waiting for next line of multiple-line query
# '>	Waiting for next line, waiting for completion of a string that began with a single quote (')
# ">	Waiting for next line, waiting for completion of a string that began with a double quote (")
# `>	Waiting for next line, waiting for completion of an identifier that began with a backtick (`)
# '/*'>	Waiting for next line, waiting for completion of a comment that began with '/*' ( like in C programming)

# The '> and "> prompts occur during string collection
# The `> prompt is similar to the '> and "> prompts, but indicates that you have begun but not completed a backtick-quoted identifier.
# ------------------------------------------------------------CREATING AND USING A DATABASE------------------------------------------------------------------------------

# showing databses
SHOW DATABASES;

# Accesing a databse
USE <database name>

# You can use the test database (if you have access to it) for the examples that follow, but anything you create in that database can be removed by anyone else with access to it. For this
# reason, you should probably ask your MySQL administrator for permission to use a database of your own. Suppose that you want to call yours menagerie. The administrator needs to 
# execute a statement like this:
GRANT ALL ON <database>.* TO 'my_sql_user'@'my_client_host'

# Showing existing tables
SHOW TABLES;

# Creating a table
CREATE TABLE pet(
name VARCHAR(15),
owner VARCHAR(50),
species VARCHAR(20),
sex CHAR(1),
birth DATE,
death DATE
);

# To get the information about the table
DESCRIBE <tablename>

# Loading the data in the tables
# we can use either INSERT or LOAD DATA to import from a text file
# to load create a text file with tab separated entries
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/pet.txt" INTO TABLE pet
LINES TERMINATED BY '\r\n';

# In text file use \N to represent NULL values

# by default the values are assumed to tab tab separated, we can use custom separation by adding the statement 
FIELDS TERMINATED BY ','

# To exclude the header line of the columns from the table data ignore the first line
IGNORE 1 LINES;

# if the above throws secure_file_priv error, it is beacuse it is limiting the local directories that we can use so we move the files to import to the folder that it permits
# that specified directory can be seen using the command
SHOW VARIABLES LIKE "secure_file_priv";

# Inserting using INSERT
INSERT INTO pet
VALUES ('Puffball','Diane','hamster','f','1999-03-30',NULL),
('Auro','Ankit','dog','m','2016-03-30','2019-07-02'),
('Candy','Shivam','dog','f','2019-04-10',NULL),
('Mees','Laura','cat','f','2012-10-11','2015-10-22'),
('Bruno','Meha','dog',NULL,'2014-11-01','2018-04-13'); 

#------------------------------------------------------------RETRIEVING INFORMATION FROM A TABLE--------------------------------------------------------------------------------

# using SELECT statement to select all
SELECT * FROM <table>
SELECT name FROM pet

# updating a table
UPDATE pet SET birth = '1999-10-23' WHERE name = 'Auro';

# Selecting particular rows
# String comparisions are normally case insensitive
# So we can say 'Auro' or 'AURO'
# or we can match using some other column like sex
SELECT * FROM pet WHERE sex = 'f';

# we can use AND or OR to use multiple condition checks
SELECT * FROM pet WHERE name = 'auro' AND sex = 'm';
SELECT * FROM pet WHERE (name = 'auro' AND sex = 'm') or (name = 'puffball' AND sec = 'f')

# Selecting particular columns
SELECT name FROM pet;
SELECT name, owner FROM pet WHERE sex = 'f'

# Sorting Rows using ORDER BY, use ASC for ascending and DESC for descending, by default it is ascending.
SELECT * FROM pet ORDER BY name ASC;
SELECT * FROM pet ORDER BY name DESC;

# On using multiple columns for ordering the second one works if the values are same for the first one
SELECT * FROM pet ORDER BY species, sex;

# date calculations
# to determine elements like age we can use the function tIMESTAMPDIFF whose first argument is the unit we want it in and the next two are the columns for difference.
# an alias is made for the calculated column
# we can even use the new calculated column for ordering
SELECT name, birth, CURRENT_DATE(),
TIMESTAMPDIFF(YEAR, birth, CURDATE()) AS AGE
FROM pet
ORDER BY age;

# we can do the similar above procedure for calculating total life using the death column

# we can use inbuilt DATE attributes like MONTH, YEAR for condition check
SELECT * FROM pet
WHERE MONTH(birth) = 10;

# There is a small complication if the current month is December. You cannot merely add one to the month number (12) and look for animals born in month 13, because there is no such # month. Instead, you look for animals born in January (month 1).
# You can write the query so that it works no matter what the current month is, so that you do not have to use the number for a particular month. DATE_ADD() enables you to add a time 
# interval to a given date. If you add a month to the value of CURDATE(), then extract the month part with MONTH(), the result produces the month in which to look for birthdays.
# To get the birthdays in the next month from the current date.

SELECT name, birth FROM pet
WHERE MONTH(birth) = MONTH(DATE_ADD(CURDATE(),INTERVAL 1 MONTH));

# we can also do it as 
SELECT * FROM pet
WHERE MONTH(birth)=MOD(MONTH(CURDATE()),12)+1;

# If a calculation uses invalid dates, the calculation fails and produces warnings

# Working with NULL Values
# To test use IS NULL or IS NOT NULL
SELECT 1 IS NULL, 1 IS NOT NULL;

# We cannot use arithmetic comparison operators such as =, <, or <> to test for NULL, such comparisions only result null
# In MySQL, 0 or NULL means false and anything else means true. The default truth value from a boolean operation is 1.
# To determine which animals are no longer alive use death IS NOT NULL instead of death <> NULL.
# Two NULL values are regarded as equal in a GROUP BY.
# When doing an ORDER BY, NULL values are presented first if you do ORDER BY ... ASC and last if you do ORDER BY ... DESC.
# A common error when working with NULL is to assume that it is not possible to insert a zero or an empty string into a column defined as NOT NULL, but this is not the case.
# These are in fact values, whereas NULL means “not having a value.” We can test this easily enough by using IS [NOT] NULL  
SELECT 0 IS NULL, 0 IS NOT NULL, '' IS NULL, '' IS NOT NULL;

# -----------------------------------------------------------------------PATTERN MATCHING -------------------------------------------------------------------------------------

# SQL pattern matching enables you to use _ to match any single character and % to match an arbitrary number of characters (including zero characters).  
# In MySQL, SQL patterns are case-insensitive by default.   
# Do not use = or <> when you use SQL patterns. Use the LIKE or NOT LIKE comparison operators instead.

# To get names starting with A or a
SELECT * FROM pet WHERE name LIKE 'a%';  

# To get names ending with es, ES, eS or es
SELECT * FROM pet WHERE name LIKE '%es';  

# To get names which at least one a
SELECT * FROM pet WHERE name LIKE '%a%';  

# To get names which having exact 4 letters 
SELECT * FROM pet WHERE name LIKE '____'; 

#The other type of pattern matching provided by MySQL uses extended regular expressions. When you test for a match for this type of pattern, 
# use the REGEXP_LIKE() function (or the REGEXP or RLIKE operators, which are synonyms for REGEXP_LIKE()).

# The following list describes some characteristics of extended regular expressions:

# . matches any single character.

# A character class [...] matches any character within the brackets. For example, [abc] matches a, b, or c. To name a range of characters, use a dash. [a-z] matches any letter, 
# whereas [0-9] matches any digit.

# * matches zero or more instances of the thing preceding it. For example, x* matches any number of x characters, [0-9]* matches any number of digits, and 
# .* matches any number of anything.

# A regular expression pattern match succeeds if the pattern matches anywhere in the value being tested. 
# (This differs from a LIKE pattern match, which succeeds only if the pattern matches the entire value.)

# To anchor a pattern so that it must match the beginning or end of the value being tested, use ^ at the beginning or $ at the end of the pattern.  

# To force a regular expression comparison to be case sensitive, use a case-sensitive collation, or use the BINARY keyword to make one of the strings a binary string, 
# or specify the c match-control character. Each of these queries matches only uppercase A at the beginning of a name

SELECT * FROM pet
WHERE REGEXP_LIKE(name, BINARY  '^A');
SELECT * FROM pet 
WHERE REGEXP_LIKE(name, '^A' COLLATE utf8mb4_0900_as_cs);
SELECT * FROM pet 
WHERE REGEXP_LIKE(name, '^A', 'c');

# To get the names ending with es
SELECT * FROM pet
WHERE REGEXP_LIKE(name, 'es$');

# To get the names containing a
SELECT * FROM pet
WHERE REGEXP_LIKE(name, 'a');

# To get names which having exact 4 letters 
SELECT * FROM pet 
WHERE REGEXP_LIKE(name, '^.....$');

# or we can do it as 
SELECT * FROM pet 
WHERE REGEXP_LIKE(name, '^.{5}$'); 

#-------------------------------------------------------------------------------COUNTING ROWS-------------------------------------------------------------------------

# The COUNT operator is used to count the rows as per the provided condition
SELECT COUNT(*) FROM pet;

# We can use COUNT as aggregate operator for Grouping
SELECT owner, COUNT(*) FROM pet
GROUP BY owner;

# number of animals per sex
SELECT sex, COUNT(*) FROM pet
GROUP BY sex;

# in the outputs the NULL (if occurs) indicates unknown or not available

# to get combinations of multiple columns like species and sex
SELECT species, sex FROM pet
GROUP BY species, sex;

# we can choose only the columns we want for the query
SELECT species, sex FROM pet
WHERE species = 'dog' OR species = 'cat'
GROUP BY species, sex;

#  If we want the number of animals per sex only for animals whose sex is known.  
SELECT species, sex FROM pet
WHERE sex IS NOT NULL
GROUP BY species, sex;

# In ONLY_FULL_GROUP_BY mode the additional columns with COUNT should have the same value for the rows that are aggregated otherwise an error is thrown:
# Notice the output difference in the following two queries

SET sql_mode = '';
SELECT owner, COUNT(*) FROM pet
GROUP BY species;

SET sql_mode = 'ONLY_FULL_GROUP_BY';
SELECT owner, COUNT(*) FROM pet
GROUP BY species;

# -------------------------------------------------------------------- USING MORE THAN ONE TABLE-----------------------------------------------------------------------------

# We can use multiple tables in a single query

# let us create another table
LOAD DATA INFILE"C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/events.txt" INTO TABLE event

# Suppose that you want to find out the ages at which each pet had its litters. We saw earlier how to calculate ages from two dates.
# The litter date of the mother is in the event table, but to calculate her age on that date you need her birth date, which is stored in the pet table.
# This means the query requires both tables:
SELECT pet.name,
TIMESTAMPDIFF(YEAR,birth,date) AS age, remark
FROM pet INNER JOIN event
ON pet.name = event.name
WHERE event.type = 'litter';


# The FROM clause joins two tables because the query needs to pull information from both of them.
# When combining (joining) information from multiple tables, you need to specify how records in one table 
# can be matched to records in the other.
# This is easy because they both have a name column.
#The query uses an ON clause to match up records in the two tables based on the name values.
# The query uses an INNER JOIN to combine the tables. An INNER JOIN permits rows from either 
# table to appear in the result if and only if both tables meet the conditions specified in the ON clause. 
# In this example, the ON clause specifies that the name column in the pet table must match the name column in the event table.
# If a name appears in one table but not the other,
# the row will not appear in the result because the condition in the ON clause fails.
# Because the name column occurs in both tables, you must be specific about which table you mean when referring to the column. 
# This is done by prepending the table name to the column name.


# You need not have two different tables to perform a join. 
# Sometimes it is useful to join a table to itself, if you want to compare records in a table to other records
# in that same table. 

# To make pairs for the pets in the same table
SELECT p1.name, p1.sex, p2.name, p2.sex, p1.species
FROM pet AS p1 INNER JOIN pet AS p2
ON p1.species = p2.species
AND p1.sex = 'f' AND p1.death IS NULL
AND p2.sex = 'm' AND p2.death IS NULL;

#----------------------------------------- GETTING INFORMATION ABOUT DATABASES AND TABLES ------------------------------------

# If we have not yet selected any database, the result is NULL.
# The name of the column in the output produced by the SHOW TABLES statement is always Tables_in_db_name, 
# where db_name is the name of the database.

#If we want to find out about the structure of a table, the DESCRIBE statement is useful; it displays information 
# about each of a table's columns
DESCRIBE pet;
#Field indicates the column name, 
# Type is the data type for the column, 
# NULL indicates whether the column can contain NULL values, 
# Key indicates whether the column is indexed, and Default specifies the column's default value. 
# Extra displays special information about columns: If a column was created with the AUTO_INCREMENT option, 
# the value will be auto_increment rather than empty.

#----------------------------------------- USING MYSQL IN BATCH MODE ------------------------------------------------------

# We have used mysql interactively to enter statements and view the results. 
# We can also run mysql in batch mode. To do this, put the statements we want to run in a file, 
# then tell mysql to read its input from the file:
mysql < mysql_batchFile.sql

#If we are on Windows and have some special characters in the file that cause problems, we can do this:
    #    mysql > C:/Users/prash/Documents/test.sql
    #   source C:/Users/prash/Documents/test.sql

# ------------------------------------- EXAMPLES OF COMMON QUERIES ---------------------------------------------------------

# create populate the table first for the sample:

CREATE TABLE shop (
    article INT UNSIGNED  DEFAULT '0000' NOT NULL,
    dealer  CHAR(20)      DEFAULT ''     NOT NULL,
    price   DECIMAL(16,2) DEFAULT '0.00' NOT NULL,
    PRIMARY KEY(article, dealer));
INSERT INTO shop VALUES
    (1,'A',3.45),(1,'B',3.99),(2,'A',10.99),(3,'B',1.45),
    (3,'C',1.69),(3,'D',1.25),(4,'D',19.95);

# Maximum value in a column:
SELECT MAX(price) FROM shop;
SELECT MAX(article) FROM shop;

# Row with the maximum value of a column
# Three different solutons
SELECT * FROM shop
WHERE price = (SELECT MAX(price) FROM shop);

SELECT s1.article, s1.dealer, s1.price
FROM shop s1
LEFT JOIN shop s2 ON s1.price < s2.price
WHERE s2.article IS NULL;

SELECT article, dealer, price
FROM shop
ORDER BY price DESC
LIMIT 1;

# Maximum of a columnn per group
SELECT article, MAX(price) AS price
FROM shop
GROUP BY article
ORDER BY article;

# The Rows Holding the Group-wise Maximum of a Certain Column
# For each article, find the dealer or dealers with the most expensive price. */
SELECT article, dealer, price
FROM   shop s1
WHERE  price=(
    SELECT MAX(s2.price)
    FROM shop s2
    WHERE s1.article = s2.article
    )
ORDER BY article;
# The preceding example uses a correlated subquery, which can be inefficient. 
# Other possibilities for solving the problem are to use an uncorrelated subquery in the FROM clause, a LEFT JOIN, 
# or a common table expression with a window function.

# Uncorrelated Subquery
SELECT s1.article, dealer, s1.price
FROM shop s1
JOIN (
  SELECT article, MAX(price) AS price
  FROM shop
  GROUP BY article) AS s2
  ON s1.article = s2.article AND s1.price = s2.price
ORDER BY article;

    # Left join
    # The LEFT JOIN works on the basis that when s1.price is at its maximum value, 
    # there is no s2.price with a greater value and thus the corresponding s2.article value is NULL.
    SELECT s1.article, s1.dealer, s1.price
    FROM shop s1
    LEFT JOIN shop s2 ON s1.article = s2.article AND s1.price < s2.price
    WHERE s2.article IS NULL
    ORDER BY s1.article;

    # Common Table
    WITH s1 AS (
   SELECT article, dealer, price,
          RANK() OVER (PARTITION BY article
                           ORDER BY price DESC
                      ) AS `Rank`
     FROM shop
    )
    SELECT article, dealer, price
    FROM s1
    WHERE `Rank` = 1
    ORDER BY article;

# ---------------------------------------- USING USER_DEFINED VARIABLES -----------------------------------------------

# We can employ MySQL user variables to remember results without having to store them in temporary variables in the client.
SELECT @min_price:=MIN(price),@max_price:=MAX(price) FROM shop;
SELECT * FROM shop WHERE price=@min_price OR price=@max_price;

# ---------------------------------------- USING FOREIGN VARIABLES ----------------------------------------------------
 
 CREATE TABLE person (
    id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name CHAR(60) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE shirt (
    id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    style ENUM('t-shirt', 'polo', 'dress') NOT NULL,
    color ENUM('red', 'blue', 'orange', 'white', 'black') NOT NULL,
    owner SMALLINT UNSIGNED NOT NULL REFERENCES person(id),
    PRIMARY KEY (id)
);

INSERT INTO person VALUES (NULL, 'Antonio Paz');

SELECT @last := LAST_INSERT_ID();

INSERT INTO shirt VALUES
(NULL, 'polo', 'blue', @last),
(NULL, 'dress', 'white', @last),
(NULL, 't-shirt', 'blue', @last);

INSERT INTO person VALUES (NULL, 'Lilliana Angelovska');

SELECT @last := LAST_INSERT_ID();

INSERT INTO shirt VALUES
(NULL, 'dress', 'orange', @last),
(NULL, 'polo', 'red', @last),
(NULL, 'dress', 'blue', @last),
(NULL, 't-shirt', 'white', @last);

SELECT s.* FROM person p INNER JOIN shirt s
ON s.owner = p.id
WHERE p.name LIKE 'Lilliana%'
AND s.color <> 'white';

# -------------------------------------------- SEARCHING ON TWO KEYS -------------------------------------------------------

# Using OR
SELECT name,type FROM event
WHERE name = 'Fluffy' or type = 'vet';

#Using UNION
SELECT name, type FROM event
WHERE name= 'Fluffy'
UNION
SELECT name, type FROM event
WHERE type= 'vet';

# -------------------------------------------- CALCULATING VISITS PER DAY ---------------------------------------------------

CREATE TABLE t1 (
    year YEAR,
    month INT UNSIGNED,
    day INT UNSIGNED
);

INSERT INTO t1
VALUES(2000, 1, 1),(2000,1,20),(2000,1,30),(2000,2,2),(2000,2,23),(2000,2,23);

# The example table contains year-month-day values representing visits by users to the page. 
# To determine how many different days in each month these visits occur, we can use this query:
SELECT year,month,BIT_COUNT(BIT_OR(1<<day)) AS days FROM t1
       GROUP BY year,month;
#OR 
SELECT year, month,COUNT(DISTINCT(day)) days FROM t1
GROUP BY year,month;

# -------------------------------------------- USING AUTO-INCREMENT --------------------------------------------------------

# The AUTO_INCREMENT attribute can be used to generate a unique identity for new rows:
CREATE TABLE animals(
id  MEDIUMINT NOT NULL AUTO_INCREMENT,
name CHAR(30) NOT NULL,
PRIMARY KEY (id)
);

INSERT INTO animals(name)
VALUES('dog'),('cat'),('pengiun'),('lax'),('whale'),('ostrich');

# No value was specified for the AUTO_INCREMENT column, so MySQL assigned sequence numbers automatically. 
# You can also explicitly assign 0 to the column to generate sequence numbers, unless the NO_AUTO_VALUE_ON_ZERO SQL mode 
# is enabled.
/* Not working */
    INSERT INTO animals(id,name)
    VALUES (0,'groundhog');

# If the column is declared NOT NULL, it is also possible to assign NULL to the column to generate sequence numbers. 
INSERT INTO animals (id,name) VALUES(NULL,'squirrel');