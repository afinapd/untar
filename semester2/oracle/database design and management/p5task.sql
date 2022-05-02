set serveroutput on;

----4.3
--4
  declare
    v_name        wf_countries.country_name%type;
    v_country_id  wf_countries.country_id%type := 1;
  begin
    select country_name, country_id into v_name, v_country_id
    from wf_countries
    where country_id = v_country_id;
    loop 
      dbms_output.put_line( 'country name : ' || v_name ||' , country id : ' || v_country_id);
      v_country_id := v_country_id + 1;
      if v_country_id > 3 then exit;  
      end if;
    end loop;
  end;
  /

--5
declare
  v_name        wf_countries.country_name%type;
  v_country_id  wf_countries.country_id%type := 1;
begin
  select country_name, country_id into v_name, v_country_id
  from wf_countries
  where country_id = v_country_id;
  loop 
    dbms_output.put_line( 'country name : ' || v_name ||' , country id : ' || v_country_id);
    v_country_id := v_country_id + 1;
    exit when v_country_id > 3;
  end loop;
end;
/
--6
DROP TABLE messages;
CREATE TABLE messages (results NUMBER(2));
select * from messages;
insert into grocery_items(product_id, brand, description) values (110,'Colgate','Toothpaste');
/
declare
  v_counter       messages.results%type;
begin
  for v_counter in 1..10 loop
      if v_counter not in (6, 8) then  
      insert into messages(results) values (v_counter);
      end if;
  end loop;
end;
/
----4.4
--1
declare
  v_name        wf_countries.country_name%type;
  v_country_id  wf_countries.country_id%type := 51;
begin
  select country_name, country_id into v_name, v_country_id
  from wf_countries
  where country_id = v_country_id;
  while v_country_id <= 55 loop  
    dbms_output.put_line( 'country name : ' || v_name ||' , country id : ' || v_country_id);
    v_country_id := v_country_id + 1;
  end loop;
end;
/

--2
declare 
  v_name        wf_countries.country_name%type;
  v_country_id  wf_countries.country_id%type := 51;
begin 
  for i in reverse v_country_id..55 loop 
    select country_name, country_id into v_name, v_country_id
    from wf_countries
    where country_id = i;
    dbms_output.put_line('country name : ' || v_name ||' , country id : ' || v_country_id); 
  end loop;
end; 
/

--3
declare
v_empno   EMP.EMPLOYEE_ID%TYPE  :=176;
v_sal     EMP.SALARY%TYPE;
begin
  select NVL(FLOOR(salary/1000),0) into v_sal
  from EMP
  where employee_id = v_empno;
  for i in 1..v_sal loop
    dbms_output.put('*'); 
  end loop;
  dbms_output.new_line;
end;
/
DROP TABLE new_emps;
CREATE TABLE new_emps AS SELECT * FROM employees;
ALTER TABLE new_emps ADD stars VARCHAR2(50);

/
declare
  v_empno		          new_emps.employee_id%type :=&id;
  v_asterisk		      new_emps.stars%type := null; 
  v_sal_in_thousands	new_emps.salary%type;
begin
  select NVL(TRUNC(salary/1000), 0) into v_sal_in_thousands 
  from new_emps 
  where employee_id = v_empno;
  dbms_output.put('salary id ' || v_empno || ' : '); 
  for i in 1..v_sal_in_thousands loop
    dbms_output.put('*'); 
  end loop;
  dbms_output.new_line;
  update new_emps 
  set stars = v_asterisk
  where employee_id = v_empno; 
end;
/