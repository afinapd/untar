set serveroutput on

--1
declare
  v_last_name  emp.last_name%type;
  v_salary     emp.salary%type;
  v_new_salary int;
begin
  select last_name, salary into v_last_name, v_salary
  from employees
  where employee_id = &x;
  if v_salary < 10000 then
    v_new_salary := v_salary + (v_salary*0.10);
    dbms_output.put_line('Last Name : ' || v_last_name);
    dbms_output.put_line('Salary telah dinaikan 10% dari ' || v_salary || ' menjadi ' || v_new_salary);
  elsif v_salary < 15000 then
    v_new_salary := v_salary + (v_salary*0.05);
    dbms_output.put_line('Last Name : ' || v_last_name);
    dbms_output.put_line('Salary telah dinaikan 10% dari ' || v_salary || ' menjadi ' || v_new_salary);
  else
    dbms_output.put_line('Last Name : ' || v_last_name);
    dbms_output.put_line('Salary tidak dinaikan 10% dikarenakan salary sebesar ' || v_new_salary);
  end if;
end;
/

--2
declare
  cursor cur_depts is 
  select d.department_name, count(*)
  from employees e join departments d
  on e.department_id=d.department_id
  group by d.department_name;
  v_department_name departments.department_name%type;
  v_count number;
begin
  open cur_depts;
    dbms_output.put_line('department dengan jumlah karyawan > 10');
    loop
    fetch cur_depts into v_department_name, v_count;
    exit when cur_depts%NOTFOUND;
      if v_count>10 then
      dbms_output.put_line('department : '||v_department_name||', jumlah karyawan : '||v_count);
      else
      dbms_output.put_line('tidak ada data');
      exit;
      end if;
    end loop;
  close cur_depts;
end;
/
--3
create or replace function temperature(data_temp in number, data_char in char)
return number is
  v_temperature number;
  
begin
  if data_char = 'C' or data_char = 'c' then
    v_temperature :=( 9/5 * data_temp ) + 32;
  elsif data_char = 'F' or data_char = 'f' then
    v_temperature := 5/9 * (data_temp - 32);
  end if;
return v_temperature;
end;
/

declare
  v_temp number := '&temp';
  v_char char := '&char';
  v_result number;
begin
  v_result := temperature(v_temp,v_char);
  if v_char = 'C' or v_char = 'c' then
    dbms_output.put_line('Konversi dari Celcius ke Fahrenheit');
    dbms_output.put_line(v_temp || ' C' || ' = ' || v_result || ' F');
  elsif v_char = 'F' or v_char = 'f' then
    dbms_output.put_line('Konversi dari Fahrenheit ke Celcius');
    dbms_output.put_line(v_temp || ' F' || ' = ' || v_result || ' C');
  end if;
end;
/

--4
declare
  cursor cur_depts is 
  select j.job_title, max(e.salary), min(e.salary), avg(e.salary)
  from employees e join jobs j
  on e.job_id = j.job_id
  where e.job_id = '&job'
  group by j.job_title;
  v_job_title jobs.job_title%type;
  v_max       employees.salary%type;
  v_min       employees.salary%type;
  v_avg       employees.salary%type;
begin
  open cur_depts;
    fetch cur_depts into v_job_title, v_max, v_min, v_avg;
    dbms_output.put_line('Job Title      : ' || v_job_title);
    dbms_output.put_line('Gaji Tertinggi : ' || v_max);
    dbms_output.put_line('Gaji Terendah  : ' || v_min);
    dbms_output.put_line('Gaji Rerata    : ' || v_avg);
  close cur_depts;
end;
/

--5
declare 
  v_first  number := '&first';
  v_last   number := '&last';
  v_ganjil number := 0;
  v_genap  number := 0;
begin 
  for i in v_first..v_last loop 
    if mod(i,2) = 0 then
      v_genap := v_genap + 1;
    else
      v_ganjil := v_ganjil + 1;
    end if;
  end loop;
  dbms_output.put_line('Diantara bilangan ' || v_first || ' dan ' || v_last);
  dbms_output.put_line('Jumlah bilangan Ganjil adalah   : ' || v_ganjil);
  dbms_output.put_line('Jumlah bilangan Genap adalah    : ' || v_genap);
end;
/

--6
declare 
  cursor cur_emp1 is 
  select distinct m.employee_id as id, (m.first_name ||' '|| m.last_name) as manager
  from employees e inner join employees m 
  on m.employee_id = e.manager_id;
  cursor cur_emp2(p_emp number) is
  select * from employees 
  where manager_id = p_emp;
begin
  for v_emp1 in cur_emp1 loop
    dbms_output.put_line('Karyawan yang dibawahi manager ID '|| v_emp1.id || ' - ' ||v_emp1.manager);
    for v_emp2 in cur_emp2(v_emp1.id) loop
      dbms_output.put_line(v_emp2.first_name || ' ' ||v_emp2.last_name);
    end loop; 
    dbms_output.put_line('');
  end loop;
end;
/