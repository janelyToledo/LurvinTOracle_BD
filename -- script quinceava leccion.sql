-- script de la leccion 15

DROP VIEW IF EXISTS view_employees CASCADE;
DROP VIEW IF EXISTS view_euro_countries CASCADE;
DROP VIEW IF EXISTS view_high_pop CASCADE;
DROP VIEW IF EXISTS view_dept50 CASCADE;
DROP VIEW IF EXISTS view_dept50_readonly CASCADE;

DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS wf_countries CASCADE;
DROP TABLE IF EXISTS wf_world_regions CASCADE;
DROP TABLE IF EXISTS copy_employees CASCADE;

CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    department_id INTEGER,
    salary NUMERIC(10, 2),
    hire_date DATE
);

CREATE TABLE wf_countries (
    country_id INTEGER PRIMARY KEY,
    region_id INTEGER,
    country_name VARCHAR(100),
    capitol VARCHAR(100),
    location VARCHAR(100),
    population BIGINT
);

CREATE TABLE wf_world_regions (
    region_id INTEGER PRIMARY KEY,
    region_name VARCHAR(100)
);

CREATE TABLE copy_employees (
    employee_id INTEGER PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    department_id INTEGER,
    email VARCHAR(25),
    salary NUMERIC(10, 2),
    hire_date DATE
);

-- Inserción de datos en las tablas
INSERT INTO employees (employee_id, first_name, last_name, email, department_id, salary, hire_date) VALUES
(100, 'Steven', 'King', 'SKING', 90, 24000.00, '2003-06-17'),
(101, 'Neena', 'Kochhar', 'NKOCHHAR', 90, 17000.00, '2005-09-21'),
(102, 'Lex', 'De Haan', 'LDEHAAN', 90, 17000.00, '2001-01-13'),
(103, 'Alexander', 'Hunold', 'AHUNOLD', 60, 9000.00, '2006-01-03'),
(104, 'Bruce', 'Ernst', 'BERNST', 60, 6000.00, '2007-05-21'),
(105, 'Diana', 'Lorentz', 'DLORENTZ', 60, 4200.00, '2007-02-07'),
(106, 'Nancy', 'Greenberg', 'NGREENBE', 50, 12000.00, '2002-08-17'),
(107, 'Daniel', 'Faviet', 'DFAVIET', 50, 9000.00, '2008-08-16'),
(108, 'John', 'Chen', 'JCHEN', 50, 8200.00, '2005-09-28'),
(109, 'Ismael', 'Sciarra', 'ISCIARRA', 50, 7700.00, '2005-09-30'),
(110, 'Jose Manuel', 'Urman', 'JMURMAN', 50, 7800.00, '2006-03-07'),
(111, 'Luisa', 'Mendez', 'LMENDEZ', 50, 6500.00, '2007-12-19'),
(112, 'Juan', 'Perez', 'JP', 50, 5000.00, '2008-01-15'),
(124, 'Kevin', 'Mourgos', 'KMOURGOS', 50, 5800.00, '2007-11-16');

INSERT INTO wf_world_regions (region_id, region_name) VALUES
(1, 'Europe'),
(2, 'Americas'),
(3, 'Asia'),
(4, 'Middle East and Africa');

INSERT INTO wf_countries (country_id, region_id, country_name, capitol, location, population) VALUES
(1, 1, 'Germany', 'Berlin', 'Europe', 83000000),
(2, 1, 'France', 'Paris', 'Europe', 67000000),
(3, 2, 'United States', 'Washington D.C.', 'North America', 330000000),
(4, 1, 'Spain', 'Madrid', 'Europe', 47000000),
(5, 3, 'Japan', 'Tokyo', 'Asia', 126000000),
(6, 4, 'Egypt', 'Cairo', 'Africa', 102000000);

INSERT INTO copy_employees (employee_id, first_name, last_name, department_id, email, salary, hire_date) VALUES
(100, 'Steven', 'King', 90, 'SKING', 24000.00, '2003-06-17'),
(101, 'Neena', 'Kochhar', 90, 'NKOCHHAR', 17000.00, '2005-09-21'),
(102, 'Lex', 'De Haan', 90, 'LDEHAAN', 17000.00, '2001-01-13'),
(103, 'Alexander', 'Hunold', 60, 'AHUNOLD', 9000.00, '2006-01-03'),
(104, 'Bruce', 'Ernst', 60, 'BERNST', 6000.00, '2007-05-21'),
(105, 'Diana', 'Lorentz', 60, 'DLORENTZ', 4200.00, '2007-02-07'),
(106, 'Nancy', 'Greenberg', 50, 'NGREENBE', 12000.00, '2002-08-17'),
(107, 'Daniel', 'Faviet', 50, 'DFAVIET', 9000.00, '2008-08-16'),
(108, 'John', 'Chen', 50, 'JCHEN', 8200.00, '2005-09-28'),
(109, 'Ismael', 'Sciarra', 50, 'ISCIARRA', 7700.00, '2005-09-30'),
(110, 'Jose Manuel', 'Urman', 50, 'JMURMAN', 7800.00, '2006-03-07'),
(111, 'Luisa', 'Mendez', 50, 'LMENDEZ', 6500.00, '2007-12-19'),
(112, 'Juan', 'Perez', 50, 'JP', 5000.00, '2008-01-15'),
(124, 'Kevin', 'Mourgos', 50, 'KMOURGOS', 5800.00, '2007-11-16');


-- CREATE VIEW view_employees
-- AS SELECT employee_id, first_name, last_name, email
-- FROM copy_employees
-- WHERE employee_id BETWEEN 100 AND 124;

-- SELECT *
-- FROM view_employees;

-- CREATE OR REPLACE VIEW view_euro_countries("ID", "Country", "Capitol City", "Region")
-- AS SELECT c.country_id, c.country_name, c.capitol,
-- r.region_name
-- FROM wf_countries c JOIN wf_world_regions r
-- USING (region_id)
-- WHERE c.location LIKE '%Europe';

-- SELECT * FROM view_euro_countries
-- ORDER BY "Country";

-- CREATE OR REPLACE VIEW view_high_pop
-- ("Region ID", "Highest population")
-- AS SELECT region_id, MAX(population)
-- FROM wf_countries
-- GROUP BY region_id;

-- SELECT * FROM view_high_pop;

-- CREATE OR REPLACE VIEW view_dept50
-- AS SELECT department_id, employee_id, first_name, last_name, salary
-- FROM copy_employees
-- WHERE department_id = 50
-- WITH (check_option = CASCADED);

-- SELECT * FROM view_dept50;

-- UPDATE view_dept50
-- SET department_id = 90
-- WHERE employee_id = 124;

-- CREATE OR REPLACE VIEW view_dept50_readonly
-- AS SELECT department_id, employee_id, first_name, last_name, salary
-- FROM copy_employees
-- WHERE department_id = 50;

-- DROP VIEW IF EXISTS viewname;

-- SELECT e.last_name, e.salary, e.department_id, d.maxsal
-- FROM copy_employees e,
-- (SELECT department_id, MAX(salary) AS maxsal
-- FROM copy_employees
-- GROUP BY department_id) AS d
-- WHERE e.department_id = d.department_id
-- AND e.salary = d.maxsal;

-- SELECT last_name, hire_date
-- FROM copy_employees
-- ORDER BY hire_date
-- LIMIT 5;

-- SELECT last_name, hire_date
-- FROM (SELECT last_name, hire_date
-- FROM copy_employees
-- ORDER BY hire_date) AS subquery
-- LIMIT 5;