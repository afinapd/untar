set serveroutput on
/*
packages : salah satu subprogram, bisa meumngkinkan kita untuk 
mengelompokan subprogram yang lain (procedure & function), cursors,
variable, dan exception

package ada 2 bagian:
1. package specification / package spec / header: interface ke aplikasi kita
- harus di create dulu
- dekarasi cunstruct(procedure, function, variable, dll) terlihat 
oleh calling enviroment

2. package body: isinya syntax2 dari contruct yg di deklarasi di
dalam spec
- dapat mengandungdeklarasi variablenya sendiri

-> spec: itu tempat deklarasi tipe, variable, contants, exception,cursor, dan subprogram
-> body: itutempay syntax cursor, suprogram dantempat implementasi dari spec

komponen package
- detailsyntax package body tidak terlihat ke calling env, yang terlihat
hanya specnya saja
- jika ingin melakukan perubahan syntax terhadap package,cukup body yg diedit
atau dicompileulang, spec tidak perlu

*/

/*
syntax
package spec

create [or replace] package package_name
is
public type and variable declarations
public subprogram spec
end [package_name];

ket
- package_name: nama dari package
- public type dan variable declarations: deklarasi variable, constants,
cursors, exceptions, user-defined type, dan subtypes secara public
- variable yang di deklarasi dalam package spec di inisialisasi ke null
secara default
- public program specification: deklarasi public procedures atau functions
dalam package
- semua constrct yang dideklarasi dalam package spec otomatis bertype public
*/


--contoh package spec
create or replace package pack1
is 
no_of_goals number:=0; --global var
procedure name_dis(name varchar2);
end pack1;
/

/*
syntax
package body

create [or replace] package body package_name
is
public type and variable declarations
public subprogram bodies
[BEGIN inisialisasi]
end [package_name];

ket
- package_name: harus sama dengan package spec
- subprogram bodies harus mengandung kode dari semua subprogram yang
dideklarasi dalam package spec
- misalnya ingin mengedit syntax pacakeg, hanya edit body aja, spec
tidak perlu
*/

--contoh package body
create or replace package body pack1
is 
local_num number:=0; --local var
procedure name_dis(name varchar2)
is 
begin
DBMS_OUTPUT.PUT_LINE('welcome ' || name);
end name_dis;
end pack1;
/

--calling env
begin
pack1.no_of_goals := 500;
pack1.name_dis('afina');
DBMS_OUTPUT.PUT_LINE(pack1.no_of_goals);
end;

/*
managing package concepts

- komponen public itu dideklarasi didalam package spec
- kita memanggil componens public dari calling env manapun,
asal usernya lainnya sudah di beri privilage execute
- private components dideklarasi hanya didalam body, dan hanya bisa
direferensikan oleh construct(procedure/function) didalam package body
yang sama
- private component bisa mereferensikan public components dari package
*/
create table emp1 as select * from employees;
drop table emp1;
/
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
- g_max_sal_raise : global constan yang di assign0.20
- update_sal : public procedure yang menguodate salary employee
- constant: tidka bisa diubah nilai variablenya
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
update_sal(100,25000);
v_bool := salary_pkg.validate_raise(24000,25000);
v_number := salary_pkg.g_max_sal_raise;
v_number := salary_pkg.v_old_sal;
end;
/

/* removing package
drop package pack_name;

drop package body pack_name;
*/
--view package
select text from user_source
where name ='SALARY_PKG' and type = 'PACKAGE'
order by line;

--view package body
select text from user_source
where name ='SALARY_PKG' and type = 'PACKAGE BODY'
order by line;

--contoh procedure error
create or replace procedure bad_procs
is
begin
error_1;
error_2;
end;
/
select line, text, position from user_errors
where name ='BAD_PROCS' and type = 'PROCEDURE'
order by sequence;

select e.line, e.position, s.text as source, e.text as error
from user_errors e, user_source s
where e.name = s.name
and e.type = s.type
and e.line = s.line
and e.name = 'BAD_PROCS'
and e.type = 'PROCEDURE'
order by e.sequence;

/
/*
advice package concepts
- fitur overloading di PL/SQL memungkinkan kita untuk membuat 2 subprogram
atau lebih dengan nama yang sama disalam package yang sama
- overloading berguna saat kita mau ke subprogram ke -1 menerima paramter
type date, dan suprogram ke 2 menerima char dengan catatan nama
kedua subprogram itu sama

- contoh:
function to_char (p1 date) return varchar2;
function to_char (p2 numbere) return varchar2;

- over loadaing bisa dilakukan pada subprogram yang ada didalam package 
untuk subprogram yang standalone(berdiri sendiri) ga bisa

*/
--contoh overloading
create or replace package emp_pkg
is
procedure find_emp(
p_employee_id in number,
p_last_name out varchar2
);

procedure find_emp(
p_job_id in number,
p_last_name out varchar2
);

procedure find_emp(
p_hiredate in number,
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
dbms_output.put_line('hire_date'); --07-jun-94
emp_pkg.find_emp(h_date, v_ln);
end;
/

--contoh overloading restriction
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

create table dept_dup as select * from departments;

--contoh overloading restriction 2
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

begin
dept_pkg.add_dept(980, 'Education', 2500);
--dept_pkg.add_dept(980, 'Education', 2500);
end;
/

begin
dept_pkg.add_dept('Games', 7000);
--dept_pkg.add_dept(980, 'Education', 2500);
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