set serveroutput on

/*
Packages

packages: salah satu subprogram, bisa memungkinkan kita buat mengelompokkan
subprogram(procedures & functions), cursors, variables dan exception.

package ada 2 bagian:

1. package specification atau bisa disebut package spec/header.
package spec: interface ke aplikasi kita.

- harus dicreate dulu.
- deklarasi construct(procedures, function, variables dll) terlihat
oleh calling environment.

2. package body: isinya syntax2 dari construct yang dideklarasi didalam spec.

-juga dapat mengandung deklarasi variablenya sendiri.

-> spec: itu tempat deklarasi tipe, variable, constants, exceptions, cursor
 dan subprogram.
 
->body: itu tempat syntax cursor, subprogram dan tempat implementasi dari spec.

Komponen package
- detail synatx package body tidak terlihat ke calling environment, yang terlihat
hanya specnya saja.

-jika ingin melakukan perubahan syntax terhadap package, cukup body yang diedit
atau dicompile ulang, spec tidak perlu.

*/

/*
Syntax 
package spec:

create [or replace] PACKAGE package_name
is
public type and variable declarations
public subprogram spec
end [package_name];

ket:
package_name: nama dari package.
-public type dan variable declarations: deklarasi variable, constants, cursors,
exceptions, user-defined types, dan subtypes secara public.
-variable yang dideklarasi dalam package spec di inisialisasi ke NULL secara
default.
-public program specifications: deklarasi public procedures atau functions
dalam package.
-semua construct yang dideklarasi dalam package spec otomatis bertipe public.

*/

--contoh package spec
create or replace package pack1
is
no_of_goals number := 0;-- global var

procedure name_dis(name varchar2);

end pack1;
/

/*
Syntax package body

create [or replace] PACKAGE BODY package_name is
private type dan variable declarations
subprogram bodies

[BEGIN statement inisialisasi]

end [package_name];

ket:
package_name: harus sama dengan package spec.
subprogram bodies harus mengandung kode dari semua subprogram yang dideklaraso
dalam package spec.

misalnya ingin mengedit syntax package, hanya edit body aja, spec tidak perlu.

*/

--contoh package body

create or replace package body pack1
is
local_num number := 0; --local var
procedure name_dis(name varchar2)
is
begin
dbms_output.put_line('welcome ' || name || ' to oracle class!');
end name_dis;

end pack1;
/

--calling environment
begin

pack1.no_of_goals := 500;
pack1.name_dis('Davin');
dbms_output.put_line(pack1.no_of_goals);

end;
/

/*
Managing package concepts

-komponen public itu dideklarasi didalam package spec.

-kita memanggil components public dari calling environment mana pun, asal 
user lainnya sudah diberi privilege EXECUTE.

-private components dideklarasi hanya didalam body, dan hanya bisa direferensikan
oleh construct(procedure/functions) didalam package body yang sama. 

-private components bisa mereferensikan public components dari package.

*/
--spec
create table emp1 as select * from employees;
drop table emp1;
create or replace package salary_pkg
is
g_max_sal_raise constant number := 0.20;
procedure update_sal(
p_emp_id emp1.employee_id%type,
p_new_sal emp1.salary%type
);
end salary_pkg;
/

/*
-g_max_sal_raise: global constant yang diassign 0.20.
-update_sal: public procedure yang mengupdate salary employee.

constant: tidak bisa diubah nilai variablenya.
*/

--body
create or replace package body salary_pkg
is

--private function
function validate_raise(
p_old_sal emp1.salary%type,
p_new_sal emp1.salary%type
) return boolean 
is

begin

if p_new_sal > (p_old_sal * (1 + g_max_sal_raise)) then
return false;

else 
return true;

end if;

end validate_raise;

--public procedure, karena di declare di spec
procedure update_sal(
p_emp_id emp1.employee_id%type,
p_new_sal emp1.salary%type
) is

v_old_sal emp1.salary%type;--local var

begin

select salary into v_old_sal from emp1
where employee_id = p_emp_id;

if validate_raise(v_old_sal, p_new_sal) then
update emp1
set salary = p_new_sal
where employee_id = p_emp_id;

else
raise_application_error(-20210, 'raise too high');
end if;

end update_sal;

end salary_pkg;
/

--calling environment
declare
v_bool boolean;
v_number number;

begin

salary_pkg.update_sal(100, 25000);
--update_sal(100,25000);
--v_bool := salary_pkg.validate_raise(24000,25000);
v_number := salary_pkg.g_max_sal_raise;
--v_number := salary_pkg.v_old_sal;

end;
/

/*
Removing packages

-spec
drop package pack_name;

-body
drop package body pack_name;

*/

--viewing packages in the data dictionary
--spec
select text
from user_source
where name = 'SALARY_PKG' and type = 'PACKAGE'
order by line;

--body
select text
from user_source
where name = 'SALARY_PKG' and type = 'PACKAGE BODY'
order by line;

--contoh procedure error
create or replace procedure bad_proc
is
begin

error_1;
error_2;

end;
/

select line, text, position
from user_errors
where name = 'BAD_PROC' and type = 'PROCEDURE'
order by sequence;

select e.line, e.position, s.text as source, e.text as error
from user_errors e, user_source s
where e.name = s.name 
and e.type = s.type
and e.line = s.line
and e.name = 'BAD_PROC'
and e.type = 'PROCEDURE'
order by e.sequence;

/*
Advanced package concepts

-fitur overloading di PL/SQL memungkinkan kita untuk membuat 2 subprogram
atau lebih dengan nama yang sama didalam package yang sama.

-overlaoding berguna saat kita mau subprogram ke-1 menerima parameter tipe
date, dan subprogram ke-2 menerima number dengan catatan nama kedua subprogram
itu sama.

-contoh:
FUNCTION TO_CHAR (p1 date) return varchar2;
FUNCTION TO_CHAR (p2 number) return varchar2;

-overloading bisa dilakukan pada subprogram yang ada didalam package,
untuk subprogram yang standalone(berdiri sendiri) ga bisa.

*/

--contoh overloading
--spec
create or replace package emp_pkg
is
procedure find_emp(
p_employee_id in number,
p_last_name out varchar2
);

procedure find_emp(
p_job_id in varchar2,
p_last_name out varchar2
);

procedure find_emp(
p_hiredate in date,
p_last_name out varchar2
);

end emp_pkg;
/

--body
create or replace package body emp_pkg
is

--1
procedure find_emp(
p_employee_id in number,
p_last_name out varchar2
) is
v_ln employees.last_name%type;

cursor f_emp is
select last_name
from employees
where employee_id = p_employee_id;

begin

for v_emp_rec in f_emp loop

dbms_output.put_line('ID: ' || p_employee_id
|| ', Last Name: ' || v_emp_rec.last_name);

end loop;
end find_emp;

--2
procedure find_emp(
p_job_id in varchar2,
p_last_name out varchar2
) is

v_ln employees.last_name%type;

cursor f_emp is
select last_name
from employees
where job_id = p_job_id;

begin

for v_emp_rec in f_emp loop

dbms_output.put_line('ID: ' || p_job_id
|| ', Last Name: ' || v_emp_rec.last_name);

end loop;
end find_emp;

--3

procedure find_emp(
p_hiredate in date,
p_last_name out varchar2
) is

v_ln employees.last_name%type;

cursor f_emp is
select last_name
from employees
where hire_date = p_hiredate;

begin

for v_emp_rec in f_emp loop

dbms_output.put_line('ID: ' || p_hiredate
|| ', Last Name: ' || v_emp_rec.last_name);

end loop;
end find_emp;

end emp_pkg;
/

--calling environment

declare
v_ln varchar2(30);
h_date date := upper('&x');

begin

dbms_output.put_line('emp_id');
emp_pkg.find_emp(100, v_ln);
dbms_output.new_line;

dbms_output.put_line('job_id');
emp_pkg.find_emp('IT_PROG', v_ln);
dbms_output.new_line;

dbms_output.put_line('hire_date');
emp_pkg.find_emp(h_date, v_ln);

end;
/

select hire_date from employees;
--contoh overloading restriction 1
--spec
create or replace package emp_id
is
--1
procedure find_id(
p_last_name_vc in varchar2
);

--2
procedure find_id(
p_last_name_c in char
);

end emp_id;
/

--body

create or replace package body emp_id
is
--1
procedure find_id(
p_last_name_vc in varchar2
) is
v_id employees.employee_id%type;

begin

select employee_id into v_id
from employees
where last_name = p_last_name_vc;

dbms_output.put_line('Last Name: ' || p_last_name_vc
|| ', Employee Id: ' || v_id);

end find_id; --end proc 1

--2
procedure find_id(
p_last_name_c in char
) is

v_id employees.employee_id%type;

begin

select employee_id into v_id
from employees
where last_name = p_last_name_c;

dbms_output.put_line('Last Name: ' || p_last_name_c
|| ', Employee Id: ' || v_id);

end find_id; --end proc 2

end emp_id;
/

--calling environment
--error
begin
emp_id.find_id('King');
end;
/

--solution
begin
emp_id.find_id(p_last_name_vc => 'King');
emp_id.find_id(p_last_name_c => 'Whalen');
end;
/

--contoh overloading restriction 2
create table dept_dup as select * from departments;
drop table dept_dup;

--spec
create or replace package dept_pkg 
is
--1
procedure add_dept(
p_deptno number,
p_name varchar2 := 'unknown',
p_loc number := 1700
);

--2
procedure add_dept(
p_name varchar2 := 'unknown',
p_loc number := 1700
);

end dept_pkg;
/

--body
create or replace package body dept_pkg 
is
--1
procedure add_dept(
p_deptno number,
p_name varchar2 := 'unknown',
p_loc number := 1700
) is

begin

insert into dept_dup(department_id, department_name, location_id)
values (p_deptno, p_name, p_loc);

end add_dept;

--2
procedure add_dept(
p_name varchar2 := 'unknown',
p_loc number := 1700
)is

begin

insert into dept_dup(department_id, department_name, location_id)
values (departments_seq.nextval, p_name, p_loc);

end add_dept;

end dept_pkg;
/

--calling environment
-- 3 parameter
begin
dept_pkg.add_dept(980, 'Education', 2500);
end;
/

--sequence/2 parameter
begin
dept_pkg.add_dept('Games', 7000);
end;
/

select * from dept_dup;

/*
Using Forward Declarations

- semua identifiers harus dideklarasi sebelum dipakai, agar kita bisa
menyelesaikan masalah referensi ilegal dan membalik urutan procedure.

- namun, standar coding sering kali mengharuskan subprogram disimpan
dalam urutan abjad agar mudah ditemukan.

*/

--spec

create or replace package salary_pkg
is
g_max_sal_raise constant number := 0.20;
procedure update_sal(
p_emp_id emp1.employee_id%type,
p_new_sal emp1.salary%type
);
end salary_pkg;
/


--body
--sebelum forward declarations
create or replace package body salary_pkg
is

--public procedure, karena di declare di spec
procedure update_sal(
p_emp_id emp1.employee_id%type,
p_new_sal emp1.salary%type
) is

v_old_sal emp1.salary%type;--local var

begin

select salary into v_old_sal from emp1
where employee_id = p_emp_id;

if validate_raise(v_old_sal, p_new_sal) then
update emp1
set salary = p_new_sal
where employee_id = p_emp_id;

else
raise_application_error(-20210, 'raise too high');
end if;

end update_sal;

--private function
function validate_raise(
p_old_sal emp1.salary%type,
p_new_sal emp1.salary%type
) return boolean 
is

begin

if p_new_sal > (p_old_sal * (1 + g_max_sal_raise)) then
return false;

else 
return true;

end if;

end validate_raise;

end salary_pkg;
/


--body
--memakai forward declarations
create or replace package body salary_pkg
is

--deklarasi forward function 
function validate_raise(
p_old_sal emp1.salary%type,
p_new_sal emp1.salary%type
) return boolean;

--public procedure, karena di declare di spec
procedure update_sal(
p_emp_id emp1.employee_id%type,
p_new_sal emp1.salary%type
) is

v_old_sal emp1.salary%type;--local var

begin

select salary into v_old_sal from emp1
where employee_id = p_emp_id;

if validate_raise(v_old_sal, p_new_sal) then
update emp1
set salary = p_new_sal
where employee_id = p_emp_id;

else
raise_application_error(-20210, 'raise too high');
end if;

end update_sal;

--private function
function validate_raise(
p_old_sal emp1.salary%type,
p_new_sal emp1.salary%type
) return boolean 
is

begin

if p_new_sal > (p_old_sal * (1 + g_max_sal_raise)) then
return false;

else 
return true;

end if;

end validate_raise;

end salary_pkg;
/


--contoh package initialization block
--spec
create or replace package view_salary
is

v_sal number;
v_ln varchar2(50);

procedure view_sal;

end view_salary;
/

--body
create or replace package body view_salary
is

procedure view_sal is
rerata number; --local var

begin

select avg(salary) into rerata from employees;

if v_sal > rerata then
dbms_output.put_line('Gaji dari ' || v_ln ||
' sebesar ' || v_sal || ' diatas rata2.');
dbms_output.new_line;
dbms_output.put_line('rata2 gaji: ' || rerata);

else
dbms_output.put_line('Gaji dari ' || v_ln ||
' sebesar ' || v_sal || ' dibawah rata2.');
dbms_output.new_line;
dbms_output.put_line('rata2 gaji: ' || rerata);

end if;
end view_sal;

--anonymous block
begin

select salary, last_name into v_sal, v_ln
from employees
where last_name = 'King';

end view_salary;
/

--calling environment

begin
view_salary.view_sal();
end;
/

/*
Bodiless Package

-kita bisa bikin package spec tanpa body, ini yang disebut bodiless package.

-karena tidak punya body, dialam bodiless package ga boleh ada syntax yang bisa 
diexecute. con: procedure dan function.

-bodiless package sering dipakai untuk memberi nama ke variable constant,
atau ke non-predefined oracle server exception.

*/

--contoh 1 bodiless package
--package pemberian nama ke constant konversi jarak

create or replace package global_consts
is
mile_to_kilo constant number := 1.6093;
kilo_to_mile constant number := 0.6214;
yard_to_meter constant number := 0.9144;
meter_to_yard constant number := 1.0936;
end global_consts;
/

--calling environment

begin

dbms_output.put_line(2 || ' miles = '
|| 2 * global_consts.mile_to_kilo || ' km.');

dbms_output.put_line(2 || ' km = '
|| 2 * global_consts.kilo_to_mile || ' miles.');

dbms_output.put_line(2 || ' yard = '
|| 2 * global_consts.yard_to_meter || ' m.');

dbms_output.put_line(2 || ' m = '
|| 2 * global_consts.meter_to_yard || ' yard.');

end;
/

--contoh 2
--package mendeklarasikan non-predefined exceptions oracle server

insert into dept_dup (department_id, department_name)
values (200, null);

create or replace package our_except
is
e_null_insert exception;

pragma exception_init(e_null_insert, -01400);

end our_except;
/

--calling environment

begin

insert into dept_dup (department_id, department_name)
values (200, null);

exception
when our_except.e_null_insert then
dbms_output.put_line('cannot insert null!');
end;
/

/*
Restrictions on using package functions in sql statements
*/

--contoh 1
--spec
create or replace package taxes_pkg
is
function tax(p_value in number)
return number;
end taxes_pkg;
/

--body
create or replace package body taxes_pkg
is
function tax(p_value in number)
return number is
v_rate number := 0.08;

begin

return(p_value * v_rate);

end tax;
end taxes_pkg;
/

--calling environment
select taxes_pkg.tax(salary), salary, last_name
from employees;

--contoh 2 

--spec
create or replace package sal_pkg
is
function sal(p_emp_id in number)
return number;
end sal_pkg;
/

--body
create or replace package body sal_pkg
is
function sal(p_emp_id in number)
return number is

v_sal employees.salary%type;
begin

update emp1
set salary = salary * 2
where employee_id = p_emp_id;

select salary into v_sal from emp1
where employee_id = p_emp_id;

return(v_sal);

end sal;

end sal_pkg;
/

--calling environment
select sal_pkg.sal(100), salary, last_name
from emp1;

/*
Using record structure as a parameter
*/

create or replace procedure sel_one_emp(
p_emp_id in employees.employee_id%type,
p_emprec out employees%rowtype
) is

begin

select * into p_emprec from employees
where employee_id = p_emp_id;

exception 
when no_data_found then

dbms_output.put_line('No Data Found in Emp_Id ' || p_emp_id);

end sel_one_emp;
/

--calling environment

declare
v_emprec employees%rowtype;

begin
sel_one_emp(100, v_emprec);

dbms_output.put_line('Last name: ' || v_emprec.last_name);
dbms_output.put_line('Salary: ' || v_emprec.salary);

end;
/

/*
Using a User-defined type as a parameter
*/
--error
create or replace procedure sel_emp_dept(
p_emp_id in employees.employee_id%type,
p_emp_dept_rec out ed_type
) is

type ed_type is record (
f_name employees.first_name%type,
l_name employees.last_name%type,
d_name departments.department_name%type
);

begin

select e.first_name, e.last_name, d.department_name
into ed_type.f_name, ed_type.l_name, ed_type.d_name
from employees e join departments d using (department_id)
where employee_id = p_emp_id;

end sel_emp_dept;
/

--solution menggunakan package

--spec
create or replace package emp_dept_pkg
is
type ed_type is record (
f_name employees.first_name%type,
l_name employees.last_name%type,
d_name departments.department_name%type
);

procedure sel_emp_dept(
p_emp_id in employees.employee_id%type,
p_emp_dept_rec out ed_type
);

end emp_dept_pkg;
/

--body
create or replace package body emp_dept_pkg
is

procedure sel_emp_dept(
p_emp_id in employees.employee_id%type,
p_emp_dept_rec out ed_type
) is

type ed_type is record (
f_name employees.first_name%type,
l_name employees.last_name%type,
d_name departments.department_name%type
);

ed_rec ed_type;

begin

select e.first_name, e.last_name, d.department_name
into ed_rec
from employees e join departments d using (department_id)
where employee_id = p_emp_id;

dbms_output.put_line('first name: ' || ed_rec.f_name);
dbms_output.put_line('last name: ' || ed_rec.l_name);
dbms_output.put_line('department name: ' || ed_rec.d_name);

end sel_emp_dept;

end emp_dept_pkg;
/

--calling environment

declare
v_emp_dept_rec emp_dept_pkg.ed_type;

begin

emp_dept_pkg.sel_emp_dept(100, v_emp_dept_rec);

end;
/

/*
using index by table of records in package
*/

--spec
create or replace package emp_pkg
is

type emprec_type
is
table of employees%rowtype index by binary_integer;
procedure get_employees(p_emp_table out emprec_type);
end emp_pkg;
/

--body

create or replace package body emp_pkg
is

procedure get_employees(p_emp_table out emprec_type) is

begin

for emp_record in (select * from employees) loop

p_emp_table(emp_record.employee_id) := emp_record;

end loop;

end get_employees;

end emp_pkg;
/

end emp_pkg;
/

--calling environment

declare
v_emp_table emp_pkg.emprec_type;

begin

emp_pkg.get_employees(v_emp_table);

for i in v_emp_table.first..v_emp_table.last loop

if v_emp_table.exists(i) then

dbms_output.put_line('ID: ' || v_emp_table(i).employee_id);
dbms_output.put_line('first name: ' || v_emp_table(i).first_name);
dbms_output.new_line;
end if;
end loop;

end;
/

