set serveroutput on

--Jawaban No. 1
DECLARE
  TYPE rec_departments IS RECORD(
  v_location_id        departments.location_id%TYPE,
  v_department_id      departments.department_id%TYPE,
  v_department_name    departments.department_name%TYPE );
  v_location_id        NUMBER := '&x';
  TYPE tab_departments IS TABLE OF rec_departments;
  v_department_rec     tab_departments;
BEGIN
  SELECT location_id, department_id, department_name
  BULK COLLECT INTO v_department_rec
  FROM departments 
  WHERE location_id = v_location_id;
  dbms_output.put_line('====== Departments on Location ' || v_location_id || ' ======');
  FOR i IN v_department_rec.FIRST .. v_department_rec.LAST LOOP
   dbms_output.put_line(v_department_rec(i).v_department_id || ' ' || v_department_rec(i).v_department_name);
  END LOOP;
END;
/


--Jawaban No. 2
CREATE OR REPLACE PROCEDURE proc_count_salary(
  p_job_id            employees.job_id%TYPE
) IS
  v_count             NUMBER;
  v_avg_salary        employees.salary%TYPE;
  v_min_salary        employees.salary%TYPE;
  v_max_salary        employees.salary%TYPE;
BEGIN
  SELECT COUNT(*), AVG(salary), MIN(salary), MAX(salary)
  INTO v_count, v_avg_salary, v_min_salary, v_max_salary
  FROM employees
  WHERE job_id = p_job_id; 
    dbms_output.put_line('Data gaji karyawan sebagai ' || p_job_id); 
    dbms_output.put_line('Jumlah karyawan : ' || v_count); 
    dbms_output.put_line('Gaji rata-rata : ' || v_avg_salary); 
    dbms_output.put_line('Gaji terendah  : ' || v_min_salary);
    dbms_output.put_line('Gaji tertinggi : ' || v_max_salary);
END proc_count_salary;
/
BEGIN
  proc_count_salary('SA_REP');
END;
/


--Jawaban No. 3
CREATE OR REPLACE PROCEDURE proc_employee(
  p_manager_id    employees.manager_id%TYPE,
  p_department_id employees.department_id%TYPE
) IS
  v_first_name    employees.first_name%TYPE;
  v_last_name     employees.last_name%TYPE;
  v_salary        employees.salary%TYPE;
  v_employee_id   employees.employee_id%TYPE;
BEGIN
  SELECT employee_id, first_name, last_name, salary 
  INTO v_employee_id, v_first_name, v_last_name, v_salary
  FROM employees
  WHERE manager_id = p_manager_id AND department_id = p_department_id;
    dbms_output.put_line('Karyawan yang bekerja untuk manager ' || p_manager_id || ' pada dept ' || p_department_id);
    dbms_output.put_line(v_employee_id || ' - ' || v_first_name || ' ' || v_last_name || ' - ' || v_salary);
  EXCEPTION WHEN too_many_rows THEN
    dbms_output.put_line('Output lebih dari satu baris data');
END proc_employee;
/
--only one row in this id manager and department
BEGIN
  proc_employee(101, 10);
END;
/
--EXCEPTION : too many rows in this id manager and department
BEGIN
  proc_employee(149, 80);
END;
/


--Jawaban No. 4
--specification
CREATE OR REPLACE PACKAGE pkg_bonus_hire IS
 FUNCTION bonus(
  p_employee_id employees.employee_id%type) 
  RETURN employees.salary%TYPE;
 FUNCTION hire(
  p_employee_id employees.employee_id%type) 
  RETURN NUMBER;
END  pkg_bonus_hire;
/
--body
CREATE OR REPLACE PACKAGE BODY pkg_bonus_hire AS
  FUNCTION bonus(p_employee_id employees.employee_id%TYPE)
  RETURN employees.salary%TYPE AS v_bonus employees.salary%TYPE;
  BEGIN
    SELECT salary * 0.10 INTO v_bonus 
    FROM employees 
    WHERE employee_id = p_employee_id;
    RETURN v_bonus;
    dbms_output.put_line(v_bonus);
  END bonus;
  FUNCTION hire(p_employee_id employees.employee_id%TYPE) 
  RETURN NUMBER AS v_hire NUMBER;
  BEGIN
    SELECT EXTRACT (YEAR FROM SYSDATE) - EXTRACT (YEAR FROM hire_date) INTO v_hire 
    FROM employees 
    WHERE employee_id = p_employee_id;
    RETURN v_hire;
    dbms_output.put_line(v_hire);
  END hire;
END pkg_bonus_hire;
/
--calling environment
DECLARE 
  v_employee_id employees.employee_id%TYPE := '&x';
  v_first_name  employees.first_name%TYPE;
  v_last_name   employees.last_name%TYPE;
  v_bonus       employees.salary%TYPE;
  v_hire        NUMBER;
BEGIN
   SELECT first_name, last_name INTO v_first_name, v_last_name 
   FROM employees WHERE employee_id = v_employee_id;
   v_bonus := pkg_bonus_hire.bonus(v_employee_id);
   v_hire := pkg_bonus_hire.hire(v_employee_id);
   dbms_output.put_line('Data of employee ' || v_first_name || ' ' || v_last_name); 
   dbms_output.put_line('Bonus $ : ' || v_bonus); 
   dbms_output.put_line('Work Periode : ' || v_hire || ' Years');
END; 