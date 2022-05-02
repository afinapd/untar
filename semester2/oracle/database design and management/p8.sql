set serveroutput on

--1 predefined: error paling umum
--2 non-predefined: error yang ga ada nama
--3 user defined: error yang dibuat oleh programmer

--predefined exception

--before exception (no_data_found)
declare
  v_ln varchar2(30);
  emp_id number:= &id;
begin
  select last_name into v_ln
  from employees
  where employee_id = emp_id;
  dbms_output.put_line('last name: ' || v_ln);
end;
/

select last_name from employees
where employee_id = 111;

--after exception (no_data_found)
declare
  v_ln varchar2(30);
  emp_id number:= &id;
begin
  select last_name into v_ln
  from employees
  where employee_id = emp_id;
  dbms_output.put_line('last name: ' || v_ln);
  exception
  when no_data_found then
  dbms_output.put_line('data tidak ada didalam tabel !');
end;
/

--before exception (too_many_rows)
declare
  v_ln varchar2(30);
  dept_id number:= &id;
begin
  select last_name into v_ln
  from employees
  where department_id = dept_id;
  dbms_output.put_line('last name: ' || v_ln);
end;
/

select last_name from employees
where department_id = 110;

--after exception (too_many_rows)
declare
  v_ln varchar2(30);
  dept_id number:= &id;
begin
  select last_name into v_ln
  from employees
  where department_id = dept_id;
  dbms_output.put_line('last name: ' || v_ln);
  exception
  when too_many_rows then
  dbms_output.put_line('Terlalu banyak data!');
end;
/
create table depts as select * from departments;

insert into depts(department_id, department_name)
values(333, null);
/
begin
  insert into depts(department_id, department_name)
  values(333, null);
  exception
  when too_many_rows then
  dbms_output.put_line('Terlalu banyak data!');
  when no_data_found then
  dbms_output.put_line('Terlalu banyak data!');
  when others then
  dbms_output.put_line('error lainnya');
end;
/
declare
  insert_except exception;
  pragma exception_init(insert_except, -01400);
begin
  insert into depts(department_id, department_name)
  values(333, null);
exception
when insert_except then
dbms_output.put_line('tidak bisa insert NULL kedalam table');
end;
/

--trapping exception
create table depts as select * from departments;
drop table depts;

insert into depts(department_id, department_name)
values(333, null);

begin
  insert into depts(department_id, department_name)
  values(333, null);
  exception
  when too_many_rows then
  dbms_output.put_line('Terlalu banyak data!');
  when no_data_found then
  dbms_output.put_line('data tidak ada didalam tabel !');
  when others then
  dbms_output.put_line('Error lainnya');
end;
/

--non-predefined exception
create table depts as select * from departments;
drop table depts;

insert into depts(department_id, department_name)
values(333, null);

declare
  insert_except exception; --variable untuk exception
  pragma exception_init(insert_except, -01400);
begin
  insert into depts(department_id, department_name)
  values(333, null);
  exception
  when insert_except then
  dbms_output.put_line('tidak bisa insert NULL ke dalam table!');
end;
/

declare
  v_ln varchar2(30);
  dept_id number:= &id;
  insert_except exception; --variable untuk exception
  pragma exception_init(insert_except, -01422);
begin
  select last_name into v_ln
  from employees
  where department_id = dept_id;
  exception
  when insert_except then
  dbms_output.put_line('Terlalu banyak data!');
end;
/

create table error_log (
e_user varchar2(50),
e_date date,
e_code number,
e_msg varchar2(100)
);

drop table error_log;

select * from error_log;

select last_name
from employees
where department_id = 110;

/
declare
  l_nm varchar2(30);
  j_id varchar2(40) := 'IT_PROG';
  x_except exception;
  pragma exception_init(x_except, -01422);
  v_error_code number;
  v_error_message varchar2(250);
begin
  select last_name into l_nm
  from employees
  where job_id = j_id;
  dbms_output.put_line('last_name' || l_nm);
  exception
  when x_except then
  dbms_output.put_line('Terlalu banyak data!');
  v_error_code := sqlcode;
  v_error_message := sqlerrm;
  insert into error_log(e_user, e_date, e_code, e_msg)
  values (user, sysdate, v_error_code, v_error_message);
end;
/

select last_name
from employees
where job_id = 'IT_PROG';

select * from error_log;
/

declare
v_deptname varchar2(20) := 'Accounting';
v_deptno number := 27;

begin
  update depts
  set department_name = v_deptname
  where department_id = v_deptno;
end;
/

select * from depts
where department_id = 27;
/

declare
  v_deptname varchar2(20) := 'Accounting';
  v_deptno number := 27;
  invalid_exc exception;-- 1 declare exception
begin
  update depts
  set department_name = v_deptname
  where department_id = v_deptno;
  if sql%notfound then
  raise invalid_exc; -- 2 raise
  end if;
  exception
  when invalid_exc then -- 3 reference
  dbms_output.put_line('dept id ' || v_deptno || ' tidak ada di table');
end;
/

declare
  v_dept number := 123;
begin
  delete from depts
  where department_id = v_dept;
  if sql%notfound then
  raise_application_error(-20212, 'Ini bukan department yang valid');
  end if;
end;
/

--exception section
declare
  v_mgr pls_integer := 27;
  v_emp_id employees.employee_id%type;
begin
  select employee_id into v_emp_id
  from employees
  where manager_id = v_mgr;
  dbms_output.put_line('Emp #' || v_emp_id ||
  ' work for manager #' || v_mgr || '.');
  exception
  when no_data_found then
  raise_application_error(-20201, 'this manager has no employees.');
  when too_many_rows then
  raise_application_error(-20202, 'Too many employees were found.');
end;
/

create table emp1 as select * from employees;

declare
  e_name exception;
  pragma exception_init(e_name, -20999);
  v_ln emp1.last_name%type := 'Silly Name';
begin
  delete from emp1
  where last_name = v_ln;
  if sql%rowcount = 0 then
  raise_application_error(-20999, 'Invalid last name');
  else
  dbms_output.put_line(v_ln || ' deleted');
  end if;
  exception
  when e_name then
  dbms_output.put_line('valid last names are: ');
  for c1 in (select distinct last_name from emp1) loop
  dbms_output.put_line(c1.last_name);
  end loop;
  when others then
  dbms_output.put_line('Error deleting emp1');
end;
/

declare --outer
  v_ln employees.last_name%type;
begin --outer
  begin --inner
    select last_name into v_ln
    from employees
    where employee_id = 999;
    dbms_output.put_line('message 1: exist');
    exception --inner
    when too_many_rows then
    dbms_output.put_line('message 2: too_many_rows');
  end; --inner
  dbms_output.put_line('message 3: exist/more than 1 row');
  exception --outer
  when others then
  dbms_output.put_line('message 4: others');
end;--outer
/

declare
  e_myexcep exception;
begin --outer
  declare--inner
    e_myexcep exception;
  begin
    raise e_myexcep;
    dbms_output.put_line('message 1');
    exception--inner
    when too_many_rows then
    dbms_output.put_line('message 2');
  end;--inner
  dbms_output.put_line('message 3');
  exception--outer
  when no_data_found then
  dbms_output.put_line('message 4');
  when others then
  dbms_output.put_line('other');
end;
/