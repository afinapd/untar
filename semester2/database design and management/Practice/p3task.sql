set serveroutput on;


--tugas

------3.1------
select * from grocery_items;
--3
create table grocery_items(
  product_id number(3,0) primary key,
  brand varchar2(20),
  description varchar2(50)
  );

--4
insert into grocery_items(product_id, brand, description) values (110,'Colgate','Toothpaste');
insert into grocery_items(product_id, brand, description) values (111,'Ivory','Soap');
insert into grocery_items(product_id, brand, description) values (112,'Heinz','Ketchup');

--5
insert into grocery_items(product_id, brand, description) values (113,'Milo','Milk');

--6
update grocery_items
  set description = 'tomato catsup'
  where product_id = 112;

--7  
insert into grocery_items values (114,'Burger King','Burger');

--8
update grocery_items
  set brand = 'Dove'
  where product_id = 111;
  
--9
create table new_items(
  product_id number(3,0) primary key,
  brand varchar2(20),
  description varchar2(50)
  );
insert into new_items(product_id, brand, description) values (110,'Colgate','Dental paste');
insert into new_items(product_id, brand, description) values (175,'Dew','Soda');
insert into new_items(product_id, brand, description) values (275,'Palmolive','Dish detergent');

--10
merge into grocery_items g
  using new_items n
  on (g.product_id = n.product_id)
  when matched then
    update set 
      g.brand = n.brand,
      g.description = n.description
  when not matched then
    insert values(n.product_id, n.brand, n.description);
    
------3.2------
--2
declare
  v_max_deptno departments.department_id%type;
begin
  select max(department_id) into v_max_deptno
  from departments;
  dbms_output.put_line(v_max_deptno);
end;
/

--3
DECLARE
  v_country_name	  wf_countries.country_name%TYPE := 'Federative Republic of Brazil'; 
  v_lowest_elevation	wf_countries.lowest_elevation%TYPE;
  v_highest_elevation	wf_countries.highest_elevation%TYPE; 
BEGIN
  SELECT lowest_elevation, highest_elevation 
  INTO v_lowest_elevation, v_highest_elevation
  FROM wf_countries
  WHERE country_name = v_country_name;
  DBMS_OUTPUT.PUT_LINE('The lowest elevation in '|| v_country_name || ' is ' || v_lowest_elevation
  || ' and the highest elevation is ' || v_highest_elevation || '.'); 
END;
/

--4
DECLARE
  v_emp_lname	employees.last_name%TYPE; 
  v_emp_salary	employees.salary%TYPE;
BEGIN
  SELECT last_name, salary INTO v_emp_lname, v_emp_salary 
  FROM employees
  WHERE job_id = 'IT_PRAG'; 
  DBMS_OUTPUT.PUT_LINE(v_emp_lname || ' ' || v_emp_salary);
END;
/

--5
DECLARE
  last_name VARCHAR2(25) := 'Fay'; 
BEGIN
  UPDATE emp_dup
  SET first_name = 'Jennifer' WHERE emp_dup.last_name = last_name;
END;
/
create table emp_dup as (select * from employees);

select first_name, last_name from emp_dup where last_name='Fay';

drop table emp_dup;
/
DECLARE
  v_last_name VARCHAR2(25) := 'Fay'; 
BEGIN
  UPDATE emp_dup
  SET first_name = 'Jennifer' WHERE last_name = v_last_name;
END;
/

--6
create table test_no6(
  test_no6 number(3,0) primary key,
  brand varchar2(20),
  description varchar2(50)
  );
insert into test_no6(test_no6, brand, description) values (110,'Colgate','Toothpaste');
select * from test_no6;

--7
drop table test_no7;
create table test_no7(
  test_no7 number(3,0) primary key,
  brand varchar2(20),
  description varchar2(50)
  );
insert into test_no7(test_no7, brand, description) values (110,'Colgate','Toothpaste');


declare 
    test_no7 number(3,0) := 200;
begin
    select test_no7 into test_no7 from test_no7 where test_no7 = test_no7;
    dbms_output.put_line(test_no7);
END;