SELECT last_name, department_id, department_name
FROM employees 
NATURAL JOIN departments
WHERE department_id IN (50, 60, 90);

SELECT * FROM jobs
WHERE min_salary < 10000
ORDER BY job_id DESC;








-- BETWEEN AND
-- employee_id, last_name, sama bonus karyawan
-- yg memiliki bonus 500 s/d 1500 
SELECT first_name, last_name, bonus
FROM employees
WHERE bonus between 1500 and 2000; 

-- memilih employee_id, last_name, department_id karyawan 
-- yg employee id nya diantara 100 s/d 110 
SELECT last_name, employee_id, department_id karyawan
FROM employees 
WHERE employee_id BETWEEN 100 AND 110; 

-- IN
-- memilih employee_id, last_name, salary dari karyawan
-- yg employee id nya 100, 101, 102 
SELECT last_name, salary, department_id
FROM employees
WHERE department_id IN (70,80,110); 

-- LIKE
SELECT last_name, salary, department_id FROM hr.employees WHERE last_name LIKE 'S%'; 
-- huruf depan S 
SELECT last_name, salary, department_id FROM hr.employees WHERE last_name LIKE '%s'; 
-- huruf akhir s
SELECT last_name, salary, department_id FROM hr.employees WHERE last_name LIKE '_e%'; 
-- huruf kedua harus e

-- huruf ketiga r
SELECT last_name FROM employees WHERE last_name LIKE '__r%'; 

-- IS NULL
SELECT * FROM employees;
-- memilih employee_id, last_name dan bonus dari karyawan
-- yg tidak mempunyai bonus
SELECT last_name, employee_id, bonus
FROM employees
WHERE bonus IS NULL; 

-- IS NOT NULL
-- memilih employee_id, last_name dan department_id dari tabel karyawan
-- yg memiliki departemen ID
SELECT last_name, employee_id, department_id karyawan
FROM employees
WHERE department_id IS NOT NULL; 

-- AND
-- memilih employee_id, last_name, salary, department_id
-- yg salary nya di atas 10000 dan department ID nya 90
SELECT last_name, employee_id, salary, department_id
FROM employees 
WHERE salary > 10000 AND department_id = 90; 

-- OR
SELECT last_name, employee_id, salary, job_id
FROM employees 
WHERE salary > 17000 OR job_id = 'SA_REP' OR job_id = 'IT_PROG' OR job_id = 'ST_MAN'; 

-- NOT
SELECT employee_id, last_name, department_id
FROM employees
WHERE department_id NOT IN (50,110); 

-- ORDER BY
-- memilih last_name dan employee_id dari tabel employees
-- last_name diurutkan dari Z-A , employee_id diurutkan dari yg terkecil - terbesar
SELECT first_name as "ID Karyawan", last_name, employee_id 
FROM employees
ORDER BY first_name ASC; 

SELECT job_id, salary FROM employees
WHERE salary < 10000
ORDER BY job_id DESC; 

SELECT location_id, street_address 
FROM locations
WHERE location_id NOT IN (2500, 1400);

-- MIN MAX AVG
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM jobs;

SELECT MIN(BONUS), MAX(salary), AVG(salary)
FROM employees; 