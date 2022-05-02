-- CASE
SELECT last_name, department_id, 
CASE department_id
WHEN 90 THEN 'Management'
WHEN 80 THEN 'Sales'
WHEN 60 THEN 'IT'
ELSE 'Other dept.'
END AS "Department"
FROM employees;

-- jika gaji > 24000 return 'High Salary'
-- gaji > 15000 'Average Salary'
-- gaji > 5000 'Low Salary'
-- selain itu return 'Other'
-- mau ambil kolom last_name & salary nya juga
SELECT last_name, salary, 
CASE 
WHEN salary > 24000 THEN 'High Salary'
WHEN salary > 15000 THEN 'Average Salary'
WHEN salary > 5000 THEN 'Low Salary'
ELSE 'Other Salary'
END AS "Salary" FROM employees;

-- DECODE
SELECT last_name, department_id, 
DECODE(department_id,
90, 'Management',
80, 'Sales',
60, 'It',
'Other dept.')
AS "Department"
FROM employees;

-- GA BISA
SELECT last_name, salary,
DECODE (salary, 
salary > 24000, 'High Salary', 
salary > 15000, 'Average Salary', 
salary > 5000, 'Low Salary', 
'Other.')
 AS "Comment" FROM employees;

-- NATURAL JOIN
-- harus memiliki nama kolom yg sama, nilainya sama, tipe data nya pun jg sama
-- JOIN TABLE EMPLOYEES + DEPARTMENTS
SELECT * FROM employees;
SELECT * FROM departments;

SELECT last_name, department_id, department_name
FROM employees NATURAL JOIN departments
WHERE department_id IN (50, 60, 90); 

-- JOIN TABLE EMPLOYEES + DEPARTMENTS + JOBS
SELECT * FROM jobs;

SELECT last_name, department_id, department_name, job_id, job_title
FROM employees NATURAL JOIN departments -- employees + departments
NATURAL JOIN jobs; -- employees + jobs

-- CROSS JOIN
-- melakukan join pada tiap baris antara table
-- TABLE EMPLOYEES + JOBS
SELECT last_name, employees.job_id, job_title
FROM employees CROSS JOIN jobs;

-- JOIN WITH USING
SELECT last_name, job_id, job_title
FROM employees JOIN jobs 
USING (job_id); 

-- 3 table
SELECT last_name, department_id, department_name, job_id, job_title
FROM employees JOIN departments USING (department_id) -- employees + departments
JOIN jobs USING (job_id);  -- employees + jobs

-- table alias biar lebih singkat
SELECT last_name, e.department_id, department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id; 

-- JOIN dengan ON 
SELECT last_name, e.department_id, department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id);

-- 3 table employees, departments, jobs
SELECT last_name, e.department_id, department_name, e.job_id, job_title
FROM employees e JOIN departments d -- employees + departments
ON (e.department_id = d.department_id)
JOIN jobs j -- employees + jobs
ON (e.job_id = j.job_id)
WHERE e.job_id = 'SA_REP'; 

-- ON with non equality operator
SELECT * FROM job_grades;

SELECT last_name, salary, grade_level, lowest_sal, highest_sal
FROM employees JOIN job_grades
ON(salary BETWEEN lowest_sal AND highest_sal);

-- OUTER JOIN

-- LEFT OUTER JOIN = mengambil semua baris yg ada di sebelah kiri klausa join
-- employees yg ga punya department_id tetap direturn
SELECT e.employee_id, last_name, d.department_id, department_name
FROM employees e LEFT OUTER JOIN departments d
ON (e.department_id = d.department_id); 

-- RIGHT OUTER JOIN = mengambil semua baris yg ada di sebelah kanan klausa join
-- department yg ga ada employees nya tetap direturn
SELECT e.employee_id, last_name, d.department_id, department_name
FROM employees e RIGHT OUTER JOIN departments d
ON (e.department_id = d.department_id);

-- FULL OUTER JOIN = ambil seluruh baris yg match & tidak match antara 2 table
-- isinya baris dari left outer join & right outer join tanpa duplikasi
SELECT e.employee_id, last_name, d.department_id, department_name
FROM employees e FULL OUTER JOIN departments d
ON (e.department_id = d.department_id);

-- SELF JOIN = melakukan join table itu sendiri
SELECT worker.last_name || ' bekerja untuk ' || manager.last_name
AS "Works for"
FROM employees worker JOIN employees manager
ON (worker.manager_id = manager.employee_id);

SELECT worker.last_name, worker.manager_id, manager.last_name
AS "Manager name"
FROM employees worker JOIN employees manager
ON (worker.manager_id = manager.employee_id);

-- HIERARCHIAL QUERIES
-- START WITH = akar 
-- CONNECT BY PRIOR = gimana cara join antar baris
-- LEVEL = cabangnya
SELECT employee_id, last_name, job_id, manager_id
FROM employees
START WITH employee_id = 100
CONNECT BY PRIOR employee_id = manager_id; 

SELECT last_name ||' reports to ' || PRIOR last_name AS "Walk Top Down"
FROM employees
START WITH last_name = 'King'
CONNECT BY PRIOR employee_id = manager_id; 

-- LEVEL = jumlah langkah dari si akar
SELECT LEVEL, last_name || ' reports to ' || PRIOR last_name AS "Walk Top Down"
FROM employees
START WITH last_name = 'King'
CONNECT BY PRIOR employee_id = manager_id;

-- LPAD bikin rata kiri
SELECT LPAD(last_name, length(last_name) + (LEVEL*2)-2, ' ') -- kali 2 nambah spasi
AS "Org Chart"
FROM employees
START WITH last_name = 'King'
CONNECT BY PRIOR employee_id = manager_id; 