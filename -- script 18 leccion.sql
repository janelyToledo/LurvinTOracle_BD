-- script 18 leccion oracle

DROP TABLE IF EXISTS copy_departments;

CREATE TABLE copy_departments (
    department_id INTEGER,
    department_name VARCHAR(100),
    manager_id INTEGER,
    location_id INTEGER
);

INSERT INTO copy_departments (department_id, department_name, manager_id, location_id) VALUES
(10, 'Administration', 200, 1700),
(20, 'Marketing', 201, 1800),
(30, 'Purchasing', 114, 1700),
(40, 'Human Resources', 203, 2400),
(50, 'Shipping', 121, 1500),
(60, 'IT', 103, 1400);

BEGIN;

UPDATE copy_departments
SET manager_id = 101
WHERE department_id = 60;

SELECT * FROM copy_departments;

SAVEPOINT one;

UPDATE copy_departments
SET department_id = 140;

INSERT INTO copy_departments(department_id, department_name, manager_id, location_id)
VALUES(130, 'Estate Management', 102, 1500);

SELECT * FROM copy_departments;

ROLLBACK TO SAVEPOINT one;

SELECT * FROM copy_departments;

COMMIT;

SELECT * FROM copy_departments;