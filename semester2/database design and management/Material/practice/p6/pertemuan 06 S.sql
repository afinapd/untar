set serveroutput on

--5_1
--12 contoh cursor explicit
desc departments;
declare 
cursor cur_depts is
select department_id, department_name, manager_id from departments;
v_department_id departments.department_id%type;
v_department_name departments.department_name%type;
v_manager_id departments.manager_id%type;

begin

open cur_depts;

loop
fetch cur_depts into v_department_id, v_department_name;
exit when cur_depts%notfound;
dbms_output.put_line('ID: ' || v_department_id ||
', Name: ' || v_department_name);

end loop;

close cur_depts;

end;
/

--active set: kumpulan baris yang dihasilkan oleh query multiple row.
--active set disimpan didalam context area.

declare 
cursor cur_emps is
select employee_id, last_name, salary from employees
where department_id = 30;
v_empno employees.employee_id%type;
v_lname employees.last_name%type;
v_sal employees.salary%type;

begin

open cur_emps;
loop
fetch cur_emps into v_empno, v_lname, v_sal;
exit when cur_emps%notfound;
dbms_output.put_line(v_empno || ' ' || v_lname || ' ' || v_sal);
end loop;
close cur_emps;
end;
/
select employee_id, last_name, salary from employees
where department_id = 30;

--32
declare 
cursor cur_emps is
select employee_id, last_name from employees
where department_id = 10;
v_empno employees.employee_id%type;
v_lname employees.last_name%type;

begin

open cur_emps;
loop
fetch cur_emps into v_empno, v_lname;
exit when cur_emps%notfound;
dbms_output.put_line(v_empno || ' ' || v_lname);
end loop;
close cur_emps;
end;
/

--5_2 using explicit cursor attribute
declare 
cursor cur_emps is
select * from employees
where department_id = 10;
v_empno employees.employee_id%type;
v_lname employees.last_name%type;

begin

open cur_emps;
loop
fetch cur_emps into v_empno, v_lname;
exit when cur_emps%notfound;
dbms_output.put_line(v_empno || ' ' || v_lname);
end loop;
close cur_emps;
end;
/
desc employees;

--11
--record
declare
cursor cur_emps is
select * from employees
where department_id = 10;
v_emp_record cur_emp%rowtype;

begin
open cur_emps;

loop
fetch cur_emps into v_emp_record;
exit when cur_emps%notfound;
dbms_output.put_line(v_emp_record.employee_id || '-'
|| v_emp_record.last_name);
end loop;
close cur_emps;
end;
/

--tanpa record
declare 
cursor cur_emps is
select * from employees
where department_id = 10;
v_empno employees.employee_id%type;
v_lname employees.last_name%type;

begin

open cur_emps;
loop
fetch cur_emps into v_empno, v_lname;
exit when cur_emps%notfound;
dbms_output.put_line(v_empno || ' ' || v_lname);
end loop;
close cur_emps;
end;
/

--12
declare
cursor cur_emps_dept is
select first_name, last_name, department_name
from employees e, departments d
where e.department_id = d.departmnet_id;
v_emp_dept_record cur_emps_dept%rowtype;

begin

open cur_emps_dept;

loop

fetch cur_emps_dept into v_emp_dept_record;
exit when cur_emps_dept%notfound;
dbms_output.put_line(v_emp_dept_record.first_name || ' - ' ||
v_emp_dept_record.last_name || ' - ' ||
v_emp_dept_record.department_name);

end loop;

close cur_emps_dept;

end;
/
--14
declare
cursor cur_emps is
select * from employees
where department_id = 50;
v_emp_record cur_emps%rowtype;

begin

if not cur_emps%isopen then
open cur_emps;
end if;

loop

fetch cur_emps into v_emp_record;
exit when cur_emps%notfound;
dbms_output.put_line(v_emp_record.employee_id || ' - ' ||
v_emp_record.last_name);

end loop;
close cur_emps;
end;
/

--contoh %rowcount and %notfound
declare
cursor cur_emps is
select * from employees;
v_emp_record cur_emps%rowtype;
v_count number:= 0;

begin

if not cur_emps%isopen then
open cur_emps;
end if;

loop
v_count := v_count + 1;
fetch cur_emps into v_emp_record;
exit when cur_emps%rowcount > 5 or cur_emps%notfound;
dbms_output.put_line(v_emp_record.employee_id || ' - ' ||
v_emp_record.last_name);

end loop;
close cur_emps;
end;
/

create table emp_c as select * from employees;
alter table emp_c add rank number;

--18
declare 
cursor cur_emps is
select employee_id, salary from emp_c
order by salary desc;
v_emp_record emp_cursor%rowtype;

begin

open cur_emps;

loop 
fetch cur_emps into v_emp_record;
exit when cur_emps%notfound;
insert into emp_c(employee_id, rank, salary) 
values (v_emp_record.employee_id, cur_emps%rowcount, v_emp_record.salary);

end loop;

close cur_emps;

end;
/

--19
declare 
cursor cur_emps is
select employee_id, salary from emp_c
order by salary desc;
v_emp_record cur_emps%rowtype;
v_rowcount number;

begin

open cur_emps;

loop 
fetch cur_emps into v_emp_record;
exit when cur_emps%notfound;
v_rowcount := cur_emps%rowcount;
insert into emp_c(employee_id, rank, salary) 
values (v_emp_record.employee_id, v_rowcount, v_emp_record.salary);

end loop;

close cur_emps;

end;
/

--8
declare
cursor cur_emps is
select employee_id, last_name from employees
where department_id = 50;

begin

for v_emp_record in cur_emps loop
dbms_output.put_line(v_emp_record.employee_id || ' ' ||
v_emp_record.last_name);
end loop;
end;
/

--11
--for loop
declare
cursor cur_emps is
select employee_id, last_name from employees
where department_id = 50;

begin

for v_emp_rec in cur_emps loop
dbms_output.put_line(v_emp_rec.employee_id || ' '
|| v_emp_rec.last_name);
end loop;

end;
/

--open, fetch, close

declare
cursor cur_emps is
select employee_id, last_name from employees
where department_id = 50;
v_emp_rec cur_emps%rowtype;
begin

open cur_emps;
loop
fetch cur_emps into v_emp_rec;
exit when cur_emps%notfound;
dbms_output.put_line(v_emp_rec.employee_id || ' '
|| v_emp_rec.last_name);
end loop;

close cur_emps;
end;
/

--12
declare
cursor cur_depts is
select department_id, department_name
from departments
order by department_id;

begin
for v_dept_record in cur_depts loop
dbms_output.put_line(v_dept_record.department_id || ' '
|| v_dept_record.department_name);

end loop;

end;
/

--14
declare
cursor cur_emps is
select employee_id, last_name from employees;

begin

for v_emp_rec in cur_emps loop
exit when cur_emps%rowcount>5;
dbms_output.put_line(v_emp_rec.employee_id || ' '
|| v_emp_rec.last_name);
end loop;

end;
/

--16 subqueries
begin
for v_emp_record in (select employee_id, last_name from employees
where department_id = 50)
loop
dbms_output.put_line(v_emp_record.employee_id || ' '
|| v_emp_record.last_name);
end loop;
end;
/

--5_4 cursor with parameters
declare
cursor cur_country(p_region_id number) is
select country_id, country_name
from countries
where region_id = p_region_id;
v_country_record cur_country%rowtype;

begin
open cur_country(1);
loop 
fetch cur_country into
v_country_record;
exit when cur_country%notfound;
dbms_output.put_line(v_country_record.country_id || ' '
|| v_country_record.country_name);
end loop;
close cur_country;
end;
/
select * from countries;

--13
declare
v_deptid employees.department_id%type;
cursor cur_emps(p_deptid number) is
select employee_id, salary
from employees
where department_id = p_deptid;
v_emp_rec cur_emps%rowtype;

begin
select max(department_id) into v_deptid
from employees;
open cur_emps(v_deptid);
loop
fetch cur_emps into v_emp_rec;
exit when cur_emps%notfound;
dbms_output.put_line(v_emp_rec.employee_id || '-'
|| v_emp_rec.salary);

end loop;

close cur_emps;

end;
 /

select max(department_id)
from employees;

select employee_id, salary
from employees
where department_id = 110;

--14 cursor for loop with a parameter
--15
declare
cursor cur_countries(p_region_id number, p_population number) is
select country_id, country_name, population
from wf_countries
where region_id = p_region_id
and population > p_population;

begin

for v_country_record in cur_countries(145,10000000) loop
dbms_output.put_line(v_country_record.country_id || ' - '
|| v_country_record.country_name || ' - '
|| v_country_record.population);

end loop;

end;
/

select region_id, country_id, country_name, population
from wf_countries
where region_id = 145 and population > 10000000;

--16
declare
cursor cur_emps(p_job varchar2, p_salary number) is
select employee_id, last_name
from employees
where job_id = p_job
or salary > p_salary;

begin

for v_emp_record in cur_emps('IT_PROG', 10000) loop
dbms_output.put_line(v_emp_record.employee_id || '-'
|| v_emp_record.last_name);
end loop;
end;
/
select employee_id, last_name, job_id, salary
from employees
where job_id = 'IT_PROG'
or salary > 10000;

--5_5
--slide 7
create table my_employees as select * from employees;
create table my_departments as select * from departments;

drop table my_employees;
drop table my_departments;

DECLARE
CURSOR cur_emps IS
SELECT employee_id, last_name
FROM my_employees 
WHERE department_id = 80 FOR UPDATE nowait;
v_emp_rec cur_emps%ROWTYPE;
BEGIN
OPEN cur_emps;
LOOP
FETCH cur_emps INTO v_emp_rec;
EXIT WHEN cur_emps%NOTFOUND;
UPDATE my_employees
SET last_name = v_emp_rec.last_name || '_update'
WHERE department_id = 80;
END LOOP;
CLOSE cur_emps;
END;
/

DECLARE
CURSOR cur_emps IS
SELECT employee_id, last_name
FROM my_employees 
WHERE department_id = 80 FOR UPDATE wait 5;
v_emp_rec cur_emps%ROWTYPE;
BEGIN
OPEN cur_emps;
LOOP
FETCH cur_emps INTO v_emp_rec;
EXIT WHEN cur_emps%NOTFOUND;
UPDATE my_employees
SET last_name = v_emp_rec.last_name || '_update'
WHERE department_id = 80;
END LOOP;
CLOSE cur_emps;
END;
/
select department_id, employee_id, last_name
from my_employees
where department_id = 80;

--9
DECLARE
CURSOR emp_cursor IS
SELECT e.employee_id, d.department_name
FROM my_employees e,my_departments d
WHERE e.department_id = d.department_id
and d.department_id = 80 FOR UPDATE of salary;
v_emp_dept_rec emp_cursor%ROWTYPE;
BEGIN
OPEN emp_cursor;
LOOP
FETCH emp_cursor INTO v_emp_dept_rec;
EXIT WHEN emp_cursor%NOTFOUND;
UPDATE my_departments
SET department_name = v_emp_dept_rec.department_name || '_update'
WHERE department_id = 80;
END LOOP;
CLOSE emp_cursor;
END;
/
select d.department_id, e.employee_id, department_name
from my_employees e, my_departments d
where e.department_id = d.department_id
and d.department_id = 80;

--13
DECLARE
CURSOR cur_emps IS
SELECT employee_id, salary FROM my_employees
WHERE salary <=20000 FOR UPDATE NOWAIT;
v_emp_rec cur_emps%ROWTYPE;
BEGIN
OPEN cur_emps;
LOOP
FETCH cur_emps INTO v_emp_rec;
EXIT WHEN cur_emps%NOTFOUND;

UPDATE
my_employees
SET salary = v_emp_rec.salary*1.1
WHERE CURRENT OF cur_emps;

END LOOP;
CLOSE cur_emps;
END;
/
SELECT employee_id, salary FROM my_employees
WHERE salary <=20000;


--14
DECLARE
CURSOR cur_emps_dept IS
SELECT employee_id, salary ,department_name 
FROM my_employees e, my_departments d
WHERE e.department_id = d.department_id
FOR UPDATE of salary NOWAIT;
v_emp_dept_rec cur_emps_dept%ROWTYPE;
BEGIN
OPEN cur_emps_dept;
LOOP
FETCH cur_emps_dept INTO v_emp_dept_rec;
EXIT WHEN cur_emps_dept%NOTFOUND;
UPDATE my_employees
SET salary = v_emp_dept_rec.salary * 1.1
WHERE CURRENT OF cur_emps_dept;
END LOOP;
CLOSE cur_emps_dept;
END;
/
rollback;
SELECT d.department_id, employee_id, salary ,department_name 
FROM my_employees e, my_departments d
WHERE e.department_id = d.department_id
and d.department_id = 80;


DECLARE
CURSOR cur_eds IS
SELECT employee_id, salary, department_name
FROM my_employeese, my_departments d
WHERE e.department_id = d.department_id
FOR UPDATE OF salary NOWAIT;
BEGIN
FOR v_eds_rec IN cur_eds LOOP
UPDATE my_employees
SET salary = v_eds_rec.salary* 1.1
WHERE CURRENT OF cur_eds;
END LOOP;
END;
/
--5_6 using multiple cursor

declare
cursor cur_dept is
select department_id, department_name
from departments
order by department_name;

cursor cur_emp(p_deptid number) is
select first_name, last_name
from employees 
where department_id = p_deptid
order by last_name;
v_deptrec cur_dept%ROWTYPE;
v_emprec cur_emp%ROWTYPE;

begin
open cur_dept;
loop
fetch cur_dept into v_deptrec;
exit when cur_dept%NOTFOUND;
dbms_output.put_line(v_deptrec.department_name);

open cur_emp(v_deptrec.department_id);
loop
fetch cur_emp into v_emprec;
exit when cur_emp%NOTFOUND;
dbms_output.put_line(v_emprec.last_name || ' ' ||
v_emprec.first_name);
dbms_output.put_line('');

end loop;

close cur_emp;

end loop;

close cur_dept;

end;
/

--slide 11

DECLARE
CURSOR cur_loc IS 
SELECT * FROM locations;
CURSOR cur_dept (p_locid NUMBER) IS
SELECT * FROM departments 
WHERE location_id = p_locid;
v_locrec cur_loc%ROWTYPE;
v_deptrec cur_dept%ROWTYPE;

BEGIN
OPEN cur_loc;
LOOP
FETCH cur_loc INTO v_locrec;
EXIT WHEN cur_loc%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(v_locrec.city);

OPEN cur_dept (v_locrec.location_id);
LOOP
FETCH cur_dept INTO v_deptrec;
EXIT WHEN cur_dept%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(v_deptrec.department_name);
dbms_output.put_line('');
END LOOP;
CLOSE cur_dept;

END LOOP;
CLOSE cur_loc;
END;
/

select * from locations;
--slide 12

DECLARE
CURSOR cur_loc IS 
SELECT * FROM locations;
CURSOR cur_dept (p_locid NUMBER) IS
SELECT * FROM departments 
WHERE location_id = p_locid;

BEGIN
FOR v_locrec IN cur_loc
LOOP
DBMS_OUTPUT.PUT_LINE(v_locrec.city);

FOR v_deptrec IN cur_dept (v_locrec.location_id)
LOOP
DBMS_OUTPUT.PUT_LINE(v_deptrec.department_name);
dbms_output.put_line('');
END LOOP;
END LOOP;
END;
/

--slide 13

DECLARE
CURSOR cur_dept IS SELECT * FROM my_departments;
CURSOR cur_emp (p_dept_id NUMBER) IS
SELECT * FROM my_employees WHERE department_id = p_dept_id
FOR UPDATE NOWAIT;
BEGIN
FOR v_deptrec IN cur_dept LOOP
DBMS_OUTPUT.PUT_LINE(v_deptrec.department_name);

FOR v_emprec IN cur_emp (v_deptrec.department_id) LOOP
DBMS_OUTPUT.PUT_LINE(v_emprec.last_name || '-' || v_emprec.salary);
dbms_output.put_line('');
IF v_deptrec.location_id = 1700 AND v_emprec.salary < 10000
THEN UPDATE
my_employees SET salary = salary * 1.1
WHERE CURRENT OF cur_emp;
END IF;
END LOOP;
END LOOP;
END;
/
rollback;
select department_name, last_name, salary, location_id
from my_employees e, my_departments d
where e.department_id = d.department_id
and location_id = 1700 and salary < 10000;


