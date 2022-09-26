USE employees;

SELECT 
    first_name, last_name
FROM
    employees;
    
SELECT 
    *
FROM
    employees;
    
-- //exercise
SELECT 
    dept_no
FROM
    departments;
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Elvis';
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis' AND gender = 'M';
--

-- //exercise
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie' AND gender = 'F';
    
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis' OR first_name = 'Elvis';

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis' AND first_name = 'Elvis';

-- //exercise
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie' OR first_name = 'Aruna';
--

# gives unexpected results
SELECT 
    *
FROM
    employees
WHERE
    last_name = 'Denis' AND gender = 'M' OR gender = 'F';

# after correct precedence
SELECT 
    *
FROM
    employees
WHERE
    last_name = 'Denis' AND (gender = 'M' OR gender = 'F');
    
-- //exercise
SELECT 
    *
FROM
    employees
WHERE
    (first_name = 'Kellie' OR first_name = 'Aruna') AND gender = 'F';
--

# unefficient method
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Cathie' OR first_name = 'Mark' OR first_name = 'Nathan';
    
# efficient method
SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Cathie' , 'Mark', 'Nathan');
    

SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('Cathie' , 'Mark', 'Nathan');
    
-- //exercise
SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Denis' , 'Elvis');
    
SELECT
    *
FROM
    employees
WHERE
    first_name NOT IN ('John' , 'Mark', 'Jacob');
--

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('Mar_%');

SELECT 
    *
FROM
    employees
WHERE
    first_name NOT LIKE ('%Mar%');
    
-- //exercise
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('Mark%');
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date LIKE ('2000%');
    
SELECT 
    *
FROM
    employees
WHERE
    emp_no LIKE ('1000_');
    
-- //exercise
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%Jack%');
    
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT LIKE ('%Jack%');

# the dates are included in the intervals
SELECT 
    *
FROM
    employees
WHERE
    hire_date BETWEEN '1990-01-01' AND '2000-01-01';
    
# hire_date is before '1990-01-01' or 
# hire_date is after after '2000-01-01'
# the dates are not included in the interval
SELECT 
    *
FROM
    employees
WHERE
    hire_date NOT BETWEEN '1990-01-01' AND '2000-01-01';

-- //exercise
SELECT 
    *
FROM
    salaries
WHERE
    salary BETWEEN 66000 AND 70000;

SELECT 
    *
FROM
    employees
WHERE
    emp_no NOT BETWEEN '10004' AND '10012';
    
SELECT 
    *
FROM
    departments
WHERE
    dept_no BETWEEN 'd003' AND 'd006';
--

SELECT 
    *
FROM
    employees
WHERE
    first_name IS NULL;

SELECT 
    *
FROM
    employees
WHERE
    first_name IS NOT NULL;
    
-- //exercise
SELECT 
    *
FROM
    departments
WHERE
    dept_no IS NOT NULL;
--

SELECT 
    *
FROM
    employees
WHERE
    first_name != 'Mark';

SELECT 
    *
FROM
    employees
WHERE
    hire_date >= '2000-01-01';
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date < '1985-02-01';
    
-- //exercise
SELECT 
    *
FROM
    employees
WHERE
    hire_date >= '2000-01-01' AND gender = 'F';

SELECT 
    *
FROM
    salaries
WHERE
    salary > 150000;
--

SELECT DISTINCT
    gender
FROM
    employees;

-- //exercise
SELECT DISTINCT
    hire_date
FROM
    employees;
--

SELECT 
    COUNT(emp_no)
FROM
    employees;
    
SELECT 
    COUNT(first_name)
FROM
    employees;

SELECT 
    COUNT(DISTINCT first_name)
FROM
    employees;
    
SELECT 
    COUNT(first_name)
FROM
    employees
WHERE
    first_name IS NULL;

-- //exercise
SELECT COUNT(*) FROM salaries
WHERE salary >= 100000;

SELECT 
    COUNT(*)
FROM
    dept_manager;
--

SELECT 
    *
FROM
    employees
ORDER BY first_name ASC;

SELECT 
    *
FROM
    employees
ORDER BY first_name DESC;

SELECT 
    *
FROM
    employees
ORDER BY first_name, last_name ASC;

-- //exercise
SELECT 
    *
FROM
    employees
ORDER BY hire_date;
--

# works like distinct
SELECT 
    first_name
FROM
    employees
GROUP BY first_name;

SELECT 
    first_name, COUNT(first_name)
FROM
    employees
GROUP BY first_name
ORDER BY first_name DESC;

SELECT 
    first_name, COUNT(first_name) AS names_count	
FROM
    employees
GROUP BY first_name
ORDER BY first_name DESC;

SELECT 
    salary, COUNT(emp_no) AS emps_with_same_salary
FROM
    salaries
WHERE
    salary > 80000
GROUP BY salary
ORDER BY salary ASC;

# In some scenarios WHERE and HAVING work the same way
SELECT 
    *
FROM
    employees
WHERE
    hire_date >= '2000-01-01';

SELECT 
    *
FROM
    employees
HAVING hire_date >= '2000-01-01';

# Expect an error
-- SELECT first_name, COUNT(first_name) AS names_count
-- FROM employees
-- WHERE COUNT(first_name) > 250
-- GROUP BY first_name
-- ORDER BY first_name;

SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
GROUP BY first_name
HAVING COUNT(first_name) > 250
ORDER BY first_name;

-- //exercise
SELECT 
    emp_no, AVG(salary) AS average_salary
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no;


# ! * not working in place of emp_no as the course suggests it should.
SELECT 
    emp_no, AVG(salary) AS average_salary
FROM
    salaries
WHERE
    salary > 120000
GROUP BY emp_no
ORDER BY emp_no;

SELECT 
    emp_no, AVG(salary) AS average_salary
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no;
--

# Where vs Having
# Extracting a list of all names that are encountered less than 200 times.
# Let the data refer to people hired after the 1st of January 1999.
SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name DESC;

# Expect error
# We can't have both aggregated and non-aggregated functions in having clause.
-- SELECT 
--    first_name, COUNT(first_name) AS names_count
-- FROM
--    employees
-- GROUP BY first_name
-- HAVING COUNT(first_name) < 200 AND hire_date > '1999-01-01'
-- ORDER BY first_name DESC;

-- // exercise
SELECT 
    emp_no, COUNT(emp_no)
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no;

SELECT 
    emp_no, COUNT(emp_no)
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no;
--

SELECT 
    *
FROM
    salaries
ORDER BY salary DESC
LIMIT 10;

SELECT 
    *
FROM
    salaries
ORDER BY emp_no DESC
LIMIT 100;

-- //exercise
SELECT 
    *
FROM
    dept_emp
LIMIT 100;
--

INSERT INTO employees
(emp_no, birth_date, first_name, last_name, gender, hire_date)
VALUES
(999901,
'1986-04-21',
'John',
'Smith',
'M',
'2011-01-01'
);

# The order of the columns can be changed as well with respective values.
INSERT INTO employees
(
birth_date,
emp_no,
first_name,
last_name,
gender,
hire_date
)
VALUES
(
'1973-3-26',
999902,
'Patricia',
'Lawrence',
'F',
'2005-01-01'
);

INSERT INTO employees
VALUES
(
    999903,
    '1977-09-14',
    'Johnathan',
    'Creek',
    'M',
    '1999-01-01'
);

-- //exercise
SELECT 
    *
FROM
    titles
LIMIT 10;

INSERT INTO titles
(
	emp_no,
	title,
	from_date
)
VALUES
(
	999903,
	'Senior Engineer',
	'1997-10-01'
);

SELECT 
    *
FROM
    titles
ORDER BY emp_no DESC;

INSERT INTO dept_emp
VALUES
(
	999903,
    'd005',
    '1997-10-01',
    '9999-01-01'
);
--

SELECT 
    *
FROM
    departments
LIMIT 10;

CREATE TABLE departments_dup(
    dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);

# we want to add all the data from departments to departments_dup
INSERT INTO departments_dup
(
	dept_no,
	dept_name
)
SELECT * FROM departments;

-- //exercise
INSERT INTO departments
VALUES
(
	'd010',
	'Business Analysis'
);
--
USE employees;

SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999901;
    
UPDATE employees 
SET 
    first_name = 'Stella',
    last_name = 'Parkinson',
    birth_date = '1990-12-31',
    gender = 'F'
WHERE
    emp_no = 999901;
--

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

COMMIT;

# updates all the rows
UPDATE departments_dup
SET
	dept_no = 'd011',
	dept_name = 'Quality Control';

# we can rollback to the last commit,
# there has to be a recent commit otherwise we go back to the top
ROLLBACK;
COMMIT;

-- //exercise
UPDATE departments 
SET
	dept_name = 'DataAnalysis'
WHERE dept_no = 'd010';
--

DELETE FROM employees
WHERE
	emp_no = 999903;

SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999903;
    
# the information about the employee is deleted in the title table as well
# since there is a ON DELETE CASCADE in the DDL info.
SELECT 
    *
FROM
    titles
WHERE
    emp_no = 999903;

ROLLBACK;

SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999903;
    
SELECT 
    *
FROM
    titles
WHERE
    emp_no = 999903;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

DELETE FROM departments_dup;

ROLLBACK;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

-- //exercise
DELETE FROM departments 
WHERE
    dept_no = 'd010';
    
SELECT 
    *
FROM
    departments;
--

SELECT 
    *
FROM
    salaries
ORDER BY salary DESC
LIMIT 10;

SELECT 
    COUNT(salary)
FROM
    salaries;
    
SELECT 
    COUNT(DISTINCT from_date)
FROM
    salaries;
    
-- //exercise
SELECT 
    COUNT(DISTINCT dept_no)
FROM
    dept_emp;
--

SELECT 
    SUM(salary)
FROM
    salaries;
  
# * doesn't work with other functions
-- SELECT 
--    SUM(*)
-- FROM
--    salaries;

-- //exercise
SELECT 
    SUM(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';
--

SELECT 
    MAX(salary)
FROM
    salaries;
    
SELECT 
    MIN(salary)
FROM
    salaries;
    
SELECT 
    AVG(salary)
FROM
    salaries;
    
-- //exercise
SELECT 
    MIN(emp_no)
FROM
    employees;
    
SELECT 
    MAX(emp_no)
FROM
    employees;

SELECT 
    AVG(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';
--

SELECT 
    ROUND(AVG(salary), 2)
FROM
    salaries;
    
-- //exercise
SELECT 
    ROUND(AVG(salary), 2)
FROM
    salaries
WHERE
    from_date > '1997-01-01';
--

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

ALTER TABLE departments_dup
MODIFY COLUMN dept_name VARCHAR(40) NULL,
MODIFY COLUMN dept_no VARCHAR(5) NULL;

INSERT INTO departments_dup(dept_no, dept_name)
VALUES
('d010', NULL),
('d011', NULL);

SELECT 
    dept_no,
    IFNULL(dept_name,
            'Department name not provided') AS dept_name
FROM
    departments_dup;
    
SELECT 
    dept_no,
    COALESCE(dept_name,
            'Department name not provided') AS dept_name
FROM
    departments_dup;
    
# Interpretation of COALESCE would be
# If dept_manager is NULL return dept_name, if that's also null return 'N/A'

ALTER TABLE departments_dup
ADD COLUMN dept_manager VARCHAR(50);

SELECT * FROM departments_dup;

SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_manager, dept_name, 'N/A') AS dept_manager
FROM
    departments_dup
ORDER BY dept_no ASC;

# COALESCE can be used to add a fake column
SELECT 
    dept_no,
    dept_name,
    COALESCE('department manager name') AS fake_col
FROM
    departments_dup;
    
-- //exercise
INSERT INTO departments_dup
VALUES(NULL, "xyz department", NULL);

SELECT
    dept_no,
    dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM departments_dup
ORDER BY dept_no ASC;

SELECT
    IFNULL(dept_no, 'N/A') AS dept_no,
    IFNULL(dept_name, 'Department name not provided') AS dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM departments_dup
ORDER BY dept_no ASC;
--

-- //exercise
INSERT INTO departments_dup(dept_name)
VALUES
('Public Relations');

DELETE FROM departments_dup 
WHERE
    dept_no = 'd002';
    
INSERT INTO departments_dup(dept_no)
VALUES('d010'),('d011');

DROP TABLE IF EXISTS dept_manager_dup;
CREATE TABLE dept_manager_dup (
    emp_no INT NOT NULL,
    dept_no CHAR(4) NULL,
    from_date DATE NOT NULL,
    to_date DATE NULL
);

INSERT INTO dept_manager_dup
SELECT * FROM dept_manager;

INSERT INTO dept_manager_dup(emp_no, from_date)
VALUES
(999904, '2017-01-01'),
(999905, '2017-01-01'),
(999906, '2017-01-01'),
(999907, '2017-01-01');

DELETE FROM dept_manager_dup 
WHERE
    dept_no = 'd001';

INSERT INTO departments_dup (dept_name)
VALUES
('Public Relations');

DELETE FROM departments_dup
WHERE
dept_no = 'd002'; 

--

SELECT 
    *
FROM
    dept_manager_dup
ORDER BY dept_no;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

SELECT
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- //exercise
SELECT * FROM dept_manager;
SELECT * FROM employees;

SELECT
    e.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
FROM
    employees e
        INNER JOIN
    dept_manager m ON e.emp_no = m.emp_no
ORDER BY emp_no;
--

# Left Join
SELECT * FROM departments_dup;
SELECT * FROM dept_manager_dup;
DELETE FROM departments_dup
WHERE dept_no = 'd009';

DELETE FROM dept_manager_dup
WHERE emp_no = '110229';

INSERT INTO dept_manager_dup
VALUES ('110229', 'd003', '1992-03-21', '9999-01-01');

INSERT INTO departments_dup
VALUES('d009', 'Customer Service');

SELECT
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

# Inverting the order of the tables
SELECT
    d.dept_no, m.emp_no, d.dept_name
FROM
    departments_dup d
        LEFT JOIN
    dept_manager_dup m ON m.dept_no = d.dept_no
ORDER BY d.dept_no;

# Records from the left table taht do not match any rows.
SELECT
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON m.dept_no = d.dept_no
WHERE dept_name IS NULL
ORDER BY m.dept_no;
-- //exercise
SELECT 
    e.emp_no, e.first_name, e.last_name, m.dept_no, m.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager m ON e.emp_no = m.emp_no
WHERE
    e.last_name = 'Markovitch'
ORDER BY m.dept_no DESC, e.emp_no;
--

SELECT
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        RIGHT JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

# New and Old Join Syntax
# New
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.emp_no;
# Old
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m,
    departments_dup d
WHERE
    m.dept_no = d.dept_no
ORDER BY m.emp_no;

-- //exercise
SELECT 
    m.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
FROM
    dept_manager_dup m,
    employees e
WHERE
    m.emp_no = e.emp_no
ORDER BY m.emp_no;
--

# Using JOIN with WHERE
SELECT 
    e.emp_no, e.first_name, e.last_name, s.salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    s.salary > 145000;

-- !! Configuration
SELECT @@global.sql_mode;
SET @@global.sql_mode := REPLACE(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');
-- to reverse
-- SET @@global.sql_mode := CONCAT('ONLY_FULL_GROUP_BY,', @@global.sql_mode);
--

-- //exercise
SELECT 
    e.emp_no, e.first_name, e.last_name, e.hire_date, t.title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    e.first_name = 'Margareta'
        AND e.last_name = 'Markovitch'
ORDER BY e.emp_no;
--

# Cross Join
SELECT
    m.*, d.*
FROM
    dept_manager m
        CROSS JOIN
    departments d
ORDER BY m.emp_no , d.dept_no;

SELECT 
    m.*, d.*
FROM
    dept_manager m,
    departments d
ORDER BY m.emp_no , d.dept_no;

SELECT 
    m.*, d.*
FROM
    dept_manager m
        JOIN
    departments d
ORDER BY m.emp_no , d.dept_no;

SELECT 
    m.*, d.*
FROM
    dept_manager m
        INNER JOIN
    departments d
ORDER BY m.emp_no , d.dept_no;

# Getting records where the manager is not currently head of
SELECT
    m.*, d.*
FROM
    dept_manager m
        CROSS JOIN
    departments d
WHERE d.dept_no <> m.dept_no
ORDER BY m.emp_no , d.dept_no;

# Combining CROSS JOIN with INNER JOIN
SELECT 
    e.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager m
        JOIN
    employees e ON m.emp_no = e.emp_no
WHERE
    d.dept_no <> m.dept_no
ORDER BY m.emp_no , d.dept_no;

-- //exercise
SELECT 
    d.*, m.*
FROM
    departments d
        CROSS JOIN
    dept_manager m
WHERE
    d.dept_no = 'd009'
ORDER BY d.dept_no;

SELECT 
    e.*, d.*
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
    e.emp_no < 10011
ORDER BY e.emp_no , d.dept_name;
--

SELECT 
    e.gender, AVG(s.salary) AS average_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY gender;

# Joining multiple tables
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no;

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    employees e ON m.emp_no = e.emp_no;
    
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        RIGHT JOIN
    employees e ON m.emp_no = e.emp_no;

-- //exercise
SELECT 
    m.emp_no,
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    m.from_date,
    d.dept_name
FROM
    dept_manager m
        JOIN
    departments d ON m.dept_no = d.dept_no
        JOIN
    employees e ON m.emp_no = e.emp_no
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    t.title = 'Manager'
ORDER BY e.emp_no;
--

# ? Why the results for these queries vary?
SELECT 
    d.dept_name, AVG(s.salary) AS average_salary
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY d.dept_name
ORDER BY d.dept_name; 
    
SELECT 
    d.dept_name, AVG(s.salary) AS average_salary
FROM
    departments d
        JOIN
    dept_emp de ON d.dept_no = de.dept_no
        JOIN
    salaries s ON de.emp_no = s.emp_no
GROUP BY d.dept_no
ORDER BY dept_name;
###

SELECT 
    d.dept_name, AVG(s.salary) AS average_salary
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY d.dept_name
HAVING average_salary > 60000
ORDER BY average_salary; 
    
-- //exercise
SELECT gender, COUNT(gender) AS gender_count FROM employees e
JOIN titles t ON e.emp_no = t.emp_no
WHERE t.title = 'Manager'
GROUP BY e.gender
ORDER BY gender_count;

SELECT gender, COUNT(e.emp_no) AS gender_count FROM employees e
JOIN dept_manager m ON e.emp_no = m.emp_no
GROUP BY e.gender
ORDER BY gender_count;
--

# Creating a duplicate of the employees table
CREATE TABLE employees_dup LIKE employees;
INSERT INTO employees_dup
SELECT * FROM employees;

# removing auto-increment and primary key to allow duplicate entry
ALTER TABLE employees_dup MODIFY emp_no INT NOT NULL;
ALTER TABLE employees_dup DROP PRIMARY KEY;

INSERT INTO employees_dup
VALUES
('10001', '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26');

SELECT * FROM employees_dup
ORDER BY emp_no;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees_dup e
WHERE
    e.emp_no = 10001
UNION ALL SELECT 
    NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    m.dept_no,
    m.from_date
FROM
    dept_manager m;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees_dup e
WHERE
    e.emp_no = 10001 
UNION SELECT 
    NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    m.dept_no,
    m.from_date
FROM
    dept_manager m;

-- //exercise
SELECT 
    *
FROM
    (SELECT 
        e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' UNION SELECT 
        NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) AS a
ORDER BY -a.emp_no DESC;
--

SELECT * FROM dept_manager;

SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            m.emp_no
        FROM
            dept_manager m);

-- //exercise
SELECT 
    *
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            m.emp_no
        FROM
            dept_manager m
        WHERE
            m.from_date BETWEEN '1990-01-01' AND '1995-01-01');
--

SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager dm
        WHERE
            dm.emp_no = e.emp_no);

SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager m
        WHERE
            m.emp_no = e.emp_no
        ORDER BY emp_no);

# More professional is to order the final version of the dataset
SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager m
        WHERE
            m.emp_no = e.emp_no)
ORDER BY emp_no;

-- //exercise
SELECT 
    *
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            titles t
        WHERE
            e.emp_no = t.emp_no
                AND t.title = 'Assistant Engineer');
--

SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B;

-- //exericise
DROP TABLE IF EXISTS emp_manager;
CREATE TABLE emp_manager (
    emp_no INT NOT NULL,
    dept_no CHAR(4) NULL,
    manager_no INT NOT NULL
);

SELECT
    U.*
FROM
    (SELECT 
        A.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A UNION SELECT 
        B.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B UNION SELECT 
        C.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS C UNION SELECT 
        D.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS D) AS U;

# Views
SELECT 
    emp_no, from_date, to_date, COUNT(emp_no) AS Num
FROM
    dept_emp
GROUP BY emp_no
HAVING Num > 1;

CREATE OR REPLACE VIEW v_dept_emp_latest_date AS
    SELECT 
        emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM
        dept_emp
    GROUP BY emp_no;

SELECT 
    emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
FROM
    dept_emp
GROUP BY emp_no;

SELECT * FROM v_dept_emp_latest_date;

-- //exercise
CREATE OR REPLACE VIEW v_manager_avg_salary AS
    SELECT 
        ROUND(AVG(s.salary), 2)
    FROM
        dept_manager m
            JOIN
        salaries s ON m.emp_no = s.emp_no;

SELECT * FROM v_manager_avg_salary;
--

# Stored Procedures
USE employees;
DROP PROCEDURE IF EXISTS select_employees;

DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN
	SELECT * FROM employees
	LIMIT 1000;
END$$
DELIMITER ;

# calling the procedure
CALL employees.select_employees();
CALL select_employees();

-- //exercise
DROP PROCEDURE IF EXISTS avg_salary;

DELIMITER $$
CREATE PROCEDURE avg_salary()
BEGIN
	SELECT AVG(salary) FROM salaries;
END$$
DELIMITER ;

CALL avg_salary();
CALL employees.avg_salary();
--

DROP PROCEDURE select_employees;

# parametered procedure
DROP PROCEDURE IF EXISTS emp_salary;

DELIMITER $$
USE EMPLOYEES $$
CREATE PROCEDURE emp_salary(IN p_emp_no INTEGER)
BEGIN
	SELECT
		e.first_name, e.last_name, s.salary, s.from_date, s.to_date
	FROM employees e
		JOIN
	salaries s ON e.emp_no = s.emp_no
WHERE
	e.emp_no = p_emp_no;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS emp_salary;

DELIMITER $$
USE EMPLOYEES $$
CREATE PROCEDURE emp_salary(IN p_emp_no INTEGER)
BEGIN
	SELECT
		e.first_name, e.last_name, AVG(s.salary)
	FROM employees e
		JOIN
	salaries s ON e.emp_no = s.emp_no
WHERE
	e.emp_no = p_emp_no;
END $$
DELIMITER ;

CALL emp_salary(11300);

# storing result of the procedure
DROP PROCEDURE IF EXISTS emp_avg_salary_out;

DELIMITER $$
CREATE PROCEDURE emp_avg_salary_out(IN p_emp_no INTEGER, OUT p_avg_salary DECIMAL(10, 2))
BEGIN
	SELECT
		AVG(s.salary)
	INTO p_avg_salary FROM
		employees e
			JOIN
		salaries s ON e.emp_no = s.emp_no
WHERE
	e.emp_no = p_emp_no;
END$$
DELIMITER ;

CALL emp_avg_salary_out(11300, @p_avg_salary);
SELECT @p_avg_salary;


-- //exercise
DROP PROCEDURE IF EXISTS emp_info;

DELIMITER $$
CREATE PROCEDURE emp_info(IN f_name VARCHAR(40), IN l_name VARCHAR(40), OUT e_no INTEGER)
BEGIN
	SELECT
		e.emp_no
	INTO e_no FROM
		employees e
WHERE e.first_name = f_name
		AND e.last_name = l_name;
END $$
DELIMITER ;

CALL emp_info('Denis', 'Nicolson', @eno);
SELECT @eno;
--

SET @v_avg_salary = 0;
CALL employees.emp_avg_salary_out(11300, @v_avg_salary);
SELECT @v_avg_salary;

-- //exercise
SET @v_emp_no = 0;
CALL employees.emp_info('Aruna', 'Journel' , @v_emp_no);
SELECT @v_emp_no;
--

DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary (p_emp_no INTEGER) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
DECLARE v_avg_salary DECIMAL(10, 2);
SELECT
	AVG(s.salary)
INTO v_avg_salary FROM
	employees e
		JOIN
	salaries s ON e.emp_no = s.emp_no
WHERE e.emp_no = p_emp_no;
RETURN v_avg_salary;
END $$
DELIMITER ;

SELECT f_emp_avg_salary(11300);

-- //exercise
DROP FUNCTION IF EXISTS emp_info;

DELIMITER $$
CREATE FUNCTION emp_info (f_name VARCHAR(40), l_name VARCHAR(40)) RETURNS INTEGER
DETERMINISTIC
BEGIN
DECLARE v_max_from_date DATE;
DECLARE v_salary DECIMAL(10, 2);

SELECT 
	MAX(from_date)
INTO v_max_from_date
FROM
	employees e
JOIN 
	salaries s ON e.emp_no = s.emp_no
    WHERE e.first_name = f_name
		AND e.last_name = l_name;

SELECT
	s.salary
INTO v_salary
FROM employees e
JOIN
	salaries s ON e.emp_no = s.emp_no
    WHERE e.first_name = f_name
		AND e.last_name = l_name
			AND s.from_date = v_max_from_date;

RETURN v_salary;
END $$
DELIMITER ;

SELECT emp_info('Aruna', 'Journel');
--

# Including a function in a SELECT statement
SET @v_emp_no = 11300;
SELECT
	emp_no,
    first_name,
    last_name,
    f_emp_avg_salary(@v_emp_no) AS avg_salary
FROM employees
WHERE emp_no = @v_emp_no;

# Session variables
SET @s_var1 = 3;
SELECT @s_var1;

# Global variables
SET GLOBAL max_connections = 1000;
SET @@global.max_connections = 1;

############# TRIGGERS #########################
USE employees;

# BEFORE INSERT
DROP TRIGGER IF EXISTS before_salaries_insert;
DELIMITER $$

CREATE TRIGGER before_salaries_insert
BEFORE INSERT ON salaries
FOR EACH ROW
BEGIN
	IF NEW.salary < 0 THEN
		SET NEW.salary = 0;
	END IF;
END $$
DELIMITER ;

SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001';

INSERT INTO salaries VALUES ('10001', -92891, '2010-06-22', '9999-01-01');


SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001';


DROP TRIGGER IF EXISTS before_salaries_update;

# UPDATE Trigger
DELIMITER $$
CREATE TRIGGER before_salaries_update
BEFORE UPDATE ON salaries
FOR EACH ROW
BEGIN
	IF NEW.salary < 0 THEN
		SET NEW.salary = 0;
	END IF;
END $$
DELIMITER ;

UPDATE salaries 
SET 
    salary = 98765
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';

UPDATE salaries 
SET 
    salary = -10001
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';

SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001';

SELECT SYSDATE();
SELECT DATE_FORMAT(SYSDATE(), '%y-%m-%d') AS today;


DELIMITER $$
CREATE TRIGGER trig_ins_dept_mng
AFTER INSERT ON dept_manager
FOR EACH ROW
BEGIN
	DECLARE v_curr_salary INT;
	
SELECT MAX(salary)
INTO v_curr_salary FROM
	salaries
WHERE
	emp_no = NEW.emp_no;
    
    IF v_curr_salary IS NOT NULL THEN
		UPDATE salaries
        SET
			to_date = SYSDATE()
		WHERE
			emp_no = NEW.emp_no AND to_date = NEW.to_date;
            
		INSERT INTO salaries
			VALUES(NEW.emp_no, v_curr_salary + 20000, NEW.from_date, NEW.to_date);
	END IF;
END $$
DELIMITER ;

INSERT INTO dept_manager VALUES ('111534', 'd009', DATE_FORMAT(SYSDATE(), '%Y-%m-%d'), '9999-01-01');

SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no = 111534;

SELECT 
    *
FROM
    salaries
WHERE
    emp_no = 111534;

-- //exercise
DELIMITER $$

CREATE TRIGGER trig_hire_date
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
	IF NEW.hire_date > DATE_FORMAT(SYSDATE(), '%Y-%m-%d') THEN
		SET NEW.hire_date = DATE_FORMAT(SYSDATE(), '%Y-%m-%d');
	END IF;
END $$
DELIMITER ;

INSERT INTO employees VALUES ('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');

SELECT * FROM employees
WHERE emp_no = 999904;
--
####### Indexes

SELECT * FROM employees
WHERE hire_date > '2000-01-01';

CREATE INDEX i_hire_date ON employees(hire_date);

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Georgi'
        AND last_name = 'Facello';
        
CREATE INDEX i_composite ON employees(first_name, last_name);

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Georgi'
        AND last_name = 'Facello';

-- //exercise
ALTER TABLE employees
DROP INDEX i_hire_date;

SELECT 
    *
FROM
    salaries
WHERE
    salary < 89000;
    
CREATE INDEX i_salary ON salaries(salary);
    
SELECT 
    *
FROM
    salaries
WHERE
    salary < 89000;
--

SELECT
	emp_no,
    first_name,
    last_name,
    CASE
		WHEN gender = 'M' THEN 'Male'
        ELSE 'Female'
	END AS gender
FROM
	employees;

SELECT
	e.emp_no,
    e.first_name,
    e.last_name,
    m.emp_no,
    CASE
		WHEN m.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
	END AS is_manager
FROM
	employees e
		LEFT JOIN
    dept_manager m ON m.emp_no = e.emp_no
WHERE
	e.emp_no > 109990;

SELECT
	emp_no,
    first_name,
    last_name,
    IF(gender = 'M', 'Male', 'Female') AS gender
FROM employees;

SELECT
	m.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
		WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more then $30,000'
        WHEN MAX(s.salary) - MIN(s.salary) BETWEEN 20000 AND 30000 THEN 'Salary was raised by more than 
																		$20,000 but less than $30,000'
		ELSE 'Salary was raised by less than $20,000'
	END AS salary_increase
FROM
	dept_manager m
		JOIN
	employees e ON e.emp_no = m.emp_no
		JOIN
	salaries s ON s.emp_no = m.emp_no
GROUP BY s.emp_no;

-- //exercise
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN m.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager m ON e.emp_no = m.emp_no
WHERE
    e.emp_no > 109990;
    
SELECT
	m.dept_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary raise was higher than $30000'
        ELSE 'Salary raise was not higher than $30000'
    END AS salary_raise
FROM
    dept_manager m
        JOIN
    employees e ON m.emp_no = e.emp_no
		JOIN
	salaries s ON e.emp_no = s.emp_no
GROUP BY e.emp_no;

# alternate
SELECT 
    m.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    IF(MAX(s.salary) - MIN(s.salary) > 30000,
        'Salary was raised by more than $30000',
        'Salary was not raised by more than $30000') AS salary_increase
FROM
    dept_manager m
        JOIN
    employees e ON e.emp_no = m.emp_no
        JOIN
    salaries s ON s.emp_no = m.emp_no
GROUP BY s.emp_no;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(de.to_date) < DATE_FORMAT(SYSDATE(), '%Y-%m-%d') THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
GROUP BY e.emp_no
LIMIT 100;
--

SELECT
	emp_no,
    salary,
    ROW_NUMBER() OVER() AS row_num
FROM salaries;

SELECT
	emp_no,
    salary,
    ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY emp_no DESC) AS row_num
FROM salaries;

SELECT
	emp_no,
    salary,
    ROW_NUMBER() OVER(ORDER BY emp_no DESC) AS row_num
FROM salaries;

-- //exercise
SELECT
	m.emp_no,
    m.dept_no,
    ROW_NUMBER() OVER(ORDER BY emp_no) AS row_num
FROM dept_manager m;

SELECT
	e.first_name,
    e.last_name,
    ROW_NUMBER() OVER(PARTITION BY e.first_name ORDER BY e.last_name) as row_num
FROM employees e;
--

SELECT
	emp_no,
    salary,
    # ROW_NUMBER() OVER AS row_num1,
    ROW_NUMBER() OVER (PARTITION BY emp_no) AS row_num2,
    ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary DESC) AS row_num3
    # ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num4
FROM
	salaries;
    
-- //exercise
SELECT 
    s.*,
    ROW_NUMBER() OVER() AS row_num1,
    ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary DESC) as row_num2
FROM
    dept_manager m
        JOIN
    salaries s ON m.emp_no = s.emp_no
ORDER BY row_num1, s.emp_no, s.salary ASC;

SELECT 
    m.emp_no,
    s.salary,
    ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary ASC) as row_num1,
    ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary DESC) as row_num2
FROM
    dept_manager m
        JOIN
    salaries s ON m.emp_no = s.emp_no;
--

SELECT
	emp_no,
	salary,
    ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary DESC) AS row_num
FROM
	salaries;
    
# less used syntax
SELECT
	emp_no,
	salary,
    ROW_NUMBER() OVER w AS row_num
FROM
	salaries
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

-- //exercise
SELECT
	e.*,
    ROW_NUMBER() OVER w AS row_num
FROM employees e
WINDOW w AS (PARTITION BY e.first_name ORDER BY e.emp_no);

# Partition with grouping
SELECT
	a.emp_no,
	MAX(salary) AS max_salary FROM (
		SELECT
			emp_no, salary, ROW_NUMBER() OVER w AS row_num
		FROM
			salaries
		WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC)) a
GROUP BY emp_no;

SELECT a.emp_no, MAX(salary) AS max_salary FROM(
	SELECT
		emp_no, salary, ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary DESC) AS row_num
	FROM
		salaries) a
GROUP BY emp_no;

SELECT 
    a.emp_no, MAX(salary) AS max_salary
FROM
    (SELECT 
        emp_no, salary
    FROM
        salaries) a
GROUP BY emp_no;

SELECT
	a.emp_no,
    a.salary AS max_salary FROM(
		SELECT
			emp_no, salary, ROW_NUMBER() OVER w AS row_num
		FROM
			salaries
		WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC)) a
WHERE a.row_num = 1;

-- //exercise
SELECT
	a.emp_no,
    MIN(a.salary) AS min_salary
FROM(
	SELECT
		s.emp_no,
        s.salary,
        ROW_NUMBER() OVER w AS row_num
	FROM
		salaries s
	WINDOW w AS (PARTITION BY emp_no ORDER BY salary)) AS a
GROUP BY emp_no;

SELECT
	a.emp_no,
    MIN(a.salary) AS min_salary
FROM(
	SELECT
		s.emp_no,
        s.salary,
        ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary) AS row_num
	FROM
		salaries s) AS a
GROUP BY emp_no;

SELECT
	a.emp_no,
    MIN(a.salary) AS min_salary
FROM(
	SELECT
		s.emp_no,
        s.salary
	FROM
		salaries s) AS a
GROUP BY a.emp_no;

SELECT
	a.emp_no,
    a.salary AS min_salary
FROM(
	SELECT
		s.emp_no,
        s.salary,
		ROW_NUMBER() OVER w AS row_num
    FROM
		salaries s
	WINDOW w AS (PARTITION BY s.emp_no ORDER BY s.salary ASC)) AS a
WHERE a.row_num = 1;

SELECT
	a.emp_no,
    a.salary AS min_salary
FROM(
	SELECT
		s.emp_no,
        s.salary,
		ROW_NUMBER() OVER w AS row_num
    FROM
		salaries s
	WINDOW w AS (PARTITION BY s.emp_no ORDER BY s.salary ASC)) AS a
WHERE a.row_num = 2;
--

# Using RANK and DENSE RANK
SELECT DISTINCT
	emp_no,
	salary,
    ROW_NUMBER() OVER w AS row_num
FROM
	salaries
WHERE emp_no = 10001
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

SELECT
	emp_no,
    (COUNT(salary) - COUNT(DISTINCT salary)) AS diff
FROM
	salaries
GROUP BY emp_no
HAVING diff > 0
ORDER BY emp_no;

SELECT
	*
FROM
	salaries
WHERE emp_no = 11839;

SELECT DISTINCT
	emp_no,
	salary,
    ROW_NUMBER () OVER w AS row_num
FROM
	salaries
WHERE emp_no = 11839
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

SELECT
	emp_no,
	salary,
    RANK() OVER w AS rank_num
FROM
	salaries
WHERE emp_no = 11839
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

SELECT
	emp_no,
	salary,
    DENSE_RANK() OVER w AS rank_num
FROM
	salaries
WHERE emp_no = 11839
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

-- //exercise
SELECT 
    emp_no,
    salary,
    ROW_NUMBER() OVER w AS row_num
FROM
    salaries
WHERE
    emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

SELECT 
    m.emp_no, 
    COUNT(s.salary) AS salary_counts
FROM
    dept_manager m
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY s.emp_no
ORDER BY s.emp_no;

SELECT 
    emp_no,
    salary,
    RANK() OVER w AS rank_num
FROM
    salaries
WHERE
    emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

SELECT 
    emp_no,
    salary,
    DENSE_RANK() OVER w AS rank_num
FROM
    salaries
WHERE
    emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);
--

SELECT
	d.dept_no,
    d.dept_name,
    m.emp_no,
    RANK() OVER w AS department_salary_ranking,
    s.salary,
    s.from_date AS salary_from_date,
    s.to_date AS salary_to_date,
    m.from_date AS dept_manager_from_date,
    m.to_date AS dept_manager_to_date
FROM
	dept_manager m
		JOIN
	salaries s ON s.emp_no = m.emp_no
		AND s.from_date BETWEEN m.from_date and m.to_date
        AND s.to_date BETWEEN m.from_date and m.to_date
        JOIN
	departments d ON d.dept_no = m.dept_no
WINDOW w AS (PARTITION BY m.dept_no ORDER BY s.salary DESC);

-- //exercise
SELECT 
	e.emp_no,
    s.salary,
	RANK() OVER w AS employee_salary_ranking
FROM employees e
	JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE e.emp_no >= 10500
		AND
		e.emp_no <= 10600
WINDOW w AS (PARTITION BY s.emp_no ORDER BY s.salary DESC);

SELECT 
	e.emp_no,
    s.salary,
	DENSE_RANK() OVER w AS employee_salary_ranking,
    s.salary,
    e.hire_date,
    s.from_date,
    (YEAR(s.from_date - e.hire_date)) AS years_from_start
FROM employees e
	JOIN
    salaries s ON e.emp_no = s.emp_no
		AND
		(YEAR(s.from_date - e.hire_date)) >= 5
WHERE e.emp_no >= 10500
		AND
		e.emp_no <= 10600
WINDOW w AS (PARTITION BY s.emp_no ORDER BY s.salary DESC);
--
# Value window functions
SELECT
	s.emp_no,
    s.salary,
    LAG(salary) OVER w AS previous_salary,
    LEAD(salary) OVER w AS next_salary,
    s.salary - LAG(salary) OVER w AS diff_salary_current_previous,
    LEAD(s.salary) OVER w - salary AS diff_salary_next_current
FROM
	salaries s
WHERE s.emp_no = 10001
WINDOW w AS (ORDER BY s.salary);

-- //exercise
SELECT
	s.emp_no,
    s.salary,
    LAG(s.salary) OVER w AS previous_salary,
    LEAD(s.salary) OVER w AS next_salary,
    s.salary - LAG(s.salary) OVER w AS diff_salary_current_previous,
    LEAD(s.salary) OVER w - s.salary AS diff_salary_next_current
FROM salaries s
WHERE s.emp_no BETWEEN 10500 AND 10600
	AND s.salary > 80000
WINDOW w AS (PARTITION BY s.emp_no ORDER BY s.salary);

SELECT
	s.emp_no,
    s.salary,
    LAG(salary) OVER w AS previous_salary,
    LAG(salary, 2) OVER w AS 1_previous_salary,
    LEAD(salary) OVER w AS next_salary,
    LEAD(salary, 2) OVER w AS 1_next_salary
FROM salaries s
WINDOW w AS (PARTITION BY s.emp_no ORDER BY s.salary)
LIMIT 1000;
--

SELECT SYSDATE();

SELECT
	s.emp_no,
    s.salary,
    s.from_date,
    s.to_date
FROM
	salaries s
WHERE
	to_date > SYSDATE();

SELECT
	s.emp_no,
    s.salary,
    MAX(s.from_date),
    s.to_date
FROM
	salaries s
WHERE
	to_date > SYSDATE()
GROUP BY s.emp_no;

SELECT 
    s1.emp_no, s.salary, s.from_date, s.to_date
FROM
    salaries s
        JOIN
    (SELECT 
        emp_no, MAX(from_date) AS from_date
    FROM
        salaries
    GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE
    s.to_date > SYSDATE()
        AND s.from_date = s1.from_date;

-- //exercise
SELECT 
    s1.emp_no,
    s.salary,
    s.from_date,
    s.to_date
FROM
    salaries s
        JOIN
    (SELECT 
        s.emp_no, MIN(s.from_date) AS from_date
    FROM
        salaries s
    GROUP BY s.emp_no) s1 ON s.emp_no = s1.emp_no
WHERE
    s.from_date = s1.from_date;
--

SELECT
	de2.emp_no,
    d.dept_name,
    s2.salary,
    AVG(s2.salary) OVER w AS average_salary_per_department
FROM
(SELECT 
    de1.emp_no, de.dept_no, de.from_date, de.to_date
FROM
    dept_emp de
        JOIN
    (SELECT 
        emp_no, MAX(from_date) AS from_date
    FROM
        dept_emp
    GROUP BY emp_no) de1 ON de.emp_no = de1.emp_no
WHERE
    de.to_date > SYSDATE()
        AND de.from_date = de1.from_date) AS de2
        JOIN
	(SELECT 
    s1.emp_no, s.salary, s.from_date, s.to_date
FROM
    salaries s
        JOIN
    (SELECT 
        emp_no, MAX(from_date) AS from_date
    FROM
        salaries
    GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE
    s.to_date > SYSDATE()
        AND s.from_date = s1.from_date) AS s2 ON de2.emp_no = s2.emp_no
        JOIN
        departments d ON d.dept_no = de2.dept_no
GROUP BY de2.emp_no, d.dept_name
WINDOW w AS (PARTITION BY de2.dept_no)
ORDER BY de2.emp_no;

-- //exercise
SELECT
	de2.emp_no,
    d.dept_name,
    s2.salary,
    AVG(s2.salary) OVER w AS average_salary_per_department
FROM(
	SELECT
		de.emp_no,
		de.dept_no,
		de.from_date,
		de.to_date
	FROM
		dept_emp de
        JOIN
        (SELECT
			emp_no, 
            MAX(from_date) AS from_date
		FROM
			dept_emp
        GROUP BY emp_no) AS de1 ON de1.emp_no = de.emp_no
		WHERE
			de.to_date < '2002-01-01'
            AND de.from_date > '2000-01-01'
            AND de.from_date = de1.from_date) AS de2
		JOIN
        (SELECT
			s1.emp_no,
			s.salary,
			s.from_date,
			s.to_date
		FROM
			salaries s
        JOIN
        (SELECT
			emp_no, 
            MAX(from_date) AS from_date
		FROM
			salaries
        GROUP BY emp_no) AS s1 ON s.emp_no = s1.emp_no
		WHERE
			s.to_date < '2002-01-01'
            AND s.from_date > '2000-01-01'
            AND s.from_date = s.from_date) AS s2 ON de2.emp_no = s2.emp_no
		JOIN
			departments d ON d.dept_no = de2.dept_no
GROUP BY de2.emp_no, d.dept_name
WINDOW w AS (PARTITION BY de2.dept_no)
ORDER BY de2.emp_no, salary;
        
COMMIT;