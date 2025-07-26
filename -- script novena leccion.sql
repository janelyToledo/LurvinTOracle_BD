-- script novena leccion de oracle

SELECT MAX(salary)
FROM employees;

SELECT MAX(salary)
FROM employees;

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
-- FROM employees;

SELECT COUNT (DISTINCT salary)
FROM employees;

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

SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id;

SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id;

SELECT MAX(salary)
FROM employees
GROUP BY department_id;

SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id;

-- SELECT job_id, last_name, AVG(salary)
-- FROM employees
-- GROUP BY job_id;

-- SELECT COUNT(country_name), region_id
-- FROM wf_countries
-- GROUP BY region_id
-- ORDER BY region_id;

-- SELECT COUNT(*), region_id
-- FROM wf_countries
-- GROUP BY region_id
-- ORDER BY region_id;

SELECT department_id, MAX(salary)
FROM employees
WHERE last_name != 'King'
GROUP BY department_id;

-- SELECT region_id, ROUND(AVG(population)) AS population
-- FROM wf_countries
-- GROUP BY region_id
-- ORDER BY region_id;

-- SELECT department_id, job_id,
-- count(*)
-- FROM employees
-- WHERE department_id > 40
-- GROUP BY department_id, job_id;

-- SELECT department_id, job_id,
-- count(*)
-- FROM employees
-- WHERE department_id > 40
-- GROUP BY department_id, job_id;

SELECT MAX(avg_salary)
FROM (
    SELECT AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS department_averages;

SELECT department_id,MAX(salary)
FROM employees
GROUP BY department_id
HAVING COUNT(*)>1
ORDER BY department_id;

-- SELECT region_id,
-- ROUND(AVG(population))
-- FROM wf_countries
-- GROUP BY region_id
-- HAVING MIN(population)>300000
-- ORDER BY region_id;

-- SELECT AVG(height) FROM students;
-- SELECT AVG(height) FROM students WHERE year_in_school = 10;
-- SELECT AVG(height) FROM students WHERE year_in_school = 11;
-- SELECT AVG(height) FROM students WHERE year_in_school = 12;

-- SELECT department_id, job_id, SUM(salary)
-- FROM employees
-- WHERE department_id < 50
-- GROUP BY ROLLUP (department_id, job_id);

-- SELECT department_id, job_id, SUM(salary)
-- FROM employees
-- WHERE department_id < 50
-- GROUP BY ROLLUP (department_id, job_id);

-- SELECT department_id, job_id, SUM(salary)
-- FROM employees
-- WHERE department_id < 50
-- GROUP BY department_id, job_id;

-- SELECT department_id, job_id, SUM(salary)
-- FROM employees
-- WHERE department_id < 50
-- GROUP BY CUBE (department_id, job_id);

-- SELECT department_id, job_id, manager_id, SUM(salary)
-- FROM employees
-- WHERE department_id < 50
-- GROUP BY GROUPING SETS
-- ((job_id, manager_id),(department_id, job_id),
-- (department_id, manager_id));

-- SELECT department_id, job_id, SUM(salary),
-- GROUPING(department_id) AS "Dept sub total",
-- GROUPING(job_id) AS "Job sub total"
-- FROM employees
-- WHERE department_id < 50
-- GROUP BY CUBE (department_id, job_id);

-- SELECT a_id
-- FROM a
-- UNION
-- SELECT b_id
-- FROM b;

-- SELECT a_id
-- FROM a
-- UNION ALL
-- SELECT b_id
-- FROM b;

-- SELECT a_id
-- FROM a
-- INTERSECT
-- SELECT b_id
-- FROM b;

-- SELECT a_id
-- FROM a
-- EXCEPT
-- SELECT b_id
-- FROM b;

SELECT hire_date, employee_id, NULL AS job_id
FROM employees
UNION
SELECT NULL, employee_id,
job_id
FROM job_history;

SELECT hire_date, employee_id, NULL AS job_id
FROM employees
UNION
SELECT NULL, employee_id, job_id
FROM job_history
ORDER BY employee_id;

SELECT hire_date, employee_id, NULL AS job_id
FROM employees
UNION
SELECT NULL, employee_id, job_id
FROM job_history
ORDER BY employee_id;

SELECT hire_date, employee_id, NULL::date AS start_date_ph,
NULL::date AS end_date_ph, NULL AS job_id_ph, department_id
FROM employees
UNION
SELECT NULL, employee_id, NULL::date AS start_date_ph_hist, NULL::date AS end_date_ph_hist,
NULL AS job_id_ph_hist, NULL::integer AS department_id_ph
FROM job_history
ORDER BY employee_id;