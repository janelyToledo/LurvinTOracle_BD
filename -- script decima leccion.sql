-- script decima leccion oracle

SELECT MAX(salary)
FROM employees;

SELECT MAX(salary)
FROM employees;

-- SELECT select_list
-- FROM table
-- WHERE expression operator
-- (SELECT select_list
-- FROM table);

-- SELECT select_list
-- FROM table
-- WHERE expression operator
-- (SELECT select_list
-- FROM table);

SELECT first_name, last_name,
hire_date
FROM employees
WHERE hire_date >
(SELECT hire_date
FROM employees
WHERE last_name = 'Vargas');

SELECT last_name
FROM employees
WHERE department_id =
(SELECT department_id
FROM employees
WHERE last_name = 'Grant');

SELECT last_name
FROM employees
WHERE department_id =
(SELECT department_id
FROM employees
WHERE last_name = 'Grant');

-- SELECT last_name, job_id, department_id
-- FROM employees
-- WHERE department_id =
-- (SELECT department_id
-- FROM departments
-- WHERE department_name = 'Marketing')
-- ORDER BY job_id;

-- SELECT last_name, job_id, salary, department_id
-- FROM employees
-- WHERE job_id =
-- (SELECT job_id
-- FROM employees
-- WHERE employee_id = 141)
-- AND department_id =
-- (SELECT department_id
-- FROM departments
-- WHERE location_id = 1500);

SELECT last_name, salary
FROM employees
WHERE salary <
(SELECT AVG(salary)
FROM employees);

SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) >
(SELECT MIN(salary)
FROM employees
WHERE department_id = 50);

SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) >
(SELECT MIN(salary)
FROM employees
WHERE department_id = 50);

SELECT first_name, last_name
FROM employees
WHERE salary =
(SELECT salary
FROM employees
WHERE department_id = 20);

SELECT first_name, last_name
FROM employees
WHERE salary =
(SELECT salary
FROM employees
WHERE department_id = 20);

SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) IN
(SELECT EXTRACT(YEAR FROM hire_date)
FROM employees
WHERE department_id=90);

SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) IN
(SELECT EXTRACT(YEAR FROM hire_date)
FROM employees
WHERE department_id=90);

SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) < ANY
(SELECT EXTRACT(YEAR FROM hire_date)
FROM employees
WHERE department_id=90);

SELECT last_name, hire_date FROM employees
WHERE EXTRACT(YEAR FROM hire_date) < ALL
(SELECT EXTRACT(YEAR FROM hire_date)
FROM employees
WHERE department_id=90);

-- SELECT last_name,
-- employee_id
-- FROM employees
-- WHERE employee_id IN
-- (SELECT manager_id
-- FROM employees);

-- SELECT last_name, employee_id
-- FROM employees
-- WHERE employee_id <= ALL
-- (SELECT manager_id
-- FROM employees);

SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) < ANY
(SELECT salary
FROM employees
WHERE department_id IN (10,20))
ORDER BY department_id;

-- SELECT employee_id, manager_id, department_id
-- FROM employees
-- WHERE(manager_id,department_id) IN
-- (SELECT manager_id,department_id
-- FROM employees
-- WHERE employee_id IN (149,174))
-- AND employee_id NOT IN (149,174);

-- SELECT employee_id, manager_id, department_id
-- FROM employees
-- WHERE(manager_id,department_id) IN
-- (SELECT manager_id,department_id
-- FROM employees
-- WHERE employee_id IN (149,174))
-- AND employee_id NOT IN (149,174);

-- SELECT employee_id,
-- manager_id,
-- department_id
-- FROM employees
-- WHERE manager_id IN
-- (SELECT manager_id
-- FROM employees
-- WHERE employee_id IN
-- (149,174))
-- AND department_id IN
-- (SELECT department_id
-- FROM employees
-- WHERE employee_id IN
-- (149,174))
-- AND employee_id NOT IN(149,174);

-- SELECT employee_id,
-- manager_id,
-- department_id
-- FROM employees
-- WHERE manager_id IN
-- (SELECT manager_id
-- FROM employees
-- WHERE employee_id IN
-- (149,174))
-- AND department_id IN
-- (SELECT department_id
-- FROM employees
-- WHERE employee_id IN
-- (149,174))
-- AND employee_id NOT IN(149,174);

-- SELECT employee_id,
-- manager_id,
-- department_id
-- FROM employees
-- WHERE manager_id IN
-- (SELECT manager_id
-- FROM employees
-- WHERE employee_id IN
-- (149,174))
-- AND department_id IN
-- (SELECT department_id
-- FROM employees
-- WHERE employee_id IN
-- (149,174))
-- AND employee_id NOT IN(149,174);

-- SELECT first_name, last_name,
-- job_id
-- FROM employees
-- WHERE job_id =
-- (SELECT job_id
-- FROM employees
-- WHERE last_name = 'Ernst');

-- SELECT first_name, last_name,
-- job_id
-- FROM employees
-- WHERE job_id =
-- (SELECT job_id
-- FROM employees
-- WHERE last_name = 'Ernst');

-- SELECT first_name, last_name,
-- job_id
-- FROM employees
-- WHERE job_id IN
-- (SELECT job_id
-- FROM employees
-- WHERE last_name = 'Ernst');

SELECT o.first_name,o.last_name,
o.salary
FROM employees o
WHERE o.salary >
(SELECT AVG(i.salary)
FROM employees i
WHERE i.department_id =
o.department_id);

SELECT o.first_name,
o.last_name, o.salary
FROM employees o
WHERE o.salary >
(SELECT AVG(i.salary)
FROM employees i
WHERE i.department_id =
o.department_id);

SELECT o.first_name,
o.last_name, o.salary
FROM employees o
WHERE o.salary >
(SELECT AVG(i.salary)
FROM employees i
WHERE i.department_id =
o.department_id);

-- SELECT last_name AS "Not a Manager"
-- FROM employees emp
-- WHERE NOT EXISTS
-- (SELECT 1
-- FROM employees mgr
-- WHERE mgr.manager_id = emp.employee_id);

-- SELECT last_name AS "Not a Manager"
-- FROM employees emp
-- WHERE emp.employee_id NOT IN
-- (SELECT mgr.manager_id
-- FROM employees mgr);

-- SELECT last_name AS "Not a Manager"
-- FROM employees emp
-- WHERE emp.employee_id NOT IN
-- (SELECT mgr.manager_id
-- FROM employees mgr);

-- WITH subquery_name AS (subquery),
-- subquery_name2 AS (subquery)
-- SELECT column_list
-- FROM {table | subquery_name | view}
-- WHERE condition is true;

-- WITH managers AS
-- (SELECT DISTINCT manager_id
-- FROM employees
-- WHERE manager_id IS NOT NULL)
-- SELECT last_name AS "Not a manager"
-- FROM employees
-- WHERE employee_id NOT IN
-- (SELECT manager_id
-- FROM managers);

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