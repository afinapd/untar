SELECT last_name
FROM employees;

SELECT * FROM employees;

-- memilih kolom last_name, employee_id sama salary dari tabel employees
SELECT last_name, employee_id, salary
FROM employees;

-- projection & selection 
-- memilih kolom last_name dari tabel employees, yg mempunyai salary 24000
SELECT last_name
FROM employees 
WHERE salary like 24000; 

-- memilih kolom last_name, salary, dan salary dalam 1 tahun daru tabel employees
SELECT last_name, salary, salary * 12
FROM employees;

SELECT last_name, salary, 10 * (salary + 500)
FROM employees;

-- NULL
SELECT * FROM employees;
SELECT last_name, salary, bonus, salary * bonus
FROM employees; 

-- ALIAS
SELECT last_name "nama akhir", salary gaji, salary * 12 as "Gaji 1 Tahun" 
FROM employees;

-- DESC
DESC employees;
DESC departments;

-- concate menggabungkan 2 kolom
-- last_name dan first_name, jadi 1 kolom, di tabel employees menggunakan spasi
SELECT last_name || ' ' || first_name as nama
FROM employees; 

-- distinct
SELECT * FROM employees;
SELECT DISTINCT job_id FROM employees;

-- where
SELECT last_name
FROM employees 
WHERE salary = 24000; 

-- 