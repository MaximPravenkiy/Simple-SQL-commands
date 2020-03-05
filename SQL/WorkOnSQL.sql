CREATE DATABASE IF NOT EXISTS staff;
USE staff;
CREATE TABLE IF NOT EXISTS employees (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT primary key,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    salary INT NOT NULL
);
CREATE TABLE IF NOT EXISTS post (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT primary key,
    position_held VARCHAR(40) NOT NULL
);
INSERT INTO employees (id, first_name, last_name, salary) VALUES (null, 'Andrey', 'Filatov', 35000);
INSERT INTO employees (id, first_name, last_name, salary) VALUES (null, 'Valentina', 'Abrosimova', 47000);
INSERT INTO employees (id, first_name, last_name, salary) VALUES (null, 'Gordey', 'Gorohov', 23000);
INSERT INTO employees (id, first_name, last_name, salary) VALUES (null, 'Zahar', 'Krotov', 55000);
INSERT INTO employees (id, first_name, last_name, salary) VALUES (null, 'Marina', 'Pronina', 29000);

INSERT INTO post (id, position_held) VALUES (null, 'Buhgalter');
INSERT INTO post (id, position_held) VALUES (null, 'Inzhener');
INSERT INTO post (id, position_held) VALUES (null, 'Menedzher');

ALTER TABLE employees ADD position_held INTEGER NOT NULL;
ALTER TABLE employees CHANGE COLUMN position_held position_id INTEGER NOT NULL;
ALTER TABLE employees CHANGE COLUMN position_id position_id INTEGER UNSIGNED NOT NULL;
ALTER TABLE employees ADD FOREIGN KEY (position_id) REFERENCES post(id);

UPDATE employees SET position_id=1 WHERE id IN (3,5);
UPDATE employees SET position_id=2 WHERE id IN (4);
UPDATE employees SET position_id=3 WHERE id IN (1,2);

SELECT employee.first_name, employee.last_name, employee.salary, eposition.position_held
FROM employees employee
INNER JOIN post eposition ON  employee.position_id=eposition.id;

SELECT employee.first_name, employee.last_name, employee.salary, eposition.position_held
FROM employees employee
INNER JOIN post eposition ON employee.position_id=eposition.id
WHERE salary<30000;

UPDATE employees SET salary=20000 WHERE id=1;

SELECT employee.first_name, employee.last_name, employee.salary
FROM employees employee
INNER JOIN post eposition ON employee.position_id=eposition.id
WHERE employee.salary<30000 AND eposition.position_held='Buhgalter';

INSERT INTO employees (id, first_name, last_name, salary, position_id) VALUES (null, 'Grigoriy', 'Krutov', 39000, 2);
INSERT INTO employees (id, first_name, last_name, salary, position_id) VALUES (null, 'Alexandra', 'Ganina', 62000, 3);
INSERT INTO employees (id, first_name, last_name, salary, position_id) VALUES (null, 'Viktor', 'Nosov', 70000, 2);
INSERT INTO employees (id, first_name, last_name, salary, position_id) VALUES (null, 'Roman', 'Trunin', 18000, 1);

CREATE TABLE IF NOT EXISTS inferior_supervisor (
	id_inferior INT UNSIGNED  NOT NULL,
    id_supervisor INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_inferior) REFERENCES employees(id),
    FOREIGN KEY (id_supervisor) REFERENCES employees(id)
);

INSERT INTO inferior_supervisor (id_inferior, id_supervisor) VALUES (1, 3);
INSERT INTO inferior_supervisor (id_inferior, id_supervisor) VALUES (1, 5);
INSERT INTO inferior_supervisor (id_inferior, id_supervisor) VALUES (1, 9);
INSERT INTO inferior_supervisor (id_inferior, id_supervisor) VALUES (1, 13);
INSERT INTO inferior_supervisor (id_inferior, id_supervisor) VALUES (3, 4);
INSERT INTO inferior_supervisor (id_inferior, id_supervisor) VALUES (3, 14);
INSERT INTO inferior_supervisor (id_inferior, id_supervisor) VALUES (5, 9);
INSERT INTO inferior_supervisor (id_inferior, id_supervisor) VALUES (5, 14);
INSERT INTO inferior_supervisor (id_inferior, id_supervisor) VALUES (9, 13);
INSERT INTO inferior_supervisor (id_inferior, id_supervisor) VALUES (9, 14);
INSERT INTO inferior_supervisor (id_inferior, id_supervisor) VALUES (15, 2);
INSERT INTO inferior_supervisor (id_inferior, id_supervisor) VALUES (15, 3);
INSERT INTO inferior_supervisor (id_inferior, id_supervisor) VALUES (15, 5);

SELECT employee.id, employee.first_name, employee.last_name, employee.salary, eposition.position_held
FROM employees employee
INNER JOIN post eposition ON  employee.position_id=eposition.id
INNER JOIN inferior_supervisor ON employee.id=id_inferior
WHERE id_supervisor=15;

