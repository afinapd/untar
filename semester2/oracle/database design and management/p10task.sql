set serveroutput on

CREATE TABLE employees_dup AS SELECT * from employees;

CREATE OR REPLACE PROCEDURE name_change IS 
BEGIN
   UPDATE employees_dup 
   SET first_name = 'Susan' 
   WHERE department_id = 80;
END name_change;
/

BEGIN
   name_change; 
END;
/

select first_name, department_id from employees_dup where department_id = 80;
/
--procedure
CREATE OR REPLACE PROCEDURE pay_raise IS 
BEGIN
   UPDATE employees_dup 
   SET salary = 30000;
END pay_raise;
/
--main
BEGIN
   pay_raise; 
END;
/

--check that the procedure 
select first_name, salary 
from employees_dup;
/

CREATE OR REPLACE PROCEDURE name_change IS 
BEGIN
   UPDATE employees_dup 
   SET first_name = 'Susan' 
   WHERE department_id = 80;
END name_change;
/
--procedure
CREATE OR REPLACE PROCEDURE update_salary IS 
BEGIN
   UPDATE employees_dup 
   SET salary = 1000 WHERE department_id = 80;
   UPDATE employees_dup 
   SET salary = 2000 WHERE department_id = 50;
   UPDATE employees_dup 
   SET salary = 3000 WHERE department_id NOT IN(80, 50);
END update_salary;
/ 

--main
BEGIN
   update_salary; 
END;
/

--check that the procedure 
SELECT department_id, salary 
from employees_dup;