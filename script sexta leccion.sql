--script de la 6 leccion de oracle

SELECT department_name, city
FROM departments NATURAL JOIN locations;

SELECT last_name, department_name
FROM employees CROSS JOIN departments;

SELECT first_name, last_name, department_id, department_name
FROM employees JOIN departments USING (department_id);

SELECT first_name, last_name, department_id, department_name
FROM employees JOIN departments USING (department_id)
WHERE last_name = 'Higgins';

-- SELECT last_name, job_title
-- FROM employees e JOIN jobs j ON e.job_id = j.job_id;

-- SELECT last_name, job_title
-- FROM employees e JOIN jobs j ON e.job_id = j.job_id
-- WHERE last_name LIKE 'H%';

-- SELECT last_name, salary, grade_level, lowest_sal, highest_sal
-- FROM employees JOIN job_grades ON salary BETWEEN lowest_sal AND highest_sal;

SELECT last_name, department_name AS "Department", city
FROM employees
JOIN departments USING (department_id)
JOIN locations USING (location_id);

SELECT e.last_name, d.department_id, d.department_name
FROM employees e
LEFT OUTER JOIN departments d ON e.department_id = d.department_id;

SELECT e.last_name, d.department_id, d.department_name
FROM employees e
RIGHT OUTER JOIN departments d ON e.department_id = d.department_id;

SELECT e.last_name, d.department_id, d.department_name
FROM employees e
FULL OUTER JOIN departments d ON e.department_id = d.department_id;

-- SELECT last_name, e.job_id AS "Job", jh.job_id AS "Old job", end_date
-- FROM employees e LEFT OUTER JOIN job_history jh ON e.employee_id = jh.employee_id;

-- SELECT worker.last_name || ' works for ' || manager.last_name AS "Works for"
-- FROM employees worker JOIN employees manager ON worker.manager_id = manager.employee_id;

-- SELECT worker.last_name, worker.manager_id, manager.last_name AS "Manager name"
-- FROM employees worker JOIN employees manager ON worker.manager_id = manager.employee_id;

-- SELECT employee_id, last_name, job_id, manager_id
-- FROM employees
-- START WITH employee_id = 100
-- CONNECT BY PRIOR employee_id = manager_id;

-- SELECT last_name || ' reports to ' || PRIOR last_name AS "Walk Top Down"
-- FROM employees
-- START WITH last_name = 'King'
-- CONNECT BY PRIOR employee_id = manager_id;

-- SELECT LEVEL, last_name || ' reports to ' || PRIOR last_name AS "Walk Top Down"
-- FROM employees
-- START WITH last_name = 'King'
-- CONNECT BY PRIOR employee_id = manager_id;

-- SELECT LPAD(last_name, LENGTH(last_name) + (LEVEL * 2) - 2, '_') AS "Org Chart"
-- FROM employees
-- START WITH last_name = 'King'
-- CONNECT BY PRIOR employee_id = manager_id;

-- SELECT LPAD(last_name, LENGTH(last_name) + (LEVEL * 2) - 2, '_') AS "Org_Chart"
-- FROM employees
-- START WITH last_name = 'Grant'
-- CONNECT BY employee_id = PRIOR manager_id;

-- SELECT last_name
-- FROM employees
-- WHERE last_name != 'Higgins'
-- START WITH last_name = 'Kochhar'
-- CONNECT BY PRIOR employee_id = manager_id;

-- SELECT last_name
-- FROM employees
-- START WITH last_name = 'Kochhar'
-- CONNECT BY PRIOR employee_id = manager_id
-- AND last_name != 'Higgins';