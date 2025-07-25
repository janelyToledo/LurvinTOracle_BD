-- script leccion 7 de oracle

-- SELECT employees.last_name, employees.job_id, jobs.job_title
-- FROM employees
-- INNER JOIN jobs ON employees.job_id = jobs.job_id;

SELECT employees.last_name, departments.department_name
FROM employees
INNER JOIN departments ON employees.department_id = departments.department_id;

-- SELECT last_name, e.job_id, job_title
-- FROM employees e
-- INNER JOIN jobs j ON e.job_id = j.job_id
-- WHERE e.department_id = 80;

SELECT last_name, city
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id;

SELECT last_name, salary, grade_level, lowest_sal, highest_sal
FROM employees
INNER JOIN job_grades ON (salary BETWEEN lowest_sal AND highest_sal);

SELECT e.last_name, d.department_id, d.department_name
FROM employees e
RIGHT OUTER JOIN departments d ON e.department_id = d.department_id;

SELECT e.last_name, d.department_id, d.department_name
FROM employees e
LEFT OUTER JOIN departments d ON e.department_id = d.department_id;

SELECT e.last_name, d.department_id, d.department_name
FROM employees e
FULL OUTER JOIN departments d ON e.department_id = d.department_id;

-- SELECT e.last_name, e.first_name, j.job_title
-- FROM employees e
-- INNER JOIN jobs j ON e.job_id = j.job_id
-- ORDER BY e.last_name;

SELECT d.department_name, e.last_name
FROM departments d
LEFT OUTER JOIN employees e ON d.department_id = e.department_id
ORDER BY d.department_name;

SELECT e.last_name, d.department_name
FROM employees e
LEFT OUTER JOIN departments d ON e.department_id = d.department_id
ORDER BY e.last_name;

-- SELECT
--     e.first_name,
--     e.last_name,
--     j.job_title,
--     d.department_name,
--     l.city
-- FROM employees e
-- INNER JOIN jobs j ON e.job_id = j.job_id
-- INNER JOIN departments d ON e.department_id = d.department_id
-- INNER JOIN locations l ON d.location_id = l.location_id
-- ORDER BY e.last_name;

SELECT e.last_name, e.salary, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > 10000
ORDER BY e.salary DESC;

-- SELECT e.last_name, e.first_name, j.job_title, d.department_name
-- FROM employees e
-- INNER JOIN jobs j ON e.job_id = j.job_id
-- INNER JOIN departments d ON e.department_id = d.department_id
-- WHERE d.department_name = 'IT'
-- ORDER BY e.last_name;

SELECT
    d.department_name,
    l.city,
    COUNT(e.employee_id) AS total_empleados,
    AVG(e.salary) AS salario_promedio
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
INNER JOIN locations l ON d.location_id = l.location_id
GROUP BY d.department_name, l.city
ORDER BY total_empleados DESC;

-- SELECT
--     worker.last_name AS empleado,
--     manager.last_name AS manager
-- FROM employees worker
-- LEFT JOIN employees manager ON worker.manager_id = manager.employee_id
-- ORDER BY worker.last_name;

-- SELECT
--     worker.first_name || ' ' || worker.last_name AS empleado_completo,
--     COALESCE(manager.first_name || ' ' || manager.last_name, 'Sin Manager') AS manager_completo
-- FROM employees worker
-- LEFT JOIN employees manager ON worker.manager_id = manager.employee_id
-- ORDER BY worker.last_name;

SELECT e.last_name, e.first_name, 'Sin Departamento' AS status
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
WHERE d.department_id IS NULL;

SELECT d.department_name, 'Sin Empleados' AS status
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

SELECT
    l.city,
    l.country_id,
    COUNT(e.employee_id) AS total_empleados
FROM locations l
LEFT JOIN departments d ON l.location_id = d.location_id
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY l.city, l.country_id
ORDER BY total_empleados DESC;