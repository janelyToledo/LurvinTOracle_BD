-- script catorce leccion de oracle


DROP TABLE IF EXISTS clients CASCADE; 
DROP TABLE IF EXISTS copy_job_history CASCADE;
DROP TABLE IF EXISTS copy_employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS copy_departments CASCADE;
DROP TABLE IF EXISTS jobs CASCADE; 
DROP TABLE IF EXISTS employees CASCADE;

CREATE TABLE departments (
    department_id INTEGER PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE copy_departments (
    department_id INTEGER CONSTRAINT c_dept_dept_id_pk PRIMARY KEY, 
    department_name VARCHAR(100)
);


/*
CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id VARCHAR(10),
    salary NUMERIC(10, 2),
    commission_pct NUMERIC(2,2),
    manager_id INTEGER,
    department_id INTEGER REFERENCES departments(department_id)
);
*/


CREATE TABLE clients
(client_number INTEGER,
first_name VARCHAR(14), 
last_name VARCHAR(13)); 

DROP TABLE IF EXISTS clients CASCADE;
CREATE TABLE clients
(client_number INTEGER CONSTRAINT clients_client_num_pk
PRIMARY KEY,¿
first_name VARCHAR(14),
last_name VARCHAR(13));

DROP TABLE IF EXISTS clients CASCADE;
CREATE TABLE clients
(client_number INTEGER,
last_name VARCHAR(13),
email VARCHAR(80));

DROP TABLE IF EXISTS clients CASCADE;
CREATE TABLE clients
(client_number INTEGER CONSTRAINT clients_client_num_pk PRIMARY KEY,
last_name VARCHAR(13) NOT NULL, 
email VARCHAR(80) CONSTRAINT clients_emil_uk UNIQUE);


DROP TABLE IF EXISTS clients CASCADE;
CREATE TABLE clients
(client_number INTEGER CONSTRAINT clients_client_num_pk PRIMARY KEY, 
last_name VARCHAR(13) NOT NULL, 
email VARCHAR(80));

DROP TABLE IF EXISTS clients CASCADE;
CREATE TABLE clients (
client_number INTEGER NOT NULL, 
first_name VARCHAR(20), 
last_name VARCHAR(20), 
phone VARCHAR(20), 
email VARCHAR(80) NOT NULL, 
CONSTRAINT clients_phone_email_uk UNIQUE (email,phone)
);

DROP TABLE IF EXISTS clients CASCADE;
CREATE TABLE clients(
client_number INTEGER, 
first_name VARCHAR(20),
last_name VARCHAR(20), 
phone VARCHAR(20), 
email VARCHAR(80) NOT NULL, 
CONSTRAINT clients_phone_email_uk UNIQUE (email,phone),
CONSTRAINT clients_client_num_pk PRIMARY KEY (client_number)
);

INSERT INTO clients (client_number, first_name, last_name, phone, email)
VALUES (7234, 'Lonny', 'Vigil', '4072220091', 'lbv@lbv.net'); 


DROP TABLE IF EXISTS clients CASCADE;
CREATE TABLE clients
(client_number INTEGER CONSTRAINT clients_client_num_pk
PRIMARY KEY, 
first_name VARCHAR(14), 
last_name VARCHAR(13)); 

DROP TABLE IF EXISTS clients CASCADE;
CREATE TABLE clients
(client_number INTEGER,
first_name VARCHAR(14),
last_name VARCHAR(13), 
CONSTRAINT clients_client_num_pk PRIMARY KEY
(client_number));

CREATE TABLE copy_job_history
(employee_id INTEGER,
start_date DATE,
job_id VARCHAR(10), 
department_id INTEGER, 
CONSTRAINT copy_jhist_id_st_date_pk PRIMARY KEY(employee_id,
start_date));

CREATE TABLE copy_employees
(employee_id INTEGER CONSTRAINT copy_emp_pk PRIMARY KEY, 
first_name VARCHAR(20), 
last_name VARCHAR(25), 
department_id INTEGER, 
email VARCHAR(25), 
CONSTRAINT c_emps_dept_id_fk FOREIGN KEY (department_id)
REFERENCES departments(department_id));

DROP TABLE IF EXISTS copy_employees CASCADE;
CREATE TABLE copy_employees
(employee_id INTEGER CONSTRAINT copy_emp_pk PRIMARY KEY, 
first_name VARCHAR(20), 
last_name VARCHAR(25), 
department_id INTEGER,
email VARCHAR(25),
CONSTRAINT cdept_dept_id_fk FOREIGN KEY (department_id)
REFERENCES copy_departments(department_id));

DROP TABLE IF EXISTS copy_employees CASCADE;
CREATE TABLE copy_employees
(employee_id INTEGER CONSTRAINT copy_emp_pk PRIMARY KEY, 
first_name VARCHAR(20),
last_name VARCHAR(25), 
department_id INTEGER,
email VARCHAR(25),
CONSTRAINT cdept_dept_id_fk FOREIGN KEY (department_id)
REFERENCES copy_departments(department_id) ON DELETE CASCADE);

DROP TABLE IF EXISTS copy_employees CASCADE;
CREATE TABLE copy_employees
(employee_id INTEGER CONSTRAINT copy_emp_pk PRIMARY KEY,
first_name VARCHAR(20),
last_name VARCHAR(25), 
department_id INTEGER, 
email VARCHAR(25),
CONSTRAINT cdept_dept_id_fk FOREIGN KEY (department_id)
REFERENCES copy_departments(department_id) ON DELETE SET NULL);

DROP TABLE IF EXISTS copy_job_history CASCADE;
CREATE TABLE copy_job_history
(employee_id INTEGER, 
start_date DATE,
end_date DATE,
job_id VARCHAR(10), 
department_id INTEGER,
CONSTRAINT cjhist_emp_id_st_date_pk
PRIMARY KEY(employee_id, start_date),
CONSTRAINT cjhist_end_ck CHECK (end_date > start_date));

-- Inline column definition with CHECK constraint
-- This is an example snippet, not a full CREATE TABLE statement
-- salary NUMERIC(8,2) CONSTRAINT employees_min_sal_ck CHECK (salary > 0)

-- CONSTRAINT employees_min_sal_ck CHECK (salary > 0)

-- ALTER TABLE copy_employees
-- ADD CONSTRAINT emp_id_pk PRIMARY KEY (employee_id);

-- ALTER TABLE table_name
-- ADD [CONSTRAINT constraint_name] type of constraint
-- (column_name);

ALTER TABLE copy_employees
ADD CONSTRAINT emp_dept_fk FOREIGN KEY (department_id)
REFERENCES departments (department_id) ON DELETE CASCADE;

-- Note: 'table_name' and 'column_name' are placeholders, replace with actual names.
-- ALTER TABLE table_name
-- ALTER COLUMN column_name SET NOT NULL;

ALTER TABLE copy_employees
ALTER COLUMN email SET NOT NULL;
ALTER TABLE copy_departments
DROP CONSTRAINT c_dept_dept_id_pk CASCADE;

-- DISABLING and ENABLING CONSTRAINTS are Oracle-specific features.
-- PostgreSQL does not have direct equivalent commands to disable/enable constraints
-- without dropping and re-creating them, or using 'NOT VALID' for foreign keys.
-- The following statements are commented out.
/*
( employee_id INTEGER PRIMARY KEY DISABLE, -- PRIMARY KEY DISABLE is Oracle specific
...
...);

DISABLE CONSTRAINT c_emp_dept_id_fk;

DISABLE CONSTRAINT constraint_name CASCADE;

DISABLE CONSTRAINT c_dept_dept_id_pk CASCADE;

ALTER TABLE table_name
ENABLE CONSTRAINT constraint_name;

ENABLE CONSTRAINT c_dept_dept_id_pk;
*/

-- DROP COLUMN pk_column_name CASCADE; -- For single column
-- ALTER TABLE tablename
-- DROP COLUMN column_name1, DROP COLUMN column_name2 CASCADE; -- For multiple columns (PostgreSQL 10+)

-- To drop a primary key column(s) which might have associated constraints,
-- specify DROP COLUMN with CASCADE
-- ALTER TABLE tablename DROP COLUMN pk_column_name CASCADE;

SELECT constraint_name, table_name, constraint_type
FROM information_schema.table_constraints
WHERE table_name ='copy_employees' AND table_schema = CURRENT_SCHEMA; -- No direct 'status' column like Oracle's USER_CONSTRAINTS