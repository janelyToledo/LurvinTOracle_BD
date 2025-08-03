-- script leccion 16 de oracle

-- Limpieza de secuencias y tablas para re-ejecutabilidad
DROP SEQUENCE IF EXISTS runner_id_seq CASCADE;
DROP SEQUENCE IF EXISTS departments_seq CASCADE;
DROP SEQUENCE IF EXISTS employees_seq CASCADE;

DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS runners CASCADE;
DROP TABLE IF EXISTS wf_countries CASCADE;
DROP TABLE IF EXISTS amy_copy_employees CASCADE;
DROP VIEW IF EXISTS amy_emps CASCADE;

-- Adaptación de la sintaxis de CREATE SEQUENCE
CREATE SEQUENCE runner_id_seq
INCREMENT BY 1
START WITH 1
MAXVALUE 50000
NO CYCLE;

CREATE SEQUENCE departments_seq;
CREATE SEQUENCE employees_seq;


-- Adaptación de las tablas para las inserciones y los índices
CREATE TABLE departments (
    department_id INTEGER,
    department_name VARCHAR(100),
    location_id INTEGER
);

CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hire_date DATE,
    department_id INTEGER
);

CREATE TABLE runners
(runner_id NUMERIC(6,0) PRIMARY KEY,
first_name VARCHAR(30),
last_name VARCHAR(30));

CREATE TABLE wf_countries (
    country_id INTEGER PRIMARY KEY,
    region_id INTEGER
);

CREATE TABLE amy_copy_employees (
    employee_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

-- Inserción de datos de ejemplo para asegurar que las consultas devuelvan resultados
INSERT INTO employees (employee_id, first_name, last_name, hire_date) VALUES
(nextval('employees_seq'), 'Steven', 'King', '1987-06-17'),
(nextval('employees_seq'), 'Neena', 'Kochhar', '1987-09-21'),
(nextval('employees_seq'), 'Lex', 'De Haan', '1987-01-13'),
(nextval('employees_seq'), 'Alexander', 'Hunold', '1988-01-03'),
(nextval('employees_seq'), 'John', 'King', '1987-02-15');

-- Consulta de información de secuencias (adaptada para PostgreSQL)
SELECT
    sequencename AS sequence_name,
    min_value,
    max_value,
    increment_by,
    last_value AS last_number
FROM
    pg_sequences
WHERE
    schemaname = CURRENT_SCHEMA();

-- Inserción con secuencias (adaptada)
INSERT INTO departments
(department_id, department_name, location_id)
VALUES (nextval('departments_seq'), 'Support', 2500);

INSERT INTO employees
(employee_id, department_id)
VALUES (nextval('employees_seq'), currval('departments_seq'));

INSERT INTO runners
(runner_id, first_name, last_name)
VALUES (nextval('runner_id_seq'), 'Joanne', 'Everely');

INSERT INTO runners
(runner_id, first_name, last_name)
VALUES (nextval('runner_id_seq'), 'Adam', 'Curtis');

SELECT runner_id, first_name, last_name
FROM runners;

-- Equivalente a SELECT runner_id_seq.CURRVAL FROM dual;
SELECT currval('runner_id_seq'::regclass);

-- Adaptación de ALTER SEQUENCE
ALTER SEQUENCE runner_id_seq
INCREMENT BY 1
MAXVALUE 999999
NO CYCLE;

ALTER SEQUENCE runner_id_seq
INCREMENT BY 1
MAXVALUE 90
NO CYCLE;

DROP SEQUENCE runner_id_seq;

-- Adaptación de la sintaxis de CREATE INDEX
CREATE INDEX wf_cont_reg_id_idx
ON wf_countries(region_id);

CREATE INDEX emps_name_idx
ON employees(first_name, last_name);

-- Adaptación para obtener información de índices (PostgreSQL)
SELECT
    t.relname AS table_name,
    i.relname AS index_name,
    a.attname AS column_name
FROM
    pg_class t,
    pg_class i,
    pg_index ix,
    pg_attribute a
WHERE
    t.oid = ix.indrelid
    AND i.oid = ix.indexrelid
    AND a.attrelid = t.oid
    AND a.attnum = ANY(ix.indkey)
    AND t.relname = 'employees';

-- Creación de índice funcional
CREATE INDEX upper_last_name_idx
ON employees (UPPER(last_name));

-- Consulta usando el índice funcional
SELECT *
FROM employees
WHERE UPPER(last_name) = 'KING';

SELECT *
FROM employees
WHERE UPPER(last_name) LIKE 'KIN%';

-- Adaptación de la consulta para usar el índice funcional
SELECT *
FROM employees
WHERE UPPER (last_name) IS NOT NULL
ORDER BY UPPER (last_name);

-- Creación de índice en la función de año (EXTRACT es IMMUTABLE)
CREATE INDEX emp_hire_year_idx
ON employees (EXTRACT(YEAR FROM hire_date));

-- Adaptación de la consulta para usar el nuevo índice
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1987;

DROP INDEX IF EXISTS emps_name_idx;
DROP INDEX IF EXISTS emp_hire_year_idx;
DROP INDEX IF EXISTS upper_last_name_idx;
DROP INDEX IF EXISTS wf_cont_reg_id_idx;

-- Adaptación de SYNONYM a VIEW, que es la forma recomendada en PostgreSQL
CREATE VIEW amy_emps AS SELECT * FROM amy_copy_employees;

DROP VIEW amy_emps;