set serveroutput on;

--procedure
create or replace procedure print_date is
v_date varchar2(30);

begin
  select to_char(sysdate,'Mon dd, yyyy') into v_date
  from dual;
  dbms_output.put_line(v_date);
  
end;
/

begin
  PRINT_DATE;
end;
/

select * from dual;
/

--function
create or replace function tomorrow (p_today in date)
return date is
  v_tomorrow date;
  
begin
 select p_today + 1 into v_tomorrow
 from dual;
 return v_tomorrow;
end;
/

select tomorrow(sysdate) as "tomorrow's is date"
  from dual 
/

begin
  dbms_output.put_line(tomorrow(sysdate));
end;
/

--1
declare 
  v_myname varchar2(20);

begin
  dbms_output.put_line('nama : ' || v_myname);
  v_myname := 'afina';
  dbms_output.put_line('nama : ' || v_myname);
end;
/

--2
declare 
  v_myname varchar2(20) := 'john';

begin
--  dbms_output.put_line('nama : ' || v_myname);
  v_myname := 'afina';
  dbms_output.put_line('nama : ' || v_myname);
end;
/

--3
declare 
  v_date varchar2(20);

begin
  select to_char(sysdate) into v_date from dual;
  dbms_output.put_line(v_date);
end;

--4
create or replace function num_char (p_string in varchar2)
return integer is
  v_num_char integer;
  
begin
  select length(p_string) into v_num_char
  from dual;
return v_num_char;
end;
/

declare
  v_length_of_string integer;
begin
  v_length_of_string := num_char('contohhhhh doang');
  dbms_output.put_line(v_length_of_string);
end;
/

--5
declare
v_fn EMPLOYEES.FIRST_NAME%type;
v_ls EMPLOYEES.last_name%type;

begin

select first_name, last_name into v_fn, v_ls
from employees
where last_name='King';
dbms_output.put_line(v_fn||v_ls);
end;
/

--soal
declare
  v_lastName employees.last_name%type;
  v_salary employees.salary%type;

begin
  select last_name, salary into v_lastName, v_salary
  from employees
  where employee_id  = 101;
  dbms_output.put_line('last name : ' || v_lastName || ', salary: ' || v_salary);
end;
/

--input
declare
  nama varchar2(20) := upper('&x');
begin
  dbms_output.put_line(nama);
end;
/

declare
  v_a varchar2(10) := '-123456789';
  v_b varchar2(10) := '+123456789';
  v_c pls_integer;
begin
  v_c := to_number(v_a) + to_number(v_b);
  dbms_output.put_line(v_c);
end;
/

--global & local variable
declare
  v_outer varchar2(20) := 'Global';
begin
  declare
    v_inner varchar2(20) := 'Local';
  begin
    dbms_output.put_line(v_outer);
    dbms_output.put_line(v_inner);
  end;
  dbms_output.put_line(v_outer);
end;
/

--6
declare
  v_father_name varchar2(20) := 'Patrick';
  v_date_of_birth date := '03-Apr-2000';
begin
  declare
    v_child_name varchar2(20) := 'Mike';
  begin
    dbms_output.put_line(v_father_name);
    dbms_output.put_line(v_date_of_birth);
    dbms_output.put_line(v_child_name);
  end;
  dbms_output.put_line(v_date_of_birth);
end;
/

--conditional
declare
  angka number := &x;
begin
  if angka mod(2)=0 then
  dbms_output.put_line('genap');
  else
  dbms_output.put_line('ganjil');
  end if;
end;