set serveroutput on;

---- 4.3
--8
DECLARE
  v_counter NUMBER(2) := 1;
BEGIN
  LOOP
  DBMS_OUTPUT.PUT_LINE('Loop execution #' || v_counter);
  v_counter := v_counter + 1;
  EXIT WHEN v_counter > 5;
  END LOOP;
END;
/

--9
create table loc_1 as select * from locations;
desc loc_1;

DECLARE
  v_loc_id loc_1.location_id%TYPE;
  v_counter NUMBER(2) := 1;
BEGIN
  SELECT MAX(location_id)INTO v_loc_id
  FROM loc_1
  WHERE country_id= 'CA';
  LOOP
    INSERT INTO loc_1(location_id, city, country_id)  
    VALUES((v_loc_id+ v_counter), 'Montreal', 'CA');
  v_counter := v_counter + 1;
  EXIT WHEN v_counter > 3;
  END LOOP;
END;

/
----4.4
--8
DECLARE 
  v_loc_id loc_1.location_id%TYPE;
  v_counter   NUMBER := 1;
  BEGIN
  SELECT MAX(location_id) INTO v_loc_id
  FROM loc_1
  WHERE country_id= 'CA';
  WHILE v_counter <= 3 LOOP
  INSERT INTO loc_1(location_id, city, country_id)  
  VALUES((v_loc_id+ v_counter), 'Montreal', 'CA');
  v_counter := v_counter + 1;
  END LOOP;
END;
/
select * from loc_1;

--15
DECLARE 
  v_loc_id loc_1.location_id%TYPE;
  v_counter   NUMBER := 1;
  BEGIN
  SELECT MAX(location_id) INTO v_loc_id
  FROM loc_1
  WHERE country_id= 'CA';
  for i in 1..3 loop
  INSERT INTO loc_1(location_id, city, country_id)  
  VALUES((v_loc_id + i), 'Montreal', 'CA');
  END LOOP;
END;
/

--17
DECLARE 
  v_lower  NUMBER := 1;
  v_upper  NUMBER := 100;
BEGIN
  FOR i IN v_lower..v_upper LOOP
  dbms_output.put_line('angka ' || i);
  END LOOP;
END;
/

----4.5
--5
BEGIN
  FOR v_outerloop IN 1..3 LOOP
    FOR  v_innerloop IN REVERSE 1..5 LOOP
      DBMS_OUTPUT.PUT_LINE('Outer loop is: ' || v_outerloop||' and inner loop is: ' || v_innerloop);
      END LOOP;
  END LOOP;
END; 
/

DECLARE 
  v_outer  CHAR(3) := 'NO';
  v_inner  CHAR(3) := 'YES';
BEGIN
  loop
    loop
     DBMS_OUTPUT.PUT_LINE('Outer inner is: ' || v_inner);
     exit when v_inner = 'YES';
    end loop;
    DBMS_OUTPUT.PUT_LINE('Outer outer is: ' || v_outer);
    exit when v_outer = 'YES';
  end loop;
END;
/

--9
DECLARE 
  v_outer  CHAR(3) := 'NO';
  v_inner  CHAR(3) := 'YES';
BEGIN
  <<outer_loop>>
  loop
   <<inner_loop>>
    loop
     DBMS_OUTPUT.PUT_LINE('Outer inner is: ' || v_inner);
     exit outer_loop when v_inner = 'YES';
    end loop;
    DBMS_OUTPUT.PUT_LINE('Outer outer is: ' || v_outer);
    exit when v_outer = 'YES';
  end loop;
END;
/

DECLARE
  v_outerloop PLS_INTEGER:= 0;
  v_innerloop PLS_INTEGER:= 5;
  BEGIN
  <<outer_loop>>
  LOOP 
    v_outerloop:= v_outerloop+ 1;
    v_innerloop:= 5;
    EXIT WHEN v_outerloop > 3;
    <<inner_loop>>
    LOOP
      DBMS_OUTPUT.PUT_LINE('Outer loop is: ' || v_outerloop||' and inner loop is: ' || v_innerloop);
      v_innerloop:= v_innerloop- 1;
      EXIT WHEN v_innerloop= 0;
    END LOOP inner_loop;
  END LOOP outer_loop;
END;   
/

declare
v_regID regions.region_id%type;
v_reg_name regions.region_name%type;
v_count number := 1;

begin
select count(region_id) into v_regID from regions;
  loop
  v_count := v_count+1;
  exit when v_count > v_regID;
  if mod(v_count,0)=0 then
    select region_name into v_reg_name from regions
    where region_id = v_count;
    dbms_output.put_line('region name = '|| v_reg_name
    ||' region id = '||v_count );
    end if;
  end loop;
end;
/

select * from regions;
/

---- soal : select region name if region_id == genap
--basic loop
declare 
  v_regID regions.region_id%type;
  v_reg_name regions.region_name%type;
  v_count number := 1;
begin 
  select count(region_id) into v_regID 
  from regions;
  loop v_count := v_count + 1;
    exit when v_count > v_regID;
    if mod(v_count,2) = 0 then
      select region_name into v_reg_name 
      from regions
      where region_id = v_count;
      dbms_output.put_line('Region Name = ' || v_reg_name ||', Region ID = ' || v_count);
    end if;
  end loop;
end;
/

-- while loop
declare
  v_regID regions.region_id%type;
  v_reg_name regions.region_name%type;
  v_count number := 1;
begin
  select count(region_id) into v_regID 
  from regions;
  while v_count < v_regID loop v_count := v_count + 1;
    if mod(v_count,2) = 0 then
      select region_name into v_reg_name 
      from regions
      where region_id = v_count;
      dbms_output.put_line('Region Name = ' || v_reg_name ||', Region ID = ' || v_count);
    end if;
  end loop;
end;
/
--for loop
declare
  v_regID regions.region_id%type;
  v_reg_name regions.region_name%type;
begin
  select count(region_id) into v_regID 
  from regions;
  for i in 1..v_regID loop 
    if mod(i,2) = 0 then
      select region_name into v_reg_name 
      from regions
      where region_id = i;dbms_output.put_line('Region Name = ' || v_reg_name ||', Region ID = ' || i);
    end if;
  end loop;
end;
/
--soal latihan loop
/*
--1
buat sebuah program untuk menampilkan data dari employee_id 101 s/d 105 berupa:
- employee_id
- last_name
- salary

dari table hr.employees, hitunglah dan tampilkan rata2 gajinya.

--2 buat program faktorial

contoh output:
5! = 120 
*/


--jawaban
--1 basic loop
declare
  v_id hr.employees.employee_id%type;
  v_name hr.employees.last_name%type;
  v_sal hr.employees.salary%type;
  v_count number := 101;
  counter number := 0;
  jum number := 0;
begin
  loop
    select employee_id, last_name, salary
    into v_id, v_name, v_sal
    from hr.employees
    where employee_id = v_count;
    dbms_output.put_line('id : ' || v_id || ', name : ' || v_name || ', salary : ' || v_sal);
    v_count := v_count + 1;
    counter := counter + 1;
    jum:= jum + v_sal;
    exit when v_count > 105;
  end loop;
  dbms_output.put_line( 'rata2 gaji : ' || jum / counter);
end;
/

--1 while loop
declare
  v_id hr.employees.employee_id%type;
  v_name hr.employees.last_name%type;
  v_sal hr.employees.salary%type;
  v_count number := 101;
  counter number := 0;
  jum number := 0;
begin
  while v_count < 106 loop
    select employee_id, last_name, salary
    into v_id, v_name, v_sal
    from hr.employees
    where employee_id = v_count;
    dbms_output.put_line('id : ' || v_id || ', name : ' || v_name || ', salary : ' || v_sal);
    v_count := v_count + 1;
    counter := counter + 1;
    jum:= jum + v_sal;
  end loop;
  dbms_output.put_line( 'rata2 gaji : ' || jum / counter);
end;
/

--1 for loop
declare
  v_id hr.employees.employee_id%type;
  v_name hr.employees.last_name%type;
  v_sal hr.employees.salary%type;
  v_count number := 101;
  counter number := 0;
  jum number := 0;
begin
  for i in v_count..105 loop
    select employee_id, last_name, salary
    into v_id, v_name, v_sal
    from hr.employees
    where employee_id = v_count;
    dbms_output.put_line('id : ' || v_id || ', name : ' || v_name || ', salary : ' || v_sal);
    v_count := v_count + 1;
    counter := counter + 1;
    jum:= jum + v_sal;
  end loop;
  dbms_output.put_line( 'rata2 gaji : ' || jum / counter);
end;
/


--2
--2 basic loop
declare
v_min number:= 1;
v_max number:= &numb2;
v_hasil number := 1;
v_count number := 1;
begin 
  loop
    v_hasil := v_hasil * v_count;
    v_count := v_count + 1; 
    exit when v_count > v_max; 
    end loop;
  dbms_output.put_line(v_max|| '!' || ' = ' || v_hasil);
end;
/

--2 while loop
declare
  v_max number:= &numb2;
  v_hasil number := 1;
  v_count number := 1;
begin 
  while v_count <= v_max loop
    v_hasil := v_hasil * v_count;
    v_count := v_count + 1; 
  end loop;
  dbms_output.put_line(v_max|| '!' || ' = ' || v_hasil);
end;
/

--2 for loop
declare
  v_min number:= 1;
  v_max number:= &numb2;
  v_hasil number := 1;
begin 
  for i in reverse v_min..v_max loop
    v_hasil := v_hasil * i;
  end loop;
  dbms_output.put_line(v_max|| '!' || ' = ' || v_hasil);
end;
/
