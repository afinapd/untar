set serveroutput on;

-- 4. a,b,c,d,e
declare
  cursor currencies_cur is
  select currency_code, currency_name
  from wf_currencies
  order by currency_name asc;
  v_currency_code   wf_currencies.currency_code%type;
  v_currency_name   wf_currencies.currency_name%type;
  
begin
  open currencies_cur;
    fetch currencies_cur into v_currency_code, v_currency_name;
    dbms_output.put_line('id : '||v_currency_code||', name : '||v_currency_name);  
  close currencies_cur;
end;
/

-- 4. f
declare
  cursor currencies_cur is
  select currency_code, currency_name
  from wf_currencies
  order by currency_name asc;
  v_currency_code   wf_currencies.currency_code%type;
  v_currency_name   wf_currencies.currency_name%type;
begin
  open currencies_cur;
    loop
    fetch currencies_cur into v_currency_code, v_currency_name;
    exit when currencies_cur%notfound;
    dbms_output.put_line('id : '||v_currency_code||', name : '||v_currency_name);  
    end loop;
  close currencies_cur;
end;
/

-- 4. g
declare
  cursor countries_cur is
  select country_name, national_holiday_date, national_holiday_name
  from wf_countries
  where region_id = 5 and national_holiday_date is not null;
  v_country_name            wf_countries.country_name%type;
  v_national_holiday_date   wf_countries.national_holiday_date%type;
  v_national_holiday_name   wf_countries.national_holiday_name%type;
begin
  open countries_cur;
    loop
    fetch countries_cur into v_country_name, v_national_holiday_date, v_national_holiday_name;
    exit when countries_cur%notfound;
    dbms_output.put_line('name country : ' || v_country_name || ', national holiday date : ' || v_national_holiday_date || ', national holiday name : ' || v_national_holiday_name);  
    end loop;
  close countries_cur;
end;
/

--6
declare
  cursor countries_cur is
  select c.region_id, r.region_name,c.how_many
  from (select region_id, count(*) AS how_many
  from wf_countries 
  group by region_id having count(*) > 10) c
  inner join wf_world_regions r
  on c.region_id=r.region_id;
  v_region_id      wf_countries.region_id%type;
  v_region_name    wf_world_regions.region_name%type;
  v_how_many       number;
begin
  open countries_cur;
    loop
    fetch countries_cur into v_region_id, v_region_name, v_how_many;
    exit when countries_cur%notfound;
    dbms_output.put_line('region id : ' || v_region_id || ', nama region : ' || v_region_name || ', jumlah negara : ' || v_how_many);  
    end loop;
  close countries_cur;
end;

/
select * from wf_countries;

--2
declare
  cursor countries_cur is
  select country_name, national_holiday_date, national_holiday_name
  from wf_countries
  where region_id = 5;
  v_countries countries_cur%rowtype;
begin
  open countries_cur;
    loop
    fetch countries_cur into v_countries;
    exit when countries_cur%notfound;
    dbms_output.put_line('name country : ' || v_countries.country_name || ', national holiday date : ' || v_countries.national_holiday_date || ', national holiday name : ' || v_countries.national_holiday_name);  
    end loop;
  close countries_cur;
end;
/

--3
declare
  cursor employees_cur is
  select first_name, last_name, job_id, salary
  from employees
  order by salary desc;
  v_employees employees_cur%rowtype;
begin
  open employees_cur;
    loop
    fetch employees_cur into v_employees;
    exit when employees_cur%rowcount > 21;
    dbms_output.put_line(v_employees.first_name|| ' ' ||v_employees.last_name || ', job id : ' || v_employees.job_id||', salary : '||v_employees.salary);  
    end loop;
  close employees_cur;
end;
/

--5
declare
  cursor employees_cur is
  select first_name, last_name, job_id, salary
  from employees
  order by salary desc;
  v_employees employees_cur%rowtype;
begin
  open employees_cur;
    loop
    fetch employees_cur into v_employees;
    exit when employees_cur%notfound or employees_cur%rowcount > 21;
    dbms_output.put_line(v_employees.first_name|| ' ' ||v_employees.last_name || ', job id : ' || v_employees.job_id||', salary : '||v_employees.salary);  
    end loop;
  close employees_cur;
end;
/
