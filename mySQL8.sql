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
