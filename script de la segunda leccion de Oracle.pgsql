--script de la segunda leccion de Oracle
-- Eliminar tablas si existen para evitar problemas
DROP TABLE IF EXISTS clients;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- primera tabla
CREATE TABLE departments (
    department_id   INTEGER PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

-- segunda tabla
CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    first_name  VARCHAR(50) NOT NULL,
    last_name   VARCHAR(50) NOT NULL,
    salary      DECIMAL(10,2)
);

-- tercera tabla
CREATE TABLE clients (
    client_id   INTEGER PRIMARY KEY,
    first_name  VARCHAR(50) NOT NULL,
    last_name   VARCHAR(50) NOT NULL,
    email       VARCHAR(100) UNIQUE NOT NULL,
    phone       VARCHAR(20),
    address     TEXT
);

-- primera tabla
INSERT INTO departments (department_id, department_name)
VALUES 
    (10, 'Administration'),
    (20, 'Marketing'),
    (30, 'Shipping'),
    (40, 'IT')
ON CONFLICT (department_id) DO NOTHING;

-- segunda tabla
INSERT INTO employees (employee_id, first_name, last_name, salary)
VALUES 
    (1, 'Ellen', 'Abel', 12000),
    (2, 'Curtis', 'Davies', 15000),
    (3, 'Lex', 'De Haan', 20000)
ON CONFLICT (employee_id) DO NOTHING;

-- tercera tabla
INSERT INTO clients (client_id, first_name, last_name, email, phone, address)
VALUES 
    (1, 'Ana', 'Ramirez', 'ana.ramirez@example.com', '987654321', 'Colonia Centro, La Ceiba'),
    (2, 'Luis', 'Martinez', 'luis.martinez@example.com', '998877665', 'Barrio Inglés, La Ceiba'),
    (3, 'Sofía', 'Gonzalez', 'sofia.gonzalez@example.com', '912345678', 'Zona Viva, La Ceiba')
ON CONFLICT (email) DO NOTHING;

-- Consultar todos los datos
SELECT 'Departments:' as table_info;
SELECT * FROM departments;

SELECT 'Employees:' as table_info;
SELECT * FROM employees;

SELECT 'Clients:' as table_info;
SELECT * FROM clients;