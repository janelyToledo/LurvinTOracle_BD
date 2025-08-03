-- script Leccion 7 de oracle


DROP ROLE IF EXISTS scott;
DROP ROLE IF EXISTS manager;
DROP ROLE IF EXISTS jennifer_cho;
DROP ROLE IF EXISTS steven_king;
DROP ROLE IF EXISTS jason_tsang;
DROP ROLE IF EXISTS scott_king;
DROP VIEW IF EXISTS clients_from_sk;

DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS clients CASCADE;
DROP TABLE IF EXISTS my_contacts CASCADE;
DROP TABLE IF EXISTS wf_countries CASCADE;
DROP TABLE IF EXISTS amy_copy_employees CASCADE;
DROP TABLE IF EXISTS scott_king_clients CASCADE;
DROP TABLE IF EXISTS hq_emp CASCADE;
DROP VIEW IF EXISTS HQ_EMP;

CREATE ROLE scott WITH PASSWORD 'ur35scott' LOGIN;
CREATE ROLE jennifer_cho;
CREATE ROLE steven_king;
CREATE ROLE manager;
CREATE ROLE jason_tsang;
CREATE ROLE scott_king;

CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    salary NUMERIC(10, 2)
);

CREATE TABLE clients (
    client_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

CREATE TABLE scott_king_clients (
    client_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

CREATE TABLE wf_countries (
    country_name VARCHAR(100)
);

CREATE TABLE my_contacts
(first_name VARCHAR(15),
last_name VARCHAR(15),
email VARCHAR(30) CHECK(email ~ '.+@.+\..+'));


ALTER ROLE scott WITH PASSWORD 'imscott35';



GRANT CREATE ON SCHEMA public TO scott;
GRANT CREATE ON SCHEMA public TO manager;

GRANT UPDATE (salary) ON employees TO steven_king;


-- CREATE ROLE manager;
-- Ya se ha creado arriba.
-- Corregido para usar 'ON SCHEMA public'
GRANT manager TO jennifer_cho;

GRANT SELECT ON clients TO PUBLIC;

GRANT UPDATE(first_name, last_name) ON clients TO jennifer_cho, manager;
SELECT * FROM scott_king_clients;

CREATE VIEW clients_from_sk AS SELECT * FROM scott_king_clients;
-- 5. SELECT * FROM clients;
SELECT * FROM clients_from_sk;

GRANT SELECT, INSERT ON clients TO scott_king WITH GRANT OPTION;

-- GRANT SELECT ON jason_tsang.clients TO PUBLIC;
-- Se asume 'jason_tsang' es un esquema.
-- GRANT SELECT ON jason_tsang.clients TO PUBLIC;

REVOKE SELECT, INSERT ON clients FROM scott_king;

INSERT INTO employees (employee_id, first_name, last_name, email) VALUES
(1, 'Steven', 'King', 'steven.king@example.com'),
(2, 'Stephen', 'Jones', 'stephen.jones@example.com'),
(3, 'John', 'Doe', 'john.doe@example.com'),
(4, 'Peter', 'Hanson', 'pete.h@example.com');

SELECT first_name, last_name
FROM employees
WHERE first_name ~ '^Ste(v|ph)en$';

SELECT last_name, REGEXP_REPLACE(last_name, '^(H|h)(a|e|i|o|u)', '**')
AS "Name changed"
FROM employees;

INSERT INTO wf_countries (country_name) VALUES ('Republic of ab');
INSERT INTO wf_countries (country_name) VALUES ('Argentina');

SELECT country_name, (LENGTH(country_name) - LENGTH(REPLACE(country_name, 'ab', ''))) / LENGTH('ab') AS "Count of 'ab'"
FROM wf_countries
WHERE (LENGTH(country_name) - LENGTH(REPLACE(country_name, 'ab', ''))) / LENGTH('ab') > 0;

ALTER TABLE employees
ADD CONSTRAINT email_addr_chk
CHECK(email ~ '@');

-- La tabla ya fue creada arriba, por lo que este es un ejemplo de la sintaxis.
-- CREATE TABLE my_contacts
-- (first_name VARCHAR(15),
-- last_name VARCHAR(15),
-- email VARCHAR(30) CHECK(email ~ '.+@.+\..+'));