set serveroutput on

--no 1
create or replace function temperature(data_temp in number, data_char in char)
return number is
  v_result number(6,1);
  
begin
  if data_char = 'C' or data_char = 'c' then
    v_result := 5/9 * (data_temp - 32);
  elsif data_char = 'F' or data_char = 'f' then
    v_result := (9/5 * data_temp) + 32;
  end if;
      
return v_result;
end;
/

declare
  v_temp number := '&temp';
  v_char char := '&char';
  v_result number;
begin
  v_result := temperature(v_temp,v_char);
  if v_char = 'C' or v_char = 'c' then
    dbms_output.put_line('Konversi dari Fahrenheit ke Celcius');
    dbms_output.put_line(v_temp || ' F' || ' = ' || v_result || ' C');
  elsif v_char = 'F' or v_char = 'f' then
    dbms_output.put_line('Konversi dari Celcius ke Fahrenheit');
    dbms_output.put_line(v_temp || ' C' || ' = ' || v_result || ' F');
  else
    dbms_output.put_line('You entered the wrong code');
  end if;
end;
/

--no 2
declare
  cursor cur_depts_locs is 
  select d.department_name, d.location_id, l.street_address, l.city
  from departments d join locations l
  on d.location_id = l.location_id;
  v_cur_depts_locs  cur_depts_locs%rowtype;
begin
  open cur_depts_locs;
    loop
    fetch cur_depts_locs into v_cur_depts_locs;
    exit when cur_depts_locs%notfound;
    dbms_output.put_line(v_cur_depts_locs.department_name || ' - ' || v_cur_depts_locs.location_id || ' - ' || v_cur_depts_locs.street_address || ' - ' ||  v_cur_depts_locs.city);
    end loop;
  close cur_depts_locs;
end;

/
--no 3
declare
  v_last_name  employees.last_name%type;
  v_salary     employees.salary%type;
  v_new_salary employees.salary%type;
begin
  select last_name, salary into v_last_name, v_salary
  from employees
  where employee_id = '&id';
  if v_salary < 10000 then
    v_new_salary := v_salary + (v_salary * 0.20);
    dbms_output.put_line('Last Name is ' || v_last_name || ' with salary ' || v_salary || ' and new salary is ' || v_new_salary);
  elsif v_salary < 15000 then
    v_new_salary := v_salary + (v_salary * 0.10);
    dbms_output.put_line('Last Name is ' || v_last_name || ' with salary ' || v_salary || ' and new salary is ' || v_new_salary);
  else
    v_new_salary := v_salary;
    dbms_output.put_line('Last Name is ' || v_last_name || ' cant get additional salary because her/his salary is ' || v_new_salary);
  end if;
end;
/

--no 4
declare
  cursor cur_hr is 
  select d.department_name, count(*) as count
  from hr.employees e join hr.departments d
  on e.department_id = d.department_id
  group by d.department_name
  having count(*) > 10;
  v_cur_hr  cur_hr%rowtype;
begin
  open cur_hr;
    dbms_output.put_line('Department dengan jumlah karyawan > 10');
    loop
    fetch cur_hr into v_cur_hr;
    exit when cur_hr%notfound;
      dbms_output.put_line('Department : '|| v_cur_hr.department_name||', jumlah karyawan : '|| v_cur_hr.count);
    end loop;
  close cur_hr;
end;
/

--no 5
declare
  cursor cur_jobs is
  select j.job_title as job_title, max(e.salary) as max_salary, min(e.salary) as min_salary, avg(e.salary) as avg_salary
  from employees e join jobs j
  on e.job_id = j.job_id
  where e.job_id = '&job'
  group by j.job_title; 
begin
  for v_jobs_record in cur_jobs
  loop
    dbms_output.put_line('Job Title      : ' || v_jobs_record.job_title);
    dbms_output.put_line('Gaji Tertinggi : ' || v_jobs_record.max_salary);
    dbms_output.put_line('Gaji Terendah  : ' || v_jobs_record.min_salary);
    dbms_output.put_line('Gaji Rerata    : ' || v_jobs_record.avg_salary); 
  end loop; 
end;
/

--no 6
declare 
  v_first  number := '&first';
  v_last   number := '&last';
  v_ganjil number := 0;
  v_genap  number := 0;
begin 
  for i in v_first..v_last loop 
    if mod(i, 2) = 0 then
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