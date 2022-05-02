set serveroutput on

CREATE TABLE audit_table
(action	VARCHAR2(50),
user_name	VARCHAR2(30) DEFAULT USER,
last_change_date	TIMESTAMP DEFAULT SYSTIMESTAMP);

drop table audit_table;

/

create or replace trigger log_audit_table
after insert on emp1 
begin
  insert into audit_table(action, user_name, last_change_date)
  values ('Inserting',user, systimestamp ); 
end;
/
select * from audit_table; 


--update
create or replace trigger log_audit_table
before update on emp1 
begin
  insert into audit_table(action, user_name, last_change_date)
  values ('Updating',user, systimestamp ); 
end;
/

update emp1
set first_name = 'afina'
where employee_id = 301;
/

select * from audit_table;
/

create or replace trigger log_audit_table
before update on emp1 
begin
  insert into audit_table(action, user_name, last_change_date)
  values ('Updating', user, systimestamp); 
  if (to_char(sysdate, 'HH24') < '16:00' or to_char(sysdate, 'HH24') > '18:00') then
    raise_application_error(-20500,'you may insert into employees table only between 8 am and 6 pm');
  end if;
end;
/
SELECT to_char(sysdate, 'HH24:MI') FROM dual;
/

update emp1 set salary = 25000
where employee_id = 100;

select * from emp1;