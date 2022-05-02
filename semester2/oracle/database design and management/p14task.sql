set serveroutput on

create or replace trigger log_audit_table
after insert on emp1 
begin
  insert into audit_table(action, user_name, last_change_date)
  values ('Inserting',user, systimestamp ); 
end;
/

create or replace trigger log_audit_table
after insert or delete on emp1 
begin
  if inserting then
    insert into audit_table(action, user_name, last_change_date)
    values ('Inserting',user, systimestamp ); 
  elsif deleting then
    insert into audit_table(action, user_name, last_change_date)
    values ('Deleting',user, systimestamp ); 
  end if;
end;

/
insert into emp1 
values (58, 'Afina', 'Putri', 'afnpd03@gmail.com', '085772610027', TO_DATE(SYSDATE), 'AD_PRES', 3200, null, null, null, null);

select * from audit_table;

delete from emp1 
where employee_id = 58;

/

alter table audit_table add emp_id number(3);

create or replace trigger log_audit_table
after insert or delete on emp1 for each row
begin
  if inserting then
    insert into audit_table(action, user_name, last_change_date, emp_id)
    values ('Inserting', user, systimestamp, :new.employee_id); 
  elsif deleting then
    insert into audit_table(action, user_name, last_change_date, emp_id)
    values ('Deleting', user, systimestamp,:old.employee_id); 
  end if;
end;

/

CREATE TABLE dept_count
AS SELECT department_id dept_id, count(*) count_emps 
FROM employees
GROUP BY department_id;

CREATE VIEW emp_vu
AS SELECT employee_id, last_name, department_id 
FROM employees;

drop TABLE dept_count;
/
create or replace trigger count_trigger
instead of insert or delete on emp_vu for each row
begin
  if deleting then
    update dept_count set count_emps = count_emps - 1
    where dept_id = :old.department_id;
  elsif inserting then
    update dept_count set count_emps = count_emps +1
    where dept_id = :new.department_id;
  end if;
end;
/


select * from dept_count where dept_id = 90;

insert into emp_vu values(58, 'Afina', 90);

delete from emp_vu where employee_id = 100;

/
select * from all_triggers
where trigger_type in ('AFTER EVENT', 'BEFORE EVENT');

alter trigger PREVENT_DROP_TRIGG disable;

/

create or replace trigger log_audit_table
for update of salary on emp1 compound trigger
  log varchar2(200);
  before each row is begin
    insert into audit_table(action, user_name, last_change_date, emp_id)
    values ('Updating', user, systimestamp, :new.employee_id);
  end before each row;
  after each row is begin
    log := 'Update complete; old salary ' || to_char(:old.salary) || '; new salary ' || to_char(:new.salary); 
    insert into audit_table(action, user_name, last_change_date, emp_id)
    values (log, user, systimestamp, :new.employee_id);
  end after each row;
end log_audit_table;
/
update emp1
set salary = 1200
where employee_id = 124;

select * from emp1 WHERE employee_id = 124;

select * from audit_table;