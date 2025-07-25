-- TABLAS DE LA SECCIÓN 3 POSTGRESQL

SELECT last_name, salary
FROM employees
WHERE salary > 12000;

SELECT last_name || ' ' || ROUND(salary * 1.05, 2)::numeric(10,2) AS "Employee Raise"
FROM employees
WHERE first_name LIKE 'C%'
   OR last_name ILIKE '%s%';

SELECT last_name || ' ' || ROUND(salary * 1.05, 2)::numeric(10,2) AS "Employee Raise",
       first_name
FROM employees
WHERE first_name LIKE 'C%'
   OR last_name ILIKE '%s%';

SELECT last_name || ' ' || ROUND(salary * 1.05, 2)::numeric(10,2) AS "Employee Raise",
       first_name
FROM employees
WHERE first_name LIKE 'C%'
   OR last_name ILIKE '%s%';

SELECT last_name || ' ' || ROUND(salary * 1.05, 2)::numeric(10,2) AS "Employee Raise",
       first_name
FROM employees
WHERE first_name LIKE 'C%'
  AND last_name ILIKE '%s%';

SELECT employee_id,
       first_name
FROM employees
WHERE employee_id < 105
ORDER BY last_name;

SELECT last_name
FROM employees
ORDER BY last_name;

SELECT last_name
FROM employees
ORDER BY last_name DESC;