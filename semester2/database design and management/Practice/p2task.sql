set serveroutput on;
--tugas

------2.5------
--1
DECLARE
x VARCHAR2(20); 
BEGIN
x := '123' + '456' ; 
DBMS_OUTPUT.PUT_LINE(x);
END;
/

--2
declare
  v_name varchar2(30) := 'Afina Putri Dayanti';
begin
  dbms_output.put_line('total characters of my name is : ' || length(v_name));
end;
/

--3
declare
  my_date DATE := SYSDATE;
  v_last_date DATE;
begin
  v_last_date := last_day(my_date);
  dbms_output.put_line('today : ' || to_char(my_date, 'Month dd, yyyy'));
  dbms_output.put_line('the last day of this month : ' || v_last_date);
end;

/
--4
declare
  my_date date := SYSDATE;
  v_new_date date;
  v_months number;
begin
  v_new_date := my_date + 45;
  v_months := months_between(v_new_date, my_date);
  dbms_output.put_line('today : ' || to_char(my_date, 'Month dd, yyyy'));
  dbms_output.put_line('number of months between the two dates  : ' || v_months);
end;
/

DECLARE
x NUMBER(6); 
BEGIN
x := 5 + 3 * 2; 
DBMS_OUTPUT.PUT_LINE(x); 
END;
/

--5
DECLARE
v_number	NUMBER; 
v_boolean	BOOLEAN; 
BEGIN
v_number := 25;
v_boolean := NOT(v_number > 30);
dbms_output.put_line(
   case
      when v_boolean then 'TRUE'
      when v_boolean is null then 'NULL'
      else 'FALSE'
   end
);
END;
/

------2.6------
--1
DECLARE
  weight	NUMBER(3) := 600;
  message	VARCHAR2(255) := 'Product 10012'; 
BEGIN
  DECLARE
    weight	NUMBER(3)	   := 1;
    message	VARCHAR2(255) :='Product 11001'; 
    new_locn	VARCHAR2(50)        := 'Europe';
  BEGIN
    weight		:= weight + 1;
    new_locn	:= 'Western ' || new_locn;
--    DBMS_OUTPUT.PUT_LINE(new_locn); 
    -- Position 1 -- 
  END;
  weight := weight + 1;
  message := message || ' is in stock';
  DBMS_OUTPUT.PUT_LINE(new_locn); 
  -- Position 2 -- 
END;
/

--2

DECLARE
v_employee_id employees.employee_id%TYPE;
v_job employees.job_id%TYPE;
BEGIN
 SELECT employee_id, job_id INTO v_employee_id, v_job
 FROM employees
 WHERE employee_id = 100;
 DECLARE
 v_employee_id employees.employee_id%TYPE;
 v_job employees.job_id%TYPE;
 BEGIN
 SELECT employee_id, job_id INTO v_employee_id, v_job
 FROM employees
 WHERE employee_id = 103;
 DBMS_OUTPUT.PUT_LINE(v_employee_id || ' is a(n) ' || v_job);
 END;
 DBMS_OUTPUT.PUT_LINE(v_employee_id || ' is a(n) ' || v_job);
END;
/
<<outer_block>>
DECLARE
  v_employee_id	employees.employee_id%TYPE; v_job	employees.job_id%TYPE;
BEGIN
  SELECT employee_id, job_id INTO v_employee_id, v_job FROM employees
  WHERE employee_id = 100;
  <<inner_block>>
  DECLARE
    v_employee_id	employees.employee_id%TYPE; v_job	employees.job_id%TYPE;
    BEGIN
    SELECT employee_id, job_id INTO v_employee_id, v_job FROM employees
    WHERE employee_id = 103; 
    DBMS_OUTPUT.PUT_LINE(outer_block.v_employee_id || ' is a(n) ' || outer_block.v_job); 
  END;
  DBMS_OUTPUT.PUT_LINE(v_employee_id || ' is a(n) ' || v_job); 
END;
/