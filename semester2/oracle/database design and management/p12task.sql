set serveroutput on

--4
select object_name, object_type 
from user_objects 
where object_type like 'PACK%';
/
--5 spec
create or replace package check_emp_pkg 
is
  g_max_length_of_service number := 100;
  procedure chk_hiredate(
    p_hire_date   in  employees.hire_date%type);
    
  procedure chk_dept_mgr(
    p_employee_id in  employees.employee_id%type, 
    p_manager_id  in  employees.manager_id%type);
end check_emp_pkg;
/

--6 body
create or replace package body check_emp_pkg
is
  procedure chk_hiredate(
    p_hire_date   in  employees.hire_date%type) is
    begin
      if months_between(sysdate, p_hire_date)> g_max_length_of_service * 12 then
      raise_application_error(-20200, 'invalid');
    end if;
  end chk_hiredate;

  procedure chk_dept_mgr(
    p_employee_id in  employees.employee_id%type, 
    p_manager_id  in  employees.manager_id%type) is
    v_department_employee    employees.employee_id%type;
    v_department_manager     employees.employee_id%type;
    begin
      select distinct department_id into v_department_employee from employees where employee_id = p_employee_id;
      select distinct department_id into v_department_manager from employees where manager_id = p_manager_id;
  
      if v_department_employee = v_department_manager then
        dbms_output.put_line('success');
      else
        raise_application_error(-20201, 'not match');
      end if;
      exception
      when no_data_found then
      raise_application_error(-20202, 'no data found');
    end chk_dept_mgr;
end check_emp_pkg;
/

begin
  check_emp_pkg.chk_dept_mgr(141,124);
end;
/
--1 spec
create or replace package hellofrom  
is
  procedure proc_1;
--  procedure proc_2;
--  procedure proc_3;
end hellofrom;
/

-- body
create or replace package body hellofrom
is
  procedure proc_2;
  procedure proc_3;
  procedure proc_1 is
  begin
      dbms_output.put_line('Hello from Proc 1');
      proc_2;
  end proc_1;

  procedure proc_2 is
  begin
      dbms_output.put_line('Hello from Proc 2');
      proc_3;
  end proc_2;
  
  procedure proc_3 is
  begin
      dbms_output.put_line('Hello from Proc 3');
  end proc_3;
end hellofrom;
/

begin
  hellofrom.proc_1;
end;
/
select * from user_procedures where object_name = 'HELLOFROM';

select * from user_source where name ='HELLOFROM';
/

desc hellofrom;

drop package hellofrom;