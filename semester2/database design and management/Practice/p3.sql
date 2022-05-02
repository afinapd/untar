set serveroutput on;

--3.1
create table bonuses(
  employee_id number(6,0) not null,
  bonus number(6,2) default 0
  );
  
insert into bonuses(employee_id)
(select employee_id from employees
where salary < 10000);

select * from bonuses;

merge into bonuses b
using employees e
on (b.employee_id = e.employee_id)
when matched then
update set b.bonus = e.salary * 0.5;


--3.2
create table emp_dup as select * from employees;

select last_name from emp_dup
where last_name = 'King';
/
declare
  last_name emp_dup.last_name%type := 'King';
begin
  delete from emp_dup
  where last_name = last_name;
end;
/
--3.3
create table copy_emp as select * from employees;

--insert PL/SQL
begin
  insert into copy_emp(
  employee_id,
  first_name,
  last_name,
  email,
  hire_date,
  job_id,
  salary
  ) values (
  99,
  'afina',
  'putri',
  'afnpd03@gmail.com',
  sysdate,
  'AD_ASST',
  4000
  );
end;
/

select  employee_id, first_name, last_name, email, hire_date, job_id, salary
from copy_emp
where employee_id = 99;
/

--update PL/SQL
declare
  v_sal_increase employees.salary%type := 800;
begin
  update copy_emp
  set salary = salary + v_sal_increase
  where job_id = 'ST_CLERK';
end;
/

select job_id, salary
from copy_emp
where job_id = 'ST_CLERK';
/

--delete PL/SQL
declare
  v_deptno employees.department_id%type := 10;
begin
  delete from copy_emp
  where department_id = v_deptno;
end;
/
select first_name from copy_emp
where department_id = 10;
/

--merge
begin
  merge into copy_emp c using employees e
  on(c.employee_id=e.employee_id)
  when matched then
    update set
    c.first_name =e.first_name,
    c.last_name=e.last_name,
    c.email=e.email,
    c.phone_number=e.phone_number,
    c.hire_date=e.hire_date,
    c.job_id = e.job_id,
    c.salary = e.salary,
    c.commission_pct= e.commission_pct,
    c.manager_id= e.manager_id,
    c.department_id= e.department_id,
    c.bonus= e.bonus
  when not matched then
  insert values(
  e.employee_id,
  e.first_name, 
  e.last_name,
  e.email,
  e.phone_number,
  e.hire_date,
  e.job_id,
  e.salary,
  e.commission_pct,
  e.manager_id,
  e.department_id,
  e.bonus
  );
end;
/

desc copy_emp;
/
declare
  v_deptno copy_emp.department_id%type :=50;
begin
  delete from copy_emp
  where department_id = v_deptno;
  DBMS_OUTPUT.PUT_LINE(sql%rowcount||'rows deleted');
end;

/
declare
  v_sal_increase employees.salary%type := 800;
begin
update copy_emp
set salary = salary + v_sal_increase
where job_id='ST CLERK';
DBMS_OUTPUT.PUT_LINE(sql%rowcount||'rows update');
end;
/

rollback;

select job_id from copy_emp
where job_id= 'ST_CLERK';

create table results (num_rows number(4));
/
declare
  v_rowcount integer;
begin
update copy_emp
  set salary = salary + 100
  where job_id='ST_CLERK';
  DBMS_OUTPUT.PUT_LINE(sql%rowcount||' rows update');
  
  v_rowcount := sql%rowcount;
  
  insert into results(num_rows)
  values(v_rowcount);
  DBMS_OUTPUT.PUT_LINE(sql%rowcount||' rows update');
end;
/
select * from results;


--transaction
--commit apapun yg sudah di commit tidak bisa di rollback
create table pairtable(
num1 number,
num2 number);

begin
  insert into pairtable values(1,2);
  commit;
end;
/
select * from pairtable;

--rollback
begin
  insert into pairtable values(3,4);
  rollback;
  insert into pairtable values(5,6);
  commit;
end;
/
--savepoint
begin
  insert into pairtable values(7,8);
  savepoint my_sp_1;
  insert into pairtable values(9,10);
  savepoint my_sp_2;
  insert into pairtable values(11,12);
  rollback to my_sp_1;
  insert into pairtable values(13,14);
  commit;
end;