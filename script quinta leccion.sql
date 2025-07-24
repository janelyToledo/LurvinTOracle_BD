
-- leccion 5 de oracle

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary NUMERIC(10,2),
    department_id INT,
    commission_pct NUMERIC(5,2),
    hire_date DATE
);

INSERT INTO employees (first_name, last_name, salary, department_id, commission_pct, hire_date) VALUES
('Ana', 'Lopez', 5200.00, 80, 0.10, '2020-03-15'),
('Luis', 'Martinez', 4800.00, 90, NULL, '2018-06-10'),
('Carlos', 'Diaz', 3000.00, 60, 0.05, '2019-11-01'),
('Maria', 'Gomez', 4500.00, 100, NULL, '2021-07-20');

SELECT TO_CHAR(salary, 'FM$99,999') AS "Salary"
FROM employees;

SELECT REPLACE('5,320', ',', '')::numeric AS "Number";

SELECT TO_DATE('May10,1989', 'MonDD,YYYY') AS "Convert";

SELECT TO_DATE('27-Oct-95','DD-Mon-YY') AS "Date";

SELECT last_name,
COALESCE(commission_pct, 0)*250 AS "Commission"
FROM employees
WHERE department_id IN (80,90);

SELECT last_name, salary,
CASE
    WHEN commission_pct IS NOT NULL THEN salary + (salary * commission_pct)
    ELSE salary
END AS income
FROM employees
WHERE department_id IN (80,90);

SELECT first_name, LENGTH(first_name) AS "Length FN", last_name,
LENGTH(last_name) AS "Length LN", NULLIF(LENGTH(first_name), LENGTH(last_name)) AS "Compare Them"
FROM employees;

SELECT last_name,
COALESCE(commission_pct, salary, 10) AS "Comm"
FROM employees
ORDER BY commission_pct;

SELECT last_name,
CASE department_id
    WHEN 90 THEN 'Management'
    WHEN 80 THEN 'Sales'
    WHEN 60 THEN 'It'
    ELSE 'Other dept.'
END AS "Department"
FROM employees;

SELECT last_name,
CASE department_id
    WHEN 90 THEN 'Management'
    WHEN 80 THEN 'Sales'
    WHEN 60 THEN 'It'
    ELSE 'Other dept.'
END AS "Department"
FROM employees;
