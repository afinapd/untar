set serveroutput on

CREATE TABLE excep_emps  AS SELECT * FROM employees;

DECLARE   
	v_dept_id  excep_emps.department_id%TYPE;   
	v_count       NUMBER;  
BEGIN   
	v_dept_id := 40;   
	SELECT COUNT(*) INTO v_count     
	FROM excep_emps     WHERE department_id = v_dept_id;   

	DBMS_OUTPUT.PUT_LINE('There are ' || v_count || ' employees');  
 
	DELETE FROM excep_emps     WHERE department_id = v_dept_id;
   
	DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' employees were deleted');  
  
	ROLLBACK; 
END;
/

declare   
	v_dept_id  excep_emps.department_id%type;   
	v_count       number; 
  no_data_found exception;
begin   
	v_dept_id := 40;   
	select count(*) into v_count     
	from excep_emps     where department_id = v_dept_id;   
	dbms_output.put_line('There are ' || v_count || ' employees');  
	delete from excep_emps     where department_id = v_dept_id;
	dbms_output.put_line(sql%rowcount || ' employees were deleted');
  if sql%notfound then
  raise no_data_found; 
  end if;
  exception
  when no_data_found then   
  dbms_output.put_line('no data with the dept_id : ' ||  v_dept_id || ' in the table');
  when others then
  dbms_output.put_line('There is no employee with this dept id that could be deleted');
	rollback; 
end;
/

declare   
	v_dept_id  excep_emps.department_id%type;   
	v_count       number; 
  no_data_found exception;
begin   
	v_dept_id := 20;   
	select count(*) into v_count     
	from excep_emps     where department_id = v_dept_id;   
	dbms_output.put_line('There are ' || v_count || ' employees');  
	delete from excep_emps     where department_id = v_dept_id;
	dbms_output.put_line(sql%rowcount || ' employees were deleted');
  if sql%notfound then
  raise_application_error(-20203, 'no data with the dept_id : ' ||  v_dept_id || ' in the table');
  else
  raise_application_error(-20204, 'There is no employee with this dept id that could be deleted');
  end if;
	rollback; 
end;

/

declare   
	v_dept_id  excep_emps.department_id%type;   
	v_count        number; 
  v_count_update number; 
  no_data_found  exception;
  invalid_exc    exception;
begin   
	v_dept_id := 40;   
  select count(*) into v_count     
	from excep_emps     where department_id = v_dept_id; 
  if v_count = 0 then
    raise no_data_found;
  else
    delete from excep_emps     where department_id = v_dept_id;
    select count(*) into v_count_update     
    from excep_emps     where department_id = v_dept_id; 
    if v_count_update = 0 then
      dbms_output.put_line(v_count || ' employees were deleted');
    else
      raise invalid_exc;
    end if;
  end if;
  
  exception
  when no_data_found then
  dbms_output.put_line('no data with the dept_id : ' ||  v_dept_id || ' in the table');
  when invalid_exc then
  dbms_output.put_line('There is no employee with this dept id that could be deleted');
  rollback;
end;
/

declare   
	v_dept_id  excep_emps.department_id%type;   
	v_count        number; 
  v_count_update number; 
begin   
	v_dept_id := 40;   
  select count(*) into v_count     
	from excep_emps     where department_id = v_dept_id; 
  if v_count = 0 then
    raise_application_error(-20203, 'no data with the dept_id : ' ||  v_dept_id || ' in the table');
  else
    delete from excep_emps     where department_id = v_dept_id;
    select count(*) into v_count_update     
    from excep_emps     where department_id = v_dept_id; 
    if v_count_update = 0 then
      dbms_output.put_line(v_count || ' employees were deleted');
    else
      raise_application_error(-20204, 'There is no employee with this dept id that could be deleted');
    end if;
  end if;
  rollback;
end;