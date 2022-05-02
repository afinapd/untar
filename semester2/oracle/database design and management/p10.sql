set serveroutput on

/*
*anonymous:
- blok tidak bernama.
- dicompile setiap dijalankan.
- tidak disimpan didalam database.
- tidak bisa dipanggil oleh aplikasi lain.
- tidak mengembalikan nilai.
- tidak bisa mengambil parameter.

*subprogram:
- bloknya bernama.
- dicompile hanya 1x, saat create.
- disimpan di database.
- bisa dipanggil oleh aplikasi lain, karena bernama.
- subprogram functions harus return nilai, procedure tidak return.
- bisa mengambil parameter.

--
anonymous
mandatory: begin, end.
optional: declare, exception.

procedure
mandatory: create [or replace] procedure proc_name, begin, end.
optional: variable, cursor & exception dll
*/

--prodecdure tanpa parameter
create or replace procedure jr is
  jari number;
  phi number;
  luas number;
  keliling number;
begin
  jari := &x;
  phi := 3.14;
  luas := phi * jari * jari;
  keliling := phi * (2 * jari);
  dbms_output.put_line('Jari -jari :' || jari || 'cm');
  dbms_output.put_line('Luas :' || luas || 'cm');
  dbms_output.put_line('Keliling :' || keliling || 'cm');
end jr;
/
--main program
--1 execute
execute jr();

--2 call
call jr();

--3 pl/sql
begin
jr();
end;
/

--paramter & argument
/*
-paramter: varible buat meneruskan data antara program pemanggil dengan subprogram
argument
-argument: nilai yang dimasukan ke parameter

contoh:
-jumlah(a,b): <- a dan b parameter
-jumlah(1,2): <- 1 dan 2 argument

parameter itu ada 2:
-formal: parameter yang didefinisikan didalam sutu fungsi
-actual: paramter yang digunakan saat pemanggilan fungsi

contoh:
-formal: create or replace name_proc(p1,p2) <- p1, p2 formal
-actual: nama_proc(d1,d2) <- d1, d2 actual
*/

desc empl;
create table empl as select * from employees;

--procedure
create or replace procedure raise_sal(
p_id emp1.employee_id%type,
p_percent in number
) is
begin
  update emp1
  set salary = salary * (1 + p_percent/100)
  where employee_id = p_id;
end raise_sal;
/
--main
declare
  e_id number := &x;
  v_percent number := &y;
begin
  raise_sal(e_id, v_percent);
end;
/

select salary from emp1
where employee_id =100;
/

drop table emp_dup;
create table emp_dup as select * from employees;

create or replace procedure sal_raise(
v_id in emp_dup.employee_id%type,
v_nm out emp_dup.first_name%type,
v_sal out emp_dup.salary%type,
v_up out number
) is
begin
  v_up := 30000;
  select first_name, salary into v_nm, v_sal
  from emp_dup
  where employee_id = v_id;
end sal_raise;
/
--main
declare
e_id    number;
emp_fn  emp_dup.first_name%type;
emp_sal emp_dup.salary%type;
up      number;
begin
  e_id := &x;
  sal_raise(e_id, emp_fn, emp_sal, up);
  dbms_output.put_line('first name: ' || emp_fn);
  dbms_output.put_line('salary: ' || emp_sal);
  dbms_output.put_line('up: ' || up);
end;
/

--passing parameter
/*
passing parameter itu ada 3:
-positional: default -- sesuai dengan urutan formal parameter
-named: tidak perlu sesuai urutan parameter, karena nantinya akan di assign valuenya memakai '=>'
-combination: kombinasi keduanya
*/
create table my_depts as select * from departments;

create or replace procedure add_dept(
p_nm in my_depts.department_name%type,
p_loc in my_depts.location_id%type
)is
begin
  insert into my_depts(department_id, department_name, location_id)
  values(departments_seq.nextval, p_nm, p_loc);
end add_dept;
/
--departments_seq.nextval -> generate no otomatis
select * from user_sequences;

select * from my_depts;

--positional
execute add_dept('education', 1400);

--named
execute add_dept(p_loc => 1900, p_nm => 'computer');

--combination
execute add_dept('abc', p_loc => 2020);

/*rules
positional harus didahulukan dibanding named
*/

--function
/*
function sama seperti procedure, tapi minimal harus return 1 nilai
function harus dipanggil di sql atau pl/sql

paramter function hanya pakai IN.
untuk OUT digantikan oleh return.

madatory: create [or replace], function func_name, begin, return1, end
optional: variable, cursor, exception, dll

function ada 2:
-system-defined: fungsi yang didefinisikan sama oracle
contoh: upper, lower, lpad, dll
-user-defined: fungsi yang didefinisikan oleh programmer
contoh: get_dpet_name, calculate_tax
*/

--function
create or replace function get_sal(
p_id in employees.employee_id%type
) return number
is
v_sal employees.salary%type := 0;
begin
  select salary into v_sal
  from employees
  where employee_id = p_id;
  return v_sal;
end get_sal;
/
--main
--1. sql
select get_sal(100) from dual;

--2. plsql
declare
  emp_id  number := &x;
  hasil   number;
begin
  hasil := get_sal(emp_id);
  dbms_output.put_line('Id: ' || emp_id ||
', salary: ' || hasil);
end;
/

create or replace function get_sal(
p_id in employees.employee_id%type
) return number
is
v_sal employees.salary%type := 0;
begin
  select salary into v_sal
  from employees
  where employee_id = p_id;
  return v_sal;
  exception
  when no_data_found then
  return null;
end get_sal;
/
--main1
--1. sql
select get_sal(100) from dual;

--2. plsql
declare
  emp_id  number := &x;
  hasil   number;
begin
  hasil := get_sal(emp_id);
  dbms_output.put_line('Id: ' || emp_id ||
', salary: ' || hasil);
end;
/
--main2
--1. sql
select job_id, get_sal(employee_id) from employees;

--2. plsql
begin
dbms_output.put_line(get_sal(&x));
end;
/
--contoh boolean
create or replace function valid_dept(
p_dept_no departments.department_id%type
) return boolean is
v_valid varchar2(1);

begin
  select 'x' into v_valid
  from departments
  where department_id = p_dept_no;
  return(true);
  exception
  when no_data_found then
  return(false);
  when others then null;
end;
/
--main
declare
  dept_id departments.department_id%type := &x;
begin
  if valid_dept(dept_id) then
  dbms_output.put_line('valid');
  else
  dbms_output.put_line('not valid');
  end if;
end;
/
/*
hampir semua funtion ada parameter, tapi ada juga yang tidak punya
*/

--contoh pemanggilan function tanpa parameter
--pl/sql
declare
  v_today date;
  user_id varchar2(50);
begin
  v_today := sysdate;
  user_id := user;
  dbms_output.put_line('today: ' ||v_today||' ,user: ' || user_id);
end;
/
--sql
select job_id, round(to_number((sysdate-hire_date)/365),0) from employees;
/

-- contoh penggunaan function dalam select
create or replace function tax(
p_value in number
)return number is
begin
return (p_value * 0.08);
end tax;
/
select employee_id, last_name, salary, tax(salary)
from employees
where department_id = 50;