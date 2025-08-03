-- script 19 leccion oracle

DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS example_table CASCADE;

CREATE TABLE departments (
    department_id INTEGER PRIMARY KEY,
    department_name VARCHAR(100),
    location_id INTEGER
);

CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    salary NUMERIC(10, 2),
    hire_date DATE,
    department_id INTEGER REFERENCES departments(department_id),
    commission_pct NUMERIC(4, 2)
);

INSERT INTO departments (department_id, department_name, location_id) VALUES
(10, 'Administration', 1700),
(20, 'Marketing', 1800),
(30, 'Purchasing', 1700),
(40, 'Human Resources', 2400),
(50, 'Shipping', 1500),
(60, 'IT', 1400),
(90, 'Executive', 1700),
(100, 'Finance', 1700);

INSERT INTO employees (employee_id, first_name, last_name, email, salary, hire_date, department_id, commission_pct) VALUES
(1, 'Steven', 'King', 'SKING@example.com', 24000, '2003-06-17', 90, NULL),
(2, 'Neena', 'Kochhar', 'NKOCHHAR@example.com', 17000, '2005-09-21', 90, 0.20),
(3, 'Lex', 'De Haan', 'LDEHAAN@example.com', 17000, '2001-01-13', 90, NULL),
(4, 'Alexander', 'Hunold', 'AHUNOLD@example.com', 9000, '2006-01-03', 60, NULL),
(5, 'Bruce', 'Ernst', 'BERNST@example.com', 6000, '2007-05-21', 60, NULL),
(6, 'Valli', 'Pataballa', 'VPATABAL@example.com', 4800, '2006-02-05', 50, 0.15),
(7, 'Diana', 'Lorentz', 'DLORENTZ@example.com', 4200, '2007-02-07', 50, 0.25),
(8, 'David', 'Austin', 'DAUSTIN@example.com', 4800, '2005-06-25', 50, 0.35),
(9, 'Nancy', 'Greenberg', 'NGREENBE@example.com', 12008, '2002-08-17', 10, NULL),
(10, 'Daniel', 'Faviet', 'DFAVIET@example.com', 9000, '2002-08-16', 10, NULL);

SELECT
    LOWER(first_name) AS lowercase_name,
    UPPER(last_name) AS uppercase_name,
    INITCAP(email) AS proper_case_email,
    CONCAT(first_name, last_name) AS full_name,
    SUBSTRING(last_name, 1, 3) AS first_three_chars,
    LENGTH(first_name) AS name_length,
    POSITION('a' IN LOWER(first_name)) AS position_of_a,
    LPAD(employee_id::TEXT, 6, '0') AS padded_id,
    RPAD(first_name, 15, '.') AS right_padded_name,
    TRIM(BOTH ' ' FROM '  ' || first_name || '  ') AS trimmed_name,
    REPLACE(email, '@', ' AT ') AS replaced_email
FROM employees
WHERE employee_id <= 5;

SELECT
    salary,
    ROUND(salary, -2) AS rounded_salary,
    TRUNC(salary, -1) AS truncated_salary,
    MOD(employee_id, 10) AS mod_result
FROM employees
WHERE employee_id <= 5;


SELECT
    hire_date,
    DATE_TRUNC('month', hire_date) AS truncated_to_month,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date)) * 12 +
    EXTRACT(MONTH FROM AGE(CURRENT_DATE, hire_date)) AS months_between,
    hire_date + INTERVAL '6 months' AS add_6_months,

    hire_date + (7 - EXTRACT(DOW FROM hire_date)::int + 0) % 7 * INTERVAL '1 day' AS next_sunday,
    (DATE_TRUNC('month', hire_date) + INTERVAL '1 month' - INTERVAL '1 day')::DATE AS last_day_of_month
FROM employees
WHERE employee_id <= 3;

SELECT
    TO_CHAR(salary, '999,999') AS formatted_salary,
    TO_CHAR(hire_date, 'Month DD, YYYY') AS formatted_date,
    salary::TEXT AS number_to_char,
    TO_DATE('2023-12-25', 'YYYY-MM-DD') AS converted_date
FROM employees
WHERE employee_id <= 3;

SELECT
    first_name,
    COALESCE(commission_pct, 0) AS nvl_equivalent,
    CASE WHEN commission_pct IS NOT NULL THEN commission_pct * salary ELSE salary END AS nvl2_equivalent,
    NULLIF(department_id, 10) AS nullif_example,
    COALESCE(commission_pct, salary/100, 0.05) AS coalesce_example
FROM employees
WHERE employee_id <= 5;

SELECT
    first_name,
    department_id,
    CASE department_id
        WHEN 10 THEN 'Administration'
        WHEN 20 THEN 'Marketing'
        WHEN 50 THEN 'Shipping'
        ELSE 'Other'
    END AS decode_equivalent,
    CASE
        WHEN salary > 10000 THEN 'High'
        WHEN salary > 5000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_grade
FROM employees
WHERE employee_id <= 10;


SELECT e.last_name, d.department_name
FROM employees e CROSS JOIN departments d
WHERE e.employee_id = 100;

SELECT e.employee_id, e.last_name, d.department_name
FROM employees e NATURAL JOIN departments d
WHERE e.employee_id <= 5;

SELECT e.employee_id, e.last_name, d.department_id, d.location_id
FROM employees e
JOIN departments d ON (e.department_id = d.department_id)
WHERE e.employee_id <= 5;

SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e
RIGHT OUTER JOIN departments d ON (e.department_id = d.department_id)
WHERE d.department_id <= 30;

SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e
LEFT OUTER JOIN departments d ON (e.department_id = d.department_id)
WHERE e.employee_id <= 10;

-- DDL y Subconsultas
CREATE TABLE example_table
(col1 SERIAL,
col2 VARCHAR(50),
col3 VARCHAR(30),
col4 NUMERIC(10,2),
col5 INTEGER,
CONSTRAINT tab_col1_pk PRIMARY KEY(col1),
CONSTRAINT tab_col3_uk UNIQUE(col2),
CONSTRAINT tab_col4_ck CHECK (col4 > 0),
CONSTRAINT tab1_col5_fk FOREIGN KEY (col5) REFERENCES departments(department_id));

SELECT
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS rank,
    first_name,
    last_name,
    salary
FROM employees
ORDER BY salary DESC
LIMIT 5;

SELECT e1.first_name, e1.last_name, e2.avg_salary
FROM employees e1,
     (SELECT department_id, AVG(salary) AS avg_salary
     FROM employees
     GROUP BY department_id) e2
WHERE e1.department_id = e2.department_id
  AND e1.employee_id <= 5;