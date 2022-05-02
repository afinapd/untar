set serveroutput on;
rollback;

DECLARE
  PROCEDURE p (
    salary  NUMBER,
    emp_id NUMBER
  )
  IS
    bonus  NUMBER := 0;
    new_salary  NUMBER := salary;

  BEGIN
    IF salary > 15000 THEN
      bonus := salary/10;
      new_salary := salary + bonus;
    ELSE
       DBMS_OUTPUT.PUT_LINE('tidak ada bonus');
    END IF;
 
    DBMS_OUTPUT.PUT_LINE('new salary = ' || new_salary);
 
    UPDATE employees
    SET salary = salary + bonus 
    WHERE employee_id = emp_id;
  END p;
BEGIN
  p(24000,1);
END;
/

DECLARE
  PROCEDURE p (
    salary  NUMBER ,
    emp_id NUMBER
  )
  IS
    bonus  NUMBER := 0;
    new_salary  NUMBER := salary;

  BEGIN
    CASE 
    WHEN salary > 15000 THEN
      bonus := salary/10;
      new_salary := salary + bonus;
    ELSE
       DBMS_OUTPUT.PUT_LINE('tidak ada bonus');
    END CASE;
 
    DBMS_OUTPUT.PUT_LINE('new salary = ' || new_salary);
 
    UPDATE employees
    SET salary = salary + bonus 
    WHERE employee_id = emp_id;
  END p;
BEGIN
  p(24000,1);
END;