set serveroutput on

--9.3
select object_name, object_type, status 
from user_objects
order by object_type;

select object_name, object_type, status, owner 
from all_objects
where object_type in ('FUNCTION', 'PROCEDURE')
order by object_type;

select * from dict
where table_name like '%VIEW%';
/

--9.4
CREATE TABLE my_depts AS SELECT * FROM departments; 
ALTER TABLE my_depts 
   ADD CONSTRAINT my_dept_id_pk PRIMARY KEY (department_id);
/

CREATE OR REPLACE PROCEDURE add_my_dept (
   p_dept_id IN VARCHAR2, 
   p_dept_name IN VARCHAR2) IS 
BEGIN
   INSERT INTO my_depts (department_id, department_name) 
   VALUES (p_dept_id, p_dept_name);
END add_my_dept;
/
begin
  add_my_dept(10, 'afina');
end;
/

--modify
CREATE OR REPLACE PROCEDURE add_my_dept (
   p_dept_id IN VARCHAR2, 
   p_dept_name IN VARCHAR2) IS 
BEGIN
   INSERT INTO my_depts (department_id, department_name) 
   VALUES (p_dept_id, p_dept_name);
   EXCEPTION WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('ERROR');
END add_my_dept;
/
begin
  add_my_dept(10, 'afina');
end;
/

CREATE OR REPLACE PROCEDURE add_my_dept (
   p_dept_id IN VARCHAR2, 
   p_dept_name IN VARCHAR2) IS 
BEGIN
   INSERT INTO my_depts (department_id,department_name) 
   VALUES (p_dept_id, p_dept_name);
END add_my_dept;
/

CREATE OR REPLACE PROCEDURE outer_proc IS 
   v_dept	NUMBER(2)	:= 10;
   v_dname	VARCHAR2(30)	:= 'Admin'; 
BEGIN
   add_my_dept(v_dept, v_dname); 
EXCEPTION WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Exception was propagated to outer_proc');
END;

/
begin
  outer_proc();
end;
/

select object_name
from user_objects
where object_type = 'PROCEDURE';
/

drop procedure outer_proc;
/

select text from user_source
where name = 'ADD_MY_DEPT'
order by line;