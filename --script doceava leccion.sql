--script 12 leccion de oracle

DROP TABLE IF EXISTS copy_employees;
DROP TABLE IF EXISTS copy_departments;

CREATE TABLE copy_departments (
    department_id INTEGER PRIMARY KEY,
    department_name VARCHAR(50)
);

INSERT INTO copy_departments (department_id, department_name) VALUES
(1, 'Sales'),
(2, 'Management'),
(3, 'IT'),
(4, 'Accounting');

CREATE TABLE copy_employees (
    employee_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    hire_date DATE,
    salary NUMERIC(10,2),
    department_id INTEGER
);

INSERT INTO copy_employees (employee_id, first_name, last_name, email, phone_number, hire_date, salary, department_id) VALUES
(1, 'Luis', 'López', 'luis.lopez@email.com', '987654321', '2020-01-01', 5200.00, 1),
(2, 'Ana', 'Martínez', 'ana.martinez@email.com', '876543210', '2021-03-15', 5800.00, 2),
(3, 'Carlos', 'Pérez', 'carlos.perez@email.com', '765432109', '2019-06-10', 2500.00, 3),
(4, 'Laura', 'Gómez', 'laura.gomez@email.com', '654321098', '2022-02-20', 4500.00, 4);

SELECT * FROM copy_employees;
SELECT * FROM copy_departments;

ALTER TABLE copy_employees ADD COLUMN department_name VARCHAR(50);

UPDATE copy_employees
SET department_name = (
    SELECT department_name
    FROM copy_departments
    WHERE copy_departments.department_id = copy_employees.department_id
);

SELECT employee_id, salary, department_name
FROM copy_employees
ORDER BY department_id;
