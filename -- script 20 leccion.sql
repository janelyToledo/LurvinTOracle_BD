--  script 20 oracle

DROP TABLE IF EXISTS emp CASCADE;
DROP TABLE IF EXISTS dept CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;

CREATE TABLE departments (
    department_id INTEGER PRIMARY KEY,
    department_name VARCHAR(100),
    location_id INTEGER
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

CREATE TABLE dept AS SELECT * FROM departments;
ALTER TABLE dept ADD CONSTRAINT dept_pk PRIMARY KEY (department_id);

CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id VARCHAR(10),
    salary NUMERIC(10, 2),
    commission_pct NUMERIC(4, 2),
    manager_id INTEGER,
    department_id INTEGER REFERENCES dept(department_id)
);

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES
(100, 'Steven', 'King', 'SKING', '515.123.4567', '2003-06-17', 'AD_PRES', 24000, NULL, NULL, 90),
(101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '2005-09-21', 'AD_VP', 17000, NULL, 100, 90),
(102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', '2001-01-13', 'AD_VP', 17000, NULL, 100, 90),
(103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', '2006-01-03', 'IT_PROG', 9000, NULL, 102, 60),
(104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', '2007-05-21', 'IT_PROG', 6000, NULL, 103, 60);

CREATE TABLE emp AS SELECT * FROM employees;
ALTER TABLE emp ADD CONSTRAINT emp_dept_fk FOREIGN KEY (department_id) REFERENCES dept(department_id) ON DELETE CASCADE;

SELECT COUNT(*) AS "Num emps" FROM emp;

SELECT 'Available departments:' AS info;
SELECT department_id, department_name FROM dept ORDER BY department_id LIMIT 5;

DELETE FROM dept WHERE department_id = 10;

SELECT COUNT(*) AS "Num emps after delete" FROM emp;

DROP SEQUENCE IF EXISTS ct_seq CASCADE;
CREATE SEQUENCE ct_seq START WITH 1000 INCREMENT BY 1;

WITH valid_dept AS (
    SELECT department_id FROM dept LIMIT 1
)
INSERT INTO emp
(employee_id, first_name, last_name, email, phone_number,
hire_date, job_id, salary, commission_pct, manager_id, department_id)
SELECT 
    NEXTVAL('ct_seq'), 'Kaare', 'Hansen', 'KHANSEN', '4496583212',
    CURRENT_DATE, 'IT_PROG', 6500, NULL, 100, v.department_id
FROM valid_dept v;

CREATE INDEX emp_indx ON emp(employee_id DESC, UPPER(SUBSTRING(first_name, 1, 1) || ' ' || last_name));

SELECT 
    grantee,
    privilege_type,
    is_grantable
FROM information_schema.table_privileges
WHERE table_name = 'emp'
AND table_schema = CURRENT_SCHEMA();

SELECT 'Table operations completed successfully' AS status;

SELECT employee_id, first_name, last_name, department_id
FROM emp 
WHERE employee_id >= 1000;

SELECT d.department_id, d.department_name, COUNT(e.employee_id) AS emp_count
FROM dept d
LEFT JOIN emp e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY d.department_id;