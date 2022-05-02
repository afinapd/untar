set serveroutput on

--con1
--membuat trigger dengan 3 kondisi (delete, insert, update)

drop trigger secure_emp;
drop table emp1;
create table emp1 as select * from employees;

create or replace trigger secure_emp
before insert or update or delete on emp1
begin
if to_char(sysdate, 'dy') in ('tue', 'wed') then
--delete
if deleting then 
  raise_application_error(-20501, 'delete');
--insert
elsif inserting then
  raise_application_error(-20502, 'insert');
  --insert
elsif updating then
  raise_application_error(-20503, 'update');
end if;
end if;
end;
/
--delete
delete from emp1
where last_name = 'King';

--insert
insert into emp1(last_name, email, hire_date, job_id)
values('test', 'test@test.com', 'sysdate', 'IT_PROG');

--update
update emp1
set salary = 29999
where last_name = 'King';

--con2
--melakukan update pada column berbeda
select to_char(sydate, 'dy')
from dual;

create or replace trigger secure_emp
before update on emp1
begin
if updating('SALARY') then
if to_char(sysdate, 'dy') in ('tue', 'wed') then
  raise_application_error(-20503, 'update');
end if;
elsif updating('JOB_ID') then
if to_char(sysdate, 'dy') in ('tue', 'wed') then
  raise_application_error(-20503, 'update');
end if;
end if;
end;
/

--triggering salary
update emp1
set salary = 39999
where last_name = 'King';


--triggering job_id
select job_id
from emp1
where last_name = 'King';


update emp1
set job_id = 'IT_PROG'
where last_name = 'King';



rollback;

--perbandingan row-level trigger dengan statement level trigger
create table log_emp_table(
who varchar2(35),
when date);

drop table log_emp_table;

--con statement level
create or replace trigger log_emps
after update of salary on emp1
begin
insert into log_emp_table(who, when)
values(user, sysdate);
end;
/

--proces update/triggering
select first_name, salary from emp1
where department_id = 50;

update emp1
set salary = salary *1.1
where department_id = 50;

--cek log
select * from log_emp_table;

/

--con row level
create or replace trigger log_emps
after update of salary on emp1 for each row
begin
insert into log_emp_table(who, when)
values(user, sysdate);
end;
/

--proces update/triggering
select first_name, salary from emp1
where department_id = 50;

update emp1
set salary = salary *1.1
where department_id = 50;

--cek log
select * from log_emp_table;

rollback;

/*
:OLD and :NEW

:OLD = column_name sebelum update
:NEW = column_name sesudah update
*/


/*
contoh:
aturan dari perusahaan tidak memperbolehkan jika update job_id karyawan,
maka tidak boleh seperti sebelumnya.

con: emp_1 dulunya IT_PROG, lalu nanti saat update emp_1 tidak diperbolehkan
untuk menjadi IT_PROG lagi.
*/

create or replace trigger chk_sal_trigger
before update of job_id on emp1
for each row
declare
v_job_count integer;

begin

select count(*) into v_job_count
from job_history
where job_id = :OLD.job_id
and job_id = :NEW.job_id;

if v_job_count > 0 then
raise_application_error(-20201, 'This Employee has already done this job');
end if;
end;
/

--anonymous/triggering

update emp1
set job_id = 'IT_PROG'
where job_id = 'IT_PROG';

select * from emp1
where job_id = 'IT_PROG';
/
select * from emp1 where department_id = 123;

create table dept1 as select * from departments;
drop table dept1;
/


create or replace trigger emp_dept_fk_trg
before update of department_id on emp1 for each row

declare
v_dept_id dept1.department_id%type;
begin
  select department_id into v_dept_id
  from dept1
  where department_id = :NEW.department_id;
exception
when no_data_found then
insert into dept1
values(:NEW.department_id, 'Dept' || :NEW.department_id, null, null);
end;
/

desc dept1;

--triggering
update emp1
set department_id = 321
where employee_id = 124;

select * from emp1
where department_id = 50;

select * from emp1
where employee_id = 124;

select * from dept1
where department_id = 321;
/

/*
Using referencing clause

hanya bisa dipakai di row trigger
*/

/*
contoh:
aturan dari perusahaan tidak memperbolehkan jika update job_id karyawan,
maka tidak boleh seperti sebelumnya.

con: emp_1 dulunya IT_PROG, lalu nanti saat update emp_1 tidak diperbolehkan
untuk menjadi IT_PROG lagi.
*/

create or replace trigger chk_sal_trigger
before update of job_id on emp1
referencing
old as former
new as latter
for each row

declare
v_job_count integer;

begin

select count(*) into v_job_count
from job_history
where job_id = :former.job_id
and job_id = :latter.job_id;

if v_job_count > 0 then
raise_application_error(-20201, 'This Employee has already done this job');
end if;
end;
/

--anonymous/triggering

update emp1
set job_id = 'IT_PROG'
where job_id = 'IT_PROG';

select * from emp1
where job_id = 'IT_PROG';

select first_name || last_name "Nama Lengkap" from emp1;

/
--table new_emps
drop table new_emps;
CREATE TABLE new_emps AS
SELECT employee_id,last_name,salary,department_id
FROM employees;

--table new_depts
drop table new_depts;
CREATE TABLE new_depts AS
SELECT d.department_id,d.department_name,
sum(e.salary) dept_sal
FROM employees e, departments d
WHERE e.department_id= d.department_id
GROUP BY d.department_id,d.department_name;

--table view(join dari table emp dan dept)
drop view emp_details;
CREATE VIEW emp_details AS
SELECT e.employee_id, e.last_name, e.salary,
e.department_id, d.department_name
FROM new_emps e, new_depts d
WHERE e.department_id= d.department_id;

select * from new_emps;
select * from new_depts;
select * from emp_details;

--test insert
insert into emp_details
values(9001, 'test', '20000', '10', 'Administration')

--fungsi dari instead of nantikan akan membagi insert ke 2 bagian
--bagian1 ke employees
--bagian2 ke departments
/
create or replace trigger new_emp_dept
instead of insert on emp_details

begin

insert into new_emps
values(:NEW.employee_id, :NEW.last_name, :NEW.salary, :NEW.department_id);

update new_depts
set dept_sal = dept_sal + :NEW.salary
where department_id = :NEW.department_id;

end;
/
--triggering event
insert into emp_details
values(9001, 'test', 20000, 10, 'Administration');

select * from new_emps;
select * from new_depts;
select * from emp_details;


/*
compound trigger

satu trigger yang bisa menampung event dari tiap 4 timing points:
before triggering statement, before each row, after each row, after
triggering statement.
*/

create table log_tb(
emp_id number,
change_date date,
sal number
);

drop table log_tb;

--compound trigger
create or replace trigger log_emps
FOR update of salary on emp1 COMPOUND TRIGGER

--collection
type t_log_emp is table of log_tb%rowtype index by binary_integer;
log_emp_tab t_log_emp;

v_index binary_integer := 0;

--optional section
--1
after each row is

begin

v_index := v_index + 1;

log_emp_tab(v_index).emp_id := :OLD.employee_id;
log_emp_tab(v_index).change_date := sysdate;
log_emp_tab(v_index).sal := :NEW.salary;

end after each row;-- penutup section

--2
after statement is

begin

forall i in log_emp_tab.first..log_emp_tab.last
insert into log_tb values log_emp_tab(i);
end after statement;

end log_emps;
/
update emp1 set salary = 20000;

select * from log_tb;

/*
DDL Trigger & Database event Triggers



DDL Trigger: aktif saat ada ddl statement.
Database event Triggers: aktif saat non-sql event dalam database.
con:
1. user connect atau disconnect dari database.
2. DBA startup atau shutdown database.
3. exception tertentu telah diaktifkan didalam sesi user.
*/



--contoh ddl trigger

create table log_table(
user_id varchar2(35),
logon_date date
);

drop table log_table;

--trigger create
create or replace trigger log_create_trigg
after create on schema

begin

insert into log_table
values (user, sysdate);

end;
/

create table log_table2(
user_id varchar2(35),
logon_date date
);

create table log_table3(
user_id varchar2(35),
logon_date date
);

--cek log_table

select * from log_table;

--trigger drop
--mencegah drop pada objek apapun
create or replace trigger prevent_drop_trigg
before drop on schema
begin

raise_application_error(-20203, 'Attempted drop - failed.');
end;
/

create table log_table2(
user_id varchar2(35),
logon_date date
);

create table log_table3(
user_id varchar2(35),
logon_date date
);

drop table log_table2;
drop table emp1;

--contoh logon logoff
--logon
CREATE OR REPLACE TRIGGER logon_trig
AFTER LOGON ON SCHEMA
BEGIN
INSERT INTO log_trig_table(user_id,log_date,action)
VALUES(USER,SYSDATE,'Logging on');
END;
/