set serveroutput on

select * from employees where department_id = 80;

/
--no 1
create or replace procedure proc_employee(
  p_job_id        employees.job_id%type,
  p_department_id employees.department_id%type
) is
  v_employee_id   employees.employee_id%type;
  v_first_name    employees.first_name%type;
  v_last_name     employees.last_name%type;
begin
  select employee_id, first_name, last_name 
  into v_employee_id, v_first_name, v_last_name
  from employees
  where job_id = p_job_id and department_id = p_department_id;
    dbms_output.put_line(v_employee_id || ' - ' || v_first_name || ' ' || v_last_name);
  exception when too_many_rows then
    dbms_output.put_line('output lebih dari satu baris data');
end proc_employee;
/

begin
--  true
  proc_employee('AD_PRES', 90);
  
--  exception
  proc_employee('AD_VP', 90);
end;
/

--no 2
create or replace procedure proc_salary(
  p_department_id     employees.department_id%type
) is
  v_count_employees   employees.salary%type;
  v_max_salary        employees.salary%type;
  v_min_salary        employees.salary%type;
  v_avg_salary        employees.salary%type;
begin
  select count(*), max(salary), min(salary), avg(salary) into v_count_employees, v_max_salary, v_min_salary, v_avg_salary
  from employees
  where department_id = p_department_id; 
    dbms_output.put_line('Jumlah karyawan : ' || v_count_employees); 
    dbms_output.put_line('Gaji rata-rata : ' || v_avg_salary); 
    dbms_output.put_line('Gaji terendah  : ' || v_min_salary);
    dbms_output.put_line('Gaji tertinggi : ' || v_max_salary);
end proc_salary;
/
begin
  proc_salary(80);
end;
/

--no 3
declare
  v_location_id number := '&x';
  cursor cur_depts_locs is 
  select department_id, department_name, location_id 
  from departments 
  where location_id = v_location_id;
  v_cur_depts_locs  cur_depts_locs%rowtype;
begin
  dbms_output.put_line('===== Departments on Location ' || v_location_id || ' =====');
  open cur_depts_locs;
    loop
    fetch cur_depts_locs into v_cur_depts_locs;
    exit when cur_depts_locs%notfound;
    dbms_output.put_line(v_cur_depts_locs.department_id || ' ' || v_cur_depts_locs.department_name);
    end loop;
  close cur_depts_locs;
end;
/
declare
  type department_rec is record(
  v_department_id      departments.department_id%type,
  v_department_name    departments.department_name%type,
  v_location_id        departments.location_id%type);
  type department_tab is table of department_rec;
  v_department_rec department_tab;
  v_location_id number := '&x';
begin
  select department_id, department_name, location_id bulk collect into v_department_rec
  from departments 
  where location_id = v_location_id;
  dbms_output.put_line('===== Departments on Location ' || v_location_id || ' =====');
  for i in v_department_rec.first .. v_department_rec.last loop
   dbms_output.put_line(v_department_rec(i).v_department_id || ' ' || v_department_rec(i).v_department_name);
  end loop;
END;
/

--no4
--spec
create or replace package bonus_pkg as
 function bonus(p_employee_id employees.employee_id%type) return employees.salary%type;
 function hire(p_employee_id employees.employee_id%type) return number;
end  bonus_pkg;
/
--body
create or replace package body bonus_pkg as
  function bonus(p_employee_id employees.employee_id%type)
  return employees.salary%type as v_bonus employees.salary%type;
  begin
    select salary * 1.5 into v_bonus 
    from employees 
    where employee_id = p_employee_id;
    return v_bonus;
    dbms_output.put_line(v_bonus);
  end bonus;

  function hire(p_employee_id employees.employee_id%type) 
  return number as v_hire number;
  begin
    select extract (year from sysdate) - extract (year from hire_date) into v_hire 
    from employees 
    where employee_id = p_employee_id;
    return v_hire;
    dbms_output.put_line(v_hire);
  end hire;
end bonus_pkg;
/
--calling env
declare 
  v_bonus       employees.salary%type;
  v_hire        number;
  v_employee_id employees.employee_id%type := &x;
  v_first_name  employees.first_name%type;
  v_last_name   employees.last_name%type;
begin
   select first_name, last_name into v_first_name, v_last_name 
   from employees where employee_id = v_employee_id;
   v_bonus := bonus_pkg.bonus(v_employee_id);
   v_hire := bonus_pkg.hire(v_employee_id);
   dbms_output.put_line('Data of employee ' || v_last_name || ' :'); 
   dbms_output.put_line('Bonus : ' || v_bonus); 
   dbms_output.put_line('Work Periode : ' || v_hire);
END; 
/
drop package bonus_pkg;