set serveroutput on 

/*
Using conditional predicates

fungsinya untuk membuat trigger dengan kondisi yang berbeda-beda
*/

--con 1
--membuat trigger dengan 3 kondisi (delete, insert, update)

drop trigger secure_emp;

select * from emp1;

create table emp1 as select * from employees;

drop trigger secure_emp;

--trigger using conditional predicates
create or replace trigger secure_emp
before insert or update or delete on emp1

begin

if to_char(sysdate, 'dy') in ('tue', 'wed') then

--delete <- kondisi 1.
if deleting then 
raise_application_error
(-20501, 'You may delete from emp1 table only during business hours');

--insert <- kondisi 2.
elsif inserting then
raise_application_error
(-20502, 'You may insert from emp1 table only during business hours');

--update <- kondisi 3.
elsif updating then
raise_application_error
(-20503, 'You may update from emp1 table only during business hours');

end if; -- kondisi 1-3

end if; -- to_char

end;
/

--test
--triggering delete 

delete from emp1
where last_name = 'King';


--triggering insert
desc emp1;

insert into emp1(last_name, email, hire_date, job_id)
values('Test', 'test@gmail.com', sysdate, 'IT_PROG');


--triggering update
update emp1
set salary = 39999
where last_name = 'King';


--con 2
--melakukan update pada column yang berbeda

select to_char(sysdate+2, 'dy')
from dual;

create or replace trigger secure_emp
before update on emp1

begin

--update salary <-kolom 1
if updating('SALARY') then
if to_char(sysdate, 'dy') in ('tue', 'wed') then
raise_application_error
(-20501, 'You may not update salary on tue and wed');

end if;-- to_char

elsif updating('JOB_ID') then
if to_char(sysdate, 'dy') = 'wed' then
raise_application_error
(-20502, 'You may not update job_id on wed');

end if;-- to_char

end if;--updating

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
when date
);

drop table log_emp_table;

select * from log_emp_table;

drop table emp1;

create table emp1 as select * from employees;

--contoh trigger statement level
create or replace trigger log_emps
after update of salary on emp1

begin

insert into log_emp_table (who, when)
values(user, sysdate);
end;
/

--proses update/triggering 
select count(*) from emp1
where department_id = 50;

select * from emp1
where department_id = 50;

 update emp1
 set salary = salary * 1.1
 where department_id = 50; 

--cek table log
select * from log_emp_table;


--contoh row-level
create or replace trigger log_emps
after update of salary on emp1 FOR EACH ROW

begin

insert into log_emp_table (who, when)
values(user, sysdate);
end;
/

--proses update/triggering 
select count(*) from emp1
where department_id = 50;

select * from emp1
where department_id = 50;

 update emp1
 set salary = salary * 1.1
 where department_id = 50;

--cek table log
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


/*
Implementing an integrity constraint with a trigger

*/

select * from emp1
where department_id = 123;

select * from departments
where department_id = 123;

update emp1
set department_id = 123
where employee_id = 124;

create table dept1 as select * from departments;

drop table dept1;

drop table emp1;

create table emp1 as select * from employees;

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

/*
Instead of trigger

*/

--table new_emps
drop table new_emps;
CREATE TABLE new_emps AS
SELECT employee_id,last_name,salary,department_id
FROM employees;

drop table new_emps;

--table new_depts
drop table new_depts;
CREATE TABLE new_depts AS
SELECT d.department_id,d.department_name,
sum(e.salary) dept_sal
FROM employees e, departments d
WHERE e.department_id= d.department_id
GROUP BY d.department_id,d.department_name;

drop table new_depts;

--table view(join dari table emp dan dept)
drop view emp_details;
CREATE VIEW emp_details AS
SELECT e.employee_id, e.last_name, e.salary,
e.department_id, d.department_name
FROM new_emps e, new_depts d
WHERE e.department_id= d.department_id;

drop view emp_details;


select * from new_emps;
select * from new_depts;
select * from emp_details;

--test insert

insert into emp_details 
values(9001, 'test', 20000, 10, 'Administration');

--fungsi dari instead of trigger nantinya akan, membagi insert ke 2 bagian
--bagian 1 untuk insert ke employees
--bagian 2 untuk insert ke departments

desc new_emps;
select * from new_depts;

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

--triggering
update emp1
set salary = 20000;

select * from log_tb;
--===============================================================
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

drop trigger prevent_drop_trigg;

--contoh logon dan logoff

create table log_trig_table(
user_id varchar2(50),
log_date date,
action varchar2(50)
);

drop table log_trig_table;

--log on
create or replace trigger logon_trig
after logon on schema

begin
insert into log_trig_table(user_id, log_date, action)
values (user, sysdate, 'logging on');

end;
/

drop trigger logoff_trig;

select * from log_trig_table;

--log off trigger

create or replace trigger logoff_trig
before logoff on schema

begin

insert into log_trig_table(user_id, log_date, action)
values (user, sysdate, 'logging off');

end;
/

/*
Mutating table

mutating table: table yang sedang diedit oleh statement DML.

row trigger tidak bisa melakukan select dari mutating table, karena
akan menghasilkan data set yang tidak konsisten.

batasan ini hanya berlaku untuk DML row trigger, untuk DML statement trigger
tidak berlaku.

*/

create or replace trigger check_salary
before insert or update of salary, job_id on emp1
for each row

declare

v_minsal emp1.salary%type;
v_maxsal emp1.salary%type;

begin

select min(salary), max(salary)
into v_minsal, v_maxsal
from emp1
where job_id = :NEW.job_id;

if :NEW.salary < v_minsal
or :NEW.salary > v_maxsal then

raise_application_error(-20505, 'out of range');

end if;
end;
/

drop trigger check_salary;

--
update emp1
set salary = 3400
where last_name = 'Davies';

--contoh penggunaan trigger
--kasus: tidak diperbolehkan untuk menurunkan salary saat update

alter table emp1 add
constraint ck_salary check (salary >= 500);

update emp1
set salary = 499
where last_name = 'King';

select last_name, salary
from emp1
where last_name = 'King';

--trigger
create or replace trigger check_salary
before update of salary on emp1

for each row

when(NEW.salary < OLD.salary or NEW.salary < 500)

begin

raise_application_error(-20508, 'Do not decrease salary.');

end;
/

drop table emp1;

create table emp1 as select * from employees;

select last_name, salary from emp1 
where last_name = 'King';

--triggering

update emp1
set salary = 23999
where last_name = 'King';

--jika terjadi perubahan pada minimum salary tiap tahunnya

create table minsal (min_sal number(8,2));

drop table minsal;

insert into minsal (min_sal) values (500);

update minsal
set min_sal = 10000;

--trigger

create or replace trigger check_salary
before update of salary on emp1
for each row

declare

v_min_sal minsal.min_sal%type;

begin

select min_sal into v_min_sal
from minsal;

if :NEW.salary < v_min_sal
or :NEW.salary < :OLD.salary then

raise_application_error(-20508, 'do not decrease salary.');

end if;

end;
/

--triggering

select last_name, salary from emp1;

update emp1
set salary = 8000
where last_name = 'Whalen';

/*
Viewings trigger in the data dictionary

-user_objects: nama objek dan tipe objek(didalam schema).
-user_triggers: detail kode dan status dari trigger.
-user_errors: syntax error pl/sql.
-user_triggers: untuk melihat source code, tidak pakai user_source.
*/

--menampilkan event, timing, type, status, dan detail dari sebuah trigger
--check salary

select trigger_name, trigger_type, triggering_event, table_name,
status, trigger_body
from user_triggers
where trigger_name = 'CHECK_SALARY';

--mengubah status trigger
--alter trigger

--trigger drop
--mencegah drop pada objek apapun

create or replace trigger prevent_drop_trigg
before drop on schema

begin

raise_application_error(-20203, 'Attempted drop - failed.');

end;
/

select status 
from user_triggers
where trigger_name = 'PREVENT_DROP_TRIGG';

drop table emp1;

create table emp1 as select * from employees;

--mematikan trigger

alter trigger prevent_drop_trigg disable;

--menyalakan trigger

alter trigger prevent_drop_trigg enable;






