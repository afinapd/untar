set serveroutput on

--2 a
declare 
  type t_country is table of wf_countries.country_id%type
  index by binary_integer;
  v_country   t_country;
begin
  for country_rec in (
  select country_id, country_name
  from wf_countries
  where region_id = 5
  order by country_id asc)
  loop
    v_country(country_rec.country_id):= country_rec.country_id;
--    DBMS_OUTPUT.PUT_LINE(v_country(country_rec.country_id).country_name);
  end loop;
end;
/
--2a
declare 
  type t_country_names is table of wf_countries.country_name%type 
  index by binary_integer; 
  v_country_names t_country_names; 
  
  cursor country_curs is 
  select country_id, country_name 
  from wf_countries 
  where region_id = 5 
  order by country_id asc; 
  v_country_rec country_curs%rowtype; 
begin 
  open country_curs; 
  loop 
    fetch country_curs into v_country_rec; 
    exit when country_curs%notfound; 
    v_country_names(v_country_rec.country_id) := v_country_rec.country_name; 
  end loop; 
  close country_curs; 
end; 
/

--2b
declare 
  type t_country_names is table of wf_countries.country_name%type 
  index by binary_integer; 
  v_country_names t_country_names; 
  
  cursor country_curs is 
  select country_id, country_name 
  from wf_countries 
  where region_id = 5 
  order by country_id asc; 
  v_country_rec country_curs%rowtype; 
begin 
  open country_curs; 
  loop 
    fetch country_curs into v_country_rec; 
    exit when country_curs%notfound; 
    v_country_names(v_country_rec.country_id) := v_country_rec.country_name; 
  end loop; 
  close country_curs; 
  for i in v_country_names.first..v_country_names.last loop
    if v_country_names.exists(i) then
     dbms_output.put_line('country id : '|| i || ', country name : '|| v_country_names(i));
    end if;
  end loop;
end; 
/

--2c
declare 
  type t_country_names is table of wf_countries.country_name%type 
  index by binary_integer; 
  v_country_names t_country_names; 
  
  cursor country_curs is 
  select country_id, country_name 
  from wf_countries 
  where region_id = 5 
  order by country_id asc; 
  v_country_rec country_curs%rowtype; 
begin 
  open country_curs; 
  loop 
    fetch country_curs into v_country_rec; 
    exit when country_curs%notfound; 
    v_country_names(v_country_rec.country_id) := v_country_rec.country_name; 
  end loop; 
  close country_curs; 
    dbms_output.put_line(v_country_names.first || ' ' || v_country_names(v_country_names.first)); 
    dbms_output.put_line(v_country_names.last || ' ' || v_country_names(v_country_names.last)); 
    dbms_output.put_line('Number of countries is: ' || v_country_names.count); 
end; 
/

--3a
declare
    cursor c_employees is
    select employee_id, job_id, salary 
    from employees
    order by employee_id asc;
    v_employees_rec   c_employees%rowtype;
    
    type t_employees is table of c_employees%rowtype 
    index by binary_integer;
    v_employees_data  t_employees;
begin
   open c_employees; 
    loop 
      fetch c_employees into v_employees_rec; 
      exit when c_employees%notfound; 
      v_employees_data(v_employees_rec.employee_id) := v_employees_rec;
--      dbms_output.put_line(v_employees_rec.employee_id); 
    end loop;
end;
/

--3b
declare
    cursor c_employees is
    select employee_id, job_id, salary 
    from employees
    order by employee_id asc;
    v_employees_rec   c_employees%rowtype;
    
    type t_employees is table of c_employees%rowtype 
    index by binary_integer;
    v_employees_data  t_employees;
begin
  open c_employees; 
    loop 
      fetch c_employees into v_employees_rec; 
      exit when c_employees%notfound; 
      v_employees_data(v_employees_rec.employee_id) := v_employees_rec;
--      dbms_output.put_line(v_employees_rec.employee_id); 
    end loop;
  close c_employees;
    
  for i in v_employees_data.first..v_employees_data.last loop
    if v_employees_data.exists(i) then
     dbms_output.put_line('country id : '|| i || v_employees_data(i).salary);
    end if;
  end loop;
end;
/