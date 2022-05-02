set serveroutput on;

DECLARE
  CURSOR cur_depts IS 
  SELECT department_id, department_name
  FROM departments;
  v_department_id departments.department_id%TYPE;
  v_department_name departments.department_name%TYPE;
BEGIN
  OPEN cur_depts;
    LOOP
    FETCH cur_depts INTO v_department_id, v_department_name;
    EXIT WHEN cur_depts%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('id : '||v_department_id||', name : '||v_department_name);  
    END LOOP;
  CLOSE cur_depts;
END;
/

--active set: kumpulan barus yang dihasilkan leh query multiple row
--active set disimpan didalam context area

DECLARE
  CURSOR cur_emps IS 
  SELECT employee_id, last_name, salary
  FROM employees
  WHERE  department_id=30;
  v_empno employees.employee_id%TYPE;
  v_lname employees.last_name%TYPE;
  v_sal   employees.salary%TYPE;
BEGIN
  OPEN cur_emps;
  LOOP
    FETCH cur_emps INTO v_empno, v_lname, v_sal;
    EXIT WHEN cur_emps%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE( v_empno||' '||v_lname||' '||v_sal); 
  END LOOP;
  CLOSE cur_emps;
END;
/

----5.2
--11 record
DECLARE 
  CURSOR cur_emps IS 
  SELECT * FROM employees
  WHERE department_id= 10;
  v_emp_record cur_emps%ROWTYPE;
BEGIN
  OPEN cur_emps;
  LOOP
    FETCH cur_emps INTO  v_emp_record;
    EXIT WHEN cur_emps%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_emp_record.employee_id|| ' - ' ||   v_emp_record.last_name);
  END LOOP;
  CLOSE cur_emps;
END;
/
--tanpa record
DECLARE 
  CURSOR cur_emps IS 
  SELECT * FROM employees
  WHERE department_id= 10;
  v_emp_record cur_emps%ROWTYPE;
BEGIN
  OPEN cur_emps;
  LOOP
    FETCH cur_emps INTO  v_emp_record;
    EXIT WHEN cur_emps%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_emp_record.employee_id|| ' - ' ||   v_emp_record.last_name);
  END LOOP;
  CLOSE cur_emps;
END;
/

--12
DECLARE 
  CURSOR cur_emps_dept IS 
  SELECT first_name, last_name, department_name
  FROM employees e, departments d
  WHERE  e.department_id= d.department_id;
  v_emp_dept_record     cur_emps_dept%ROWTYPE;
BEGIN
  OPEN cur_emps_dept;
  LOOP
    FETCH cur_emps_dept INTO    v_emp_dept_record;
    EXIT WHEN cur_emps_dept%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_emp_dept_record.first_name|| 
    ' –'|| v_emp_dept_record.last_name|| ' – '||   
    v_emp_dept_record.department_name);
  END LOOP;
  CLOSE cur_emps_dept;
END;
/

--14
DECLARE 
  CURSOR cur_emps IS 
  SELECT * FROM employees
  WHERE  department_id= 50;
  v_emp_record     cur_emps%ROWTYPE;
BEGIN
  if not cur_emps%isopen then
  OPEN cur_emps;
  end if;
   LOOP
    FETCH cur_emps INTO  v_emp_record;
    EXIT WHEN cur_emps%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_emp_record.employee_id|| ' - ' ||   v_emp_record.last_name);
  END LOOP;
  CLOSE cur_emps;
END;
/ 

--contoh rowcount & notfound
DECLARE 
  CURSOR cur_emps IS 
  SELECT * FROM employees
  WHERE  department_id= 50;
  v_emp_record     cur_emps%ROWTYPE;
  v_count number;
BEGIN
  if not cur_emps%isopen then
  OPEN cur_emps;
  end if;
   LOOP
    v_count := v_count +1;
    FETCH cur_emps INTO  v_emp_record;
    EXIT WHEN cur_emps%rowcount > 5 or cur_emps%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_emp_record.employee_id|| ' - ' ||   v_emp_record.last_name);
  END LOOP;
  CLOSE cur_emps;
END;
/

create table emp_c as select * from employees;
select* from emp_c;

/
DECLARE
  CURSOR cur_emps IS
  SELECT employee_id, salary 
  FROM employees
  ORDER BY SALARY DESC;
  v_emp_record cur_emps%ROWTYPE;
  v_rowcount number;
BEGIN 
  OPEN cur_emps;
    LOOP
      FETCH cur_emps INTO v_emp_record;
      EXIT WHEN cur_emps%NOTFOUND;  
      v_rowcount := cur_emps%ROWCOUNT;
      INSERT INTO emp_c(employee_id,rank, salary)
      VALUES(v_emp_record.employee_id, v_rowcount, v_emp_record.salary);
    end loop;
  close cur_emps;
end;
/

----5.3
--8
DECLARE
  CURSOR cur_emps IS 
  SELECT employee_id, last_name
  FROM employees
  WHERE department_id= 50; 
BEGIN
  FOR v_emp_record IN cur_emps
  LOOP
    DBMS_OUTPUT.PUT_LINE(v_emp_record.employee_id|| ' ' || v_emp_record.last_name);   
  END LOOP; 
END;
/

--11
--open fetch close
DECLARE
  CURSOR cur_emps IS 
  SELECT employee_id,last_name
  FROM employees
  WHERE department_id= 50;
  v_emp_rec  cur_emps%ROWTYPE;
BEGIN
  OPEN cur_emps;
    LOOP
    FETCH cur_emps INTO v_emp_rec;
    EXIT WHEN cur_emps%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_emp_rec.employee_id|| ' ' || v_emp_rec.last_name);   
    END LOOP;
  CLOSE cur_emps;
END;
/

--12
DECLARE
  CURSOR cur_depts IS 
  SELECT department_id, department_name
  FROM departments
  ORDER BY department_id; 
BEGIN
  FOR v_dept_record IN cur_depts
  LOOP
  DBMS_OUTPUT.PUT_LINE(v_dept_record.department_id|| ' '  || v_dept_record.department_name);  
  END LOOP; 
END;
/

--14
DECLARE
  CURSOR cur_emps IS 
  SELECT employee_id, last_name
  FROM employees;
BEGIN
  FOR v_emp_record IN  cur_emps LOOP 
  EXIT WHEN cur_emps%ROWCOUNT > 5;
  DBMS_OUTPUT.PUT_LINE(v_emp_record.employee_id|| ' ' || v_emp_record.last_name);  
  END LOOP; 
END;
/

--16 subqueries
BEGIN
  FOR v_emp_record IN (
  SELECT employee_id, last_name
  FROM employees 
  WHERE department_id= 50)
  LOOP
  DBMS_OUTPUT.PUT_LINE(v_emp_record.employee_id|| ' '|| v_emp_record.last_name);   
  END LOOP; 
END;

/
--5.4 curser w/ parameter
DECLARE 
  CURSOR cur_country(p_region_id NUMBER) IS 
  SELECT country_id, country_name
  FROM countries
  WHERE region_id = p_region_id;
  v_country_record cur_country%ROWTYPE;
BEGIN
  OPEN cur_country(2);
  LOOP
    FETCH cur_country INTO v_country_record;
    EXIT WHEN cur_country%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_country_record.country_id||   ' '|| v_country_record.country_name);
  END LOOP;
  CLOSE cur_country;
END;
/
--13
DECLARE
  v_deptid employees.department_id%TYPE;
  CURSOR cur_emps(p_deptid NUMBER) IS 
  SELECT employee_id, salary
  FROM employees
  WHERE department_id= p_deptid;
  v_emp_rec cur_emps%ROWTYPE;
BEGIN
  SELECT MAX (department_id) INTO v_deptid
  FROM employees;
  OPEN cur_emps(v_deptid);
    LOOP
    FETCH cur_emps INTO v_emp_rec;
    EXIT WHEN cur_emps%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_emp_rec.employee_id|| '  '|| v_emp_rec.salary);
    END LOOP;
  CLOSE cur_emps;
END;
/

DECLARE
  CURSOR  cur_countries(p_region_id NUMBER, p_population NUMBER) IS
  SELECT  country_id, country_name, population
  FROM    wf_countries
  WHERE   region_id= p_region_id and     population > p_population;
BEGIN 
  FOR v_country_record IN  cur_countries(145,10000000) LOOP
  DBMS_OUTPUT.PUT_LINE(v_country_record.country_id||' '|| v_country_record. country_name||' '|| v_country_record.population);
  END LOOP;
END;
/
--16
DECLARE
  CURSOR cur_emps(p_job VARCHAR2, p_salary NUMBER) IS
  SELECT  employee_id, last_name
  FROM    employees
  WHERE   job_id = p_job or salary> p_salary;
BEGIN
  FOR v_emp_record IN  cur_emps('IT_PROG', 10000) LOOP
  DBMS_OUTPUT.PUT_LINE(v_emp_record.employee_id||' '|| v_emp_record.last_name);
  END LOOP;
END;
/

--5.5
--slide 7
create table my_employees as select * from employees;
create table my_departments as select * from departments;

DECLARE
  CURSOR cur_emps IS
  SELECT  employee_id, last_name
  FROM    my_employees
  WHERE   department_id = 80 FOR UPDATE;
  v_emp_rec cur_emps%rowtype;
BEGIN
  open cur_emps;
    loop
    fetch cur_emps into v_emp_rec;
    exit when cur_emps%notfound;
    update my_employees
    set last_name = v_emp_rec.last_name || ' update'
    where department_id = 80;
    end loop;
  close cur_emps;
END;
/
 SELECT  employee_id, last_name
  FROM    my_employees
  WHERE   department_id = 80;

/
DECLARE
  CURSOR cur_emps IS
  SELECT  employee_id, last_name
  FROM    my_employees
  WHERE   department_id = 80 FOR UPDATE wait 5;
  v_emp_rec cur_emps%rowtype;
BEGIN
  open cur_emps;
    loop
    fetch cur_emps into v_emp_rec;
    exit when cur_emps%notfound;
    update my_employees
    set last_name = v_emp_rec.last_name || ' update'
    where department_id = 80;
    end loop;
  close cur_emps;
END;
/
--9
DECLARE
  CURSOR emp_cursor IS
  SELECT  e.employee_id, d.department_name
  FROM    my_employees e, my_departments d
  WHERE   e.department_id = d.department_id
  and d.department_id = 80 FOR UPDATE of salary;
  v_emp_dept_rec emp_cursor%rowtype;
BEGIN
  open emp_cursor;
    loop
    fetch emp_cursor into v_emp_dept_rec;
    exit when emp_cursor%notfound;
    update my_departments
    set department_name = v_emp_dept_rec.department_name || ' update'
    where department_id = 80;
    end loop;
  close emp_cursor;
END;
/

--13
DECLARE
CURSOR cur_emps IS
SELECT employee_id, salary
FROM my_employees
WHERE salary <=20000
FOR UPDATE NOWAIT;
v_emp_rec cur_emps%ROWTYPE;
BEGIN
OPEN cur_emps;
LOOP
FETCH cur_emps INTO v_emp_rec;
EXIT WHEN cur_emps%NOTFOUND;
UPDATE my_employees
SET salary = v_emp_rec.salary*1.1
WHERE CURRENT OF cur_emps;
END LOOP;
CLOSE cur_emps;
END;
/
--14
DECLARE
  CURSOR cur_eds IS
  SELECT employee_id, salary, department_name
  FROM my_employees e, my_departments d
  WHERE e.department_id = d.department_id
  FOR UPDATE OF salary NOWAIT;
BEGIN
  FOR v_eds_rec IN cur_eds LOOP
  UPDATE my_employees 
  SET salary = v_eds_rec.salary* 1.1
  WHERE CURRENT OF cur_eds;
  END LOOP;
END;
/

--5.6
DECLARE 
CURSOR cur_dept IS 
select department_id, department_name
from departments
order by department_name;

CURSOR cur_emp (p_deptid NUMBER) IS 
select first_name, last_name
from employees
where department_id=p_deptid
order by last_name;
v_deptrec  cur_dept%ROWTYPE;
v_emprec  cur_emp%ROWTYPE;
BEGIN
OPEN cur_dept;
LOOP
FETCH cur_dept INTO v_deptrec;
EXIT WHEN cur_dept%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(v_deptrec.department_name);
OPEN cur_emp(v_deptrec.department_id);
LOOP
FETCH cur_emp INTO v_emprec;
EXIT WHEN cur_emp%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(v_emprec.last_name || ' ' ||v_emprec.first_name);
DBMS_OUTPUT.PUT_LINE('');
END LOOP; 
CLOSE cur_emp;
END LOOP;
CLOSE cur_dept;
END;
/
--11
DECLARE 
CURSOR cur_loc IS 
SELECT * FROM locations;
CURSOR cur_dept (p_locid NUMBER) IS 
SELECT * FROM departments 
WHERE location_id = p_locid;
v_locrec  cur_loc%ROWTYPE;
v_deptrec cur_dept%ROWTYPE;
BEGIN
OPEN cur_loc;
LOOP
FETCH cur_loc INTO v_locrec;
EXIT WHEN cur_loc%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(v_locrec.city);
OPEN cur_dept (v_locrec.location_id);
LOOP
FETCH cur_dept INTO v_deptrec;
EXIT WHEN cur_dept%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(v_deptrec.department_name);
DBMS_OUTPUT.PUT_LINE('');
END LOOP; 
CLOSE cur_dept;
END LOOP;
CLOSE cur_loc;
END;
/
--12
DECLARE 
CURSOR cur_loc IS 
SELECT * FROM locations;
CURSOR cur_dept(p_locid NUMBER) IS 
SELECT * FROM departments 
WHERE location_id = p_locid;
BEGIN
FOR v_locrec IN cur_loc
LOOP
DBMS_OUTPUT.PUT_LINE(v_locrec.city);
FOR v_deptrec IN cur_dept(v_locrec.location_id)
LOOP
DBMS_OUTPUT.PUT_LINE(v_deptrec.department_name);
DBMS_OUTPUT.PUT_LINE('');
END LOOP; 
END LOOP;
END;
/
--slide 13
DECLARE 
CURSOR cur_dept IS 
SELECT * FROM my_departments;
CURSOR cur_emp(p_dept_id NUMBER) IS 
SELECT * FROM my_employees 
WHERE department_id = p_dept_id
FOR UPDATE NOWAIT;
BEGIN
FOR v_deptrec IN cur_dept 
LOOP
DBMS_OUTPUT.PUT_LINE(v_deptrec.department_name);
FOR v_emprec IN cur_emp (v_deptrec.department_id) 
LOOP
DBMS_OUTPUT.PUT_LINE(v_emprec.last_name);
IF v_deptrec.location_id = 1700 AND v_emprec.salary < 10000
THEN UPDATE my_employees SET   salary = salary * 1.1
WHERE CURRENT OF cur_emp;
END IF;
END LOOP; 
END LOOP;
END;