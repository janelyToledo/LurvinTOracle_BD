-- script leccion octava de oracle

SELECT MAX(salary)
FROM employees;

SELECT MAX(salary)
FROM employees;

-- SELECT department_id, AVG(salary)
-- FROM employees
-- GROUP BY department_id;

SELECT last_name, first_name
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);


SELECT AVG(commission_pct)
FROM employees;

SELECT MAX(salary), MIN(salary), MIN(employee_id)
FROM employees
WHERE department_id = 60;

-- SELECT COUNT(job_id)
-- FROM employees; 

SELECT commission_pct
FROM employees;

SELECT COUNT(commission_pct)
FROM employees;

SELECT COUNT(*)
FROM employees
WHERE hire_date < '1996-01-01'; 

SELECT COUNT(*)
FROM employees
WHERE hire_date < '1996-01-01'; 

-- SELECT job_id
-- FROM employees; 

-- SELECT DISTINCT job_id
-- FROM employees;

-- SELECT DISTINCT job_id,
-- department_id
-- FROM employees;

-- SELECT DISTINCT job_id,
-- department_id
-- FROM employees; 

SELECT SUM(salary)
FROM employees
WHERE department_id = 90;

SELECT SUM(DISTINCT salary)
FROM employees
WHERE department_id = 90;

-- SELECT COUNT (DISTINCT
-- job_id)
-- FROM employees; -- Comentado: Usa job_id de employees

SELECT COUNT (DISTINCT salary)
FROM employees;

-- Esta línea está comentada porque 'your_table_name' no es una tabla real.
-- SELECT AVG(COALESCE(customer_orders, 0))
-- FROM your_table_name;


SELECT AVG(commission_pct)
FROM employees;

SELECT AVG(COALESCE(commission_pct, 0))
FROM employees;

SELECT AVG(commission_pct)
FROM employees;

SELECT AVG(COALESCE(commission_pct, 0))
FROM employees;