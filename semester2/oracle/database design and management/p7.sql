set serveroutput on

declare
  v_id    employees.employee_id%type;
  v_name  employees.last_name%type;
begin
  select employee_id, last_name into v_id, v_name
  from employees
  where employee_id =100;
  dbms_output.put_line('- '||v_id||', '||v_name);
end;
/

declare
  v_emp_rec employees%rowtype;
begin
  select * into v_emp_rec
  from employees
  where employee_id =100;
  dbms_output.put_line('- '||v_emp_rec.employee_id||', '||v_emp_rec.last_name);
end;
/

declare
  v_emp_rec       employees%rowtype;
  v_emp_copy_rec  v_emp_rec%rowtype;
begin
  select * into v_emp_rec
  from employees
  where employee_id =100;
  v_emp_copy_rec := v_emp_rec;
  v_emp_copy_rec.salary := v_emp_rec.salary * 1.2;
  
  
  dbms_output.put_line('- '||v_emp_rec.employee_id||', '||v_emp_rec.last_name||' , gaji lama : '||v_emp_rec.salary||', gaji baru : ' ||v_emp_copy_rec.salary );
end;
/

DECLARE
  TYPE person_dept IS RECORD(
  first_name      employees.first_name%TYPE,
  last_name       employees.last_name%TYPE,
  department_name departments.department_name%TYPE);
  v_person_dept_rec  person_dept;
BEGIN
  SELECT e.first_name, e.last_name, d.department_name
  INTO v_person_dept_rec
  FROM employees e 
  JOIN departments d ON e.department_id= d.department_id
  WHERE employee_id= 200;
  DBMS_OUTPUT.PUT_LINE(v_person_dept_rec.first_name || ' ' || v_person_dept_rec.last_name || ' is in the ' || v_person_dept_rec.department_name || ' department.');
END;

/
DECLARE
  TYPE dept_info_type IS RECORD(
  department_id   departments.department_id%TYPE,
  department_name departments.department_name%TYPE);
  TYPE emp_dept_type IS RECORD(
  first_name      employees.first_name%TYPE,
  last_name       employees.last_name%TYPE,
  dept_info       dept_info_type);
  v_emp_dept_rec  emp_dept_type;
BEGIN
  SELECT e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_ID, d.DEPARTMENT_NAME into v_emp_dept_rec
  FROM employees e 
  JOIN departments d ON e.department_id= d.department_id
  WHERE employee_id= 200;
  DBMS_OUTPUT.PUT_LINE(v_emp_dept_rec.first_name);
END;
/

DECLARE --outer block
  TYPE employee_type IS RECORD(
  first_name  employees.first_name%TYPE:= 'Amy');
  v_emp_rec_outer employee_type;
BEGIN
  DBMS_OUTPUT.PUT_LINE(v_emp_rec_outer.first_name);
    DECLARE --inner block
      v_emp_rec_inner employee_type;
    BEGIN
      v_emp_rec_outer.first_name:= 'Clara';
      DBMS_OUTPUT.PUT_LINE(v_emp_rec_outer.first_name|| ' and ' || v_emp_rec_inner.first_name);
    END;
  DBMS_OUTPUT.PUT_LINE(v_emp_rec_outer.first_name);
END;
/

DECLARE 
  TYPE t_hire_date IS TABLE OF employees.hire_date%TYPE
  INDEX BY BINARY_INTEGER;
  v_hire_date_tab   t_hire_date;
BEGIN
FOR emp_rec IN (
  SELECT employee_id, hire_date, last_name
  FROM employees) 
  LOOP
  v_hire_date_tab(emp_rec.employee_id):= emp_rec.hire_date;
  DBMS_OUTPUT.PUT_LINE(emp_rec.employee_id||' - '||emp_rec.last_name||' - '||emp_rec.hire_date);
  END LOOP;
END;
/

DECLARE 
  TYPE t_hire_date IS TABLE OF employees.hire_date%TYPE
  INDEX BY BINARY_INTEGER;
  v_hire_date_tab   t_hire_date;
  v_count BINARY_INTEGER := 0;
BEGIN
FOR emp_rec IN (
  SELECT employee_id, hire_date, last_name
  FROM employees) 
  LOOP
  v_count := v_count+1;
  v_hire_date_tab(v_count):= emp_rec.hire_date;
  DBMS_OUTPUT.PUT_LINE(emp_rec.employee_id||' - '||emp_rec.last_name||' - '||emp_rec.hire_date);
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('');
  DBMS_OUTPUT.PUT_LINE('jumlah = '||v_hire_date_tab.count||' baris');
END;

/

DECLARE 
  TYPE t_emp_rec IS TABLE OF employees%ROWTYPE
  INDEX BY BINARY_INTEGER;
  v_emp_rec_tab t_emp_rec;
BEGIN
  FOR emp_rec IN (SELECT *FROM employees) LOOP
  v_emp_rec_tab(emp_rec.employee_id) := emp_rec;
--  DBMS_OUTPUT.PUT_LINE(v_emp_rec_tab(emp_rec.employee_id).salary);
  END LOOP;
  
  for i in v_emp_rec_tab.first..v_emp_rec_tab.last loop
  if v_emp_rec_tab.exists(i) then
  DBMS_OUTPUT.PUT_LINE('id : '|| i || ' , last name : '|| v_emp_rec_tab(i).last_name||' , salary : ' || v_emp_rec_tab(i).salary);
  end if;
  end loop;
END;